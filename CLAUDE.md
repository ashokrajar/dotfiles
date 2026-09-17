# Dotfiles

Personal dotfiles and configuration for macOS (primary), Ubuntu, and Arch Linux.

## Structure

| Directory | Purpose |
|-----------|---------|
| `bin/` | Custom scripts added to `~/bin` |
| `common/` | Shared configs: tmux, aliases, helper functions, screenrc |
| `fonts/` | Font files |
| `git/` | `gitconfig`, `gitignore_global` |
| `homebrew/` | Brewfile for macOS packages |
| `installer/` | Bootstrap and link scripts |
| `ipython/` | IPython config |
| `iterm/` | iTerm2 profiles/settings |
| `nvim/` | Neovim config |
| `ssh/` | SSH client config |
| `warp/` | Warp terminal themes |
| `zellij/` | Zellij config |
| `zsh/` | Zsh config: `zshrc`, `maczshrc`, `linuxzshrc`, `zpreztorc`, `zprofile`, p10k themes |

## Key Commands

```bash
make install       # Full bootstrap (install packages + link dotfiles)
make update-links  # Re-link dotfiles only (no package install)
make clean         # Remove all linked/created dirs
```

## Installation Flow

1. `make install` → `installer/bootstrap.sh`
2. Detects OS (macOS runs `brew-install.sh`, Linux runs `linux-install.sh`)
3. Installs pyenv + Python 3.12.9, goenv + Go 1.23.4
4. Clones zprezto, FZF, tmux plugin manager
5. Runs `installer/linkfiles.sh` to symlink all configs into `~`

## Symlink Targets

`installer/linkfiles.sh` is the source of truth for destination paths — check it before assuming a mapping. It links individual files, not whole directories (e.g. nvim config is four separate symlinks, not `~/.config/nvim/` as a directory). Installers assume the checkout lives at `~/.dotfiles` regardless of where this repo is actually cloned.

- `~/.zshrc`, `~/.zpreztorc`, `~/.zprofile`, `~/.p10k.zsh`, `~/.p10k-warp.zsh` → `zsh/*`
- `~/.maczshrc` → `zsh/maczshrc` (macOS only) / `~/.linuxzshrc` → `zsh/linuxzshrc` (Linux only)
- `~/.gitconfig`, `~/.gitignore_global` → `git/*`
- `~/.config/nvim/{init.vim,local_init.vim,local_bundles.vim,coc-settings.json}` → `nvim/*` (individually linked)
- `~/.ssh/config` → `ssh/config`
- `~/.warp/themes` → `warp/themes`
- `~/.tmux.conf`, `~/.local_aliases`, `~/.shell_helper_functions.sh`, `~/.screenrc` → `common/*`
- `~/.ipython/profile_default/ipython_config.py` → `ipython/ipython_config.py`

## Validation

There is no build/lint/test suite — this is a config repo. Use syntax-only checks instead of sourcing/executing files (which would load plugins, credentials, or external tools):

```sh
bash -n installer/linkfiles.sh   # parse a changed installer without running it
zsh -f -n zsh/zshrc              # parse a changed zsh file without loading user startup
make -n update-links             # preview a Make recipe without performing it
plutil -lint iterm/xlarge_conf/com.googlecode.iterm2.plist   # plist files
git diff --check                 # whitespace errors
```

## Notes

- Shell: zsh with zprezto framework and Powerlevel10k prompt
- Editor: Cursor (default), Neovim available as `vim`
- macOS is the primary development platform. The Linux path only implements the `apt` branch (`installer/linux-install.sh`) — `yum` and `pacman` branches exit with "Not yet implemented" despite `pacman/` scripts existing in `installer/`.
- Do not commit secrets to `zsh/zshrc` — source a local untracked file (e.g. `~/.user_env_pass`) instead
- `make clean` is destructive beyond symlinks: it recursively removes `~/bin`, `~/gopaths/global`, `~/.config/nvim`, `~/.zprezto`, `~/.tmux`, `~/.emacs.d`, and `~/.doom.d`. Treat `make install`/`make clean` as machine-changing operations, not test commands — inspect scripts and existing destinations before running them.
- Preserve `${OSTYPE}` dispatch (`darwin*`/`linux*`) when editing installers; keep shared behavior in shared config and platform-specific behavior in `zsh/maczshrc`, `zsh/linuxzshrc`, or the matching installer.
