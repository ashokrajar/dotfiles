#!/usr/bin/env bash
#
# Idempotent, non-interactive setup for Cursor Cloud Agent environments.
#
# Unlike installer/bootstrap.sh (which targets a developer's personal macOS/
# Linux machine), this script provisions a headless Ubuntu VM so the dotfiles
# repository is immediately usable by a Cloud Agent: it installs the pinned
# toolchains (Go via goenv, Python via pyenv), the zsh/prezto/fzf/tmux stack,
# and symlinks every dotfile via the repository's own installer/linkfiles.sh.
#
# It is safe to run repeatedly.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

GO_VERSION="1.23.4"
PYTHON_VERSION="3.12.9"

log() { printf '\n==> %s\n' "$*"; }

# ---------------------------------------------------------------------------
# 1. System packages (stable, cached by environment builds)
# ---------------------------------------------------------------------------
log "Installing system packages"
sudo apt-get update -qq
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    ca-certificates git curl wget make build-essential locales \
    zsh neovim tmux fzf fd-find bat \
    libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
    libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

sudo locale-gen en_US.UTF-8 >/dev/null 2>&1 || true

# ---------------------------------------------------------------------------
# 2. Point ~/.dotfiles at the checked-out repository
#    installer/linkfiles.sh resolves every symlink target under ~/.dotfiles.
# ---------------------------------------------------------------------------
log "Linking ~/.dotfiles -> ${REPO_DIR}"
if [[ "$(readlink "${HOME}/.dotfiles" 2>/dev/null)" != "${REPO_DIR}" ]]; then
    rm -rf "${HOME}/.dotfiles"
    ln -s "${REPO_DIR}" "${HOME}/.dotfiles"
fi

# ---------------------------------------------------------------------------
# 3. Version managers + pinned toolchains
# ---------------------------------------------------------------------------
log "Installing goenv + Go ${GO_VERSION}"
if [[ ! -d "${HOME}/.goenv" ]]; then
    git clone --depth 1 https://github.com/go-nv/goenv.git "${HOME}/.goenv"
fi
export GOENV_ROOT="${HOME}/.goenv"
export PATH="${GOENV_ROOT}/bin:${PATH}"
goenv install -s "${GO_VERSION}"
goenv global "${GO_VERSION}"

log "Installing pyenv + Python ${PYTHON_VERSION}"
if [[ ! -d "${HOME}/.pyenv" ]]; then
    curl -fsSL https://pyenv.run | bash
fi
export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PYENV_ROOT}/bin:${PATH}"
pyenv install -s "${PYTHON_VERSION}"
pyenv global "${PYTHON_VERSION}"

# ---------------------------------------------------------------------------
# 4. Shell + terminal tooling
# ---------------------------------------------------------------------------
log "Installing zprezto"
if [[ ! -s "${HOME}/.zprezto/.git/config" ]]; then
    git clone --quiet --recursive https://github.com/sorin-ionescu/prezto.git "${HOME}/.zprezto"
    git clone --quiet --recurse-submodules https://github.com/belak/prezto-contrib "${HOME}/.zprezto/contrib"
fi

log "Installing zsh-autosuggestions"
if [[ ! -s "${HOME}/.zsh-autosuggestions/.git/config" ]]; then
    git clone --quiet https://github.com/zsh-users/zsh-autosuggestions "${HOME}/.zsh-autosuggestions"
fi

log "Installing fzf"
if [[ ! -d "${HOME}/.fzf" ]]; then
    git clone --quiet --depth 1 https://github.com/junegunn/fzf.git "${HOME}/.fzf"
    "${HOME}/.fzf/install" --all --completion --key-bindings --no-update-rc >/dev/null
fi

log "Installing tmux plugin manager"
mkdir -p "${HOME}/.tmux/plugins"
if [[ ! -s "${HOME}/.tmux/plugins/tpm/.git/config" ]]; then
    git clone --quiet https://github.com/tmux-plugins/tpm "${HOME}/.tmux/plugins/tpm"
fi

# ---------------------------------------------------------------------------
# 5. Create expected directories and symlink all dotfiles
# ---------------------------------------------------------------------------
log "Creating directories and linking dotfiles"
mkdir -p "${HOME}/bin" "${HOME}/.config/nvim" "${HOME}/.tmux/plugins/tmp" \
    "${HOME}/gopaths/global" "${HOME}/.ipython/profile_default" "${HOME}/.warp"
mkdir -p "${HOME}/.ssh" && chmod 700 "${HOME}/.ssh"
"${REPO_DIR}/installer/linkfiles.sh"

# ---------------------------------------------------------------------------
# 6. Keep git usable for Cloud Agents
#
#    installer/linkfiles.sh symlinks ~/.gitconfig straight at the repo file.
#    Inside a Cloud Agent that is harmful: it discards the git credentials the
#    agent needs to push, and any `git config --global ...` would then write
#    back into the tracked repository. Replace the symlink with a real global
#    config that *includes* the dotfiles gitconfig (so the settings still
#    apply) and restore the GitHub credential helper via the gh CLI.
# ---------------------------------------------------------------------------
log "Preserving git credentials"
if [[ -L "${HOME}/.gitconfig" ]]; then
    rm -f "${HOME}/.gitconfig"
    cat >"${HOME}/.gitconfig" <<EOF
[include]
	path = ${HOME}/.dotfiles/git/gitconfig
EOF
fi
if command -v gh >/dev/null 2>&1; then
    gh auth setup-git >/dev/null 2>&1 || \
        echo "WARN: 'gh auth setup-git' failed; git push may need manual credentials." >&2
fi

# ---------------------------------------------------------------------------
# 7. Neovim Python provider (best-effort)
#    nvim/local_init.vim sets g:python3_host_prog to the pyenv shim, and
#    nvim/coc-settings.json points python at a dedicated ~/.pyenv/versions/nvim
#    virtualenv. Provision both so the python3 host loads without errors.
# ---------------------------------------------------------------------------
log "Configuring Neovim Python provider (best-effort)"
pyenv rehash || true
"${PYENV_ROOT}/versions/${PYTHON_VERSION}/bin/pip" install --quiet pynvim >/dev/null 2>&1 || \
    echo "WARN: could not install pynvim into the host interpreter." >&2
if ! pyenv virtualenvs --bare 2>/dev/null | grep -qx nvim; then
    pyenv virtualenv "${PYTHON_VERSION}" nvim >/dev/null 2>&1 || true
fi
if [[ -x "${PYENV_ROOT}/versions/nvim/bin/pip" ]]; then
    "${PYENV_ROOT}/versions/nvim/bin/pip" install --quiet pynvim jedi >/dev/null 2>&1 || true
fi

# ---------------------------------------------------------------------------
# 8. Neovim plugins (best-effort; never fail the install)
# ---------------------------------------------------------------------------
log "Installing Neovim plugins (best-effort)"
if ! nvim --headless "+PlugInstall --sync" +qa >/dev/null 2>&1; then
    echo "WARN: Neovim plugin install did not fully complete; run :PlugInstall inside nvim to retry." >&2
fi

log "Cloud Agent setup complete"
