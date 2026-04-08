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

All dotfiles are cloned to `~/.dotfiles` and symlinked:
- `~/.zshrc` → `zsh/zshrc`
- `~/.maczshrc` → `zsh/maczshrc` (macOS only)
- `~/.linuxzshrc` → `zsh/linuxzshrc` (Linux only)
- `~/.gitconfig` → `git/gitconfig`
- `~/.config/nvim/` → `nvim/`
- `~/.ssh/config` → `ssh/config`
- `~/.warp/themes` → `warp/themes`

## Notes

- Shell: zsh with zprezto framework and Powerlevel10k prompt
- Editor: Cursor (default), Neovim available as `vim`
- macOS is the primary development platform
- Do not commit secrets to `zsh/zshrc` — source a local untracked file (e.g. `~/.user_env_pass`) instead
