# Repository guidance

## Overview and layout

Personal dotfiles for macOS (primary) and Linux. This is a configuration repository, not an application with a build pipeline. Read `README.md`, `Makefile`, and the relevant installer before changing setup behavior. `CLAUDE.md` and `CRUSH.md` provide additional repository context; verify their descriptions against the scripts.

- `zsh/`: Prezto, Powerlevel10k, shell startup, and macOS/Linux overrides.
- `bash/` and `common/`: Bash configuration, helper functions, shared aliases, tmux, and screen settings.
- `nvim/`: Vimscript configuration, plugin declarations, and CoC settings. Prefer `local_init.vim` for custom settings and `local_bundles.vim` for additional plugins.
- `installer/`: bootstrap, platform package installation, symlinks, and Go package list.
- `homebrew/Brewfile`: macOS package declarations.
- `git/`, `ssh/`, `ipython/`: tool configuration.
- `iterm/`, `warp/`, `zellij/`, `fonts/`: terminal profiles, themes, layouts, and fonts.
- `bin/`: custom utilities; `server_config/`: machine-specific server configuration.

## Installation and side effects

Run Make targets from the repository root. Installers assume the checkout lives at `~/.dotfiles`, regardless of the current checkout location. `installer/linkfiles.sh` is the source of truth for destination paths; it links individual Neovim files, not the entire directory.

- `make init`: creates directories in the home directory.
- `make install`: runs initialization and the bootstrap, installing packages and tools, cloning plugins, and linking configuration.
- `make update-links`: force-updates configuration symlinks in the home directory.
- `make update-vim-plugins`: invokes `vim` to install plugins and update remote plugins.
- `make clean`: recursively deletes home directories including `~/bin`, `~/gopaths/global`, `~/.config/nvim`, `~/.zprezto`, `~/.tmux`, `~/.emacs.d`, and `~/.doom.d`. It is not limited to removing symlinks.

These are machine-changing operations, not test commands. Run them only when the task calls for their effects. Bootstrap can overwrite the linked Neovim configuration with downloaded output. Inspect scripts and existing destinations before running installation or cleanup.

The README lists historical macOS, Ubuntu, and Arch testing. Do not infer current platform support from that list: the Linux dispatcher currently implements the apt branch and rejects yum and pacman branches.

## Editing conventions

- Keep changes focused on the requested tools and preserve unrelated local edits, especially terminal profile data.
- Follow the surrounding file's indentation and syntax. Use `#!/usr/bin/env bash` for new Bash installers; Bash-specific syntax is allowed. Validate Zsh files with Zsh, not Bash.
- Quote variable expansions used as paths or arguments. Check optional commands and sourced files before using them, and provide clear failures for missing prerequisites.
- Keep shared behavior in shared configuration and platform-specific behavior in `zsh/maczshrc`, `zsh/linuxzshrc`, or the appropriate installer. Preserve `${OSTYPE}` dispatch where used.
- Preserve shell startup ordering, lazy initialization, and existing IDE/terminal guards unless the task explicitly changes them.
- When adding a deployed configuration, update the symlink script and ensure its destination parent exists. Confirm source paths actually exist; existing mappings may be stale.
- Keep secrets out of tracked configuration. Shell startup already supports the local `~/.user_env_pass` file. Do not copy local credentials or private keys into the repository.
- Update `README.md` when user-facing setup commands or requirements change.

## Validation

There is no repository-wide automated test suite or configured lint target. Use focused checks without installing or sourcing the full environment:

```sh
# Parse a changed Bash installer without executing it.
bash -n installer/linkfiles.sh

# Parse changed Zsh startup files without loading user startup configuration.
zsh -f -n zsh/zshrc
zsh -f -n zsh/zprofile

# Preview a Make recipe without performing its actions.
make -n update-links

# Check tracked changes for whitespace errors.
git diff --check
```

Substitute the changed files as appropriate. Use format-specific validators when available, such as `plutil -lint` for plist files. Avoid launching a configured editor or interactive shell as a generic test: startup can load plugins, credentials, and external tools. Report the checks performed and any platform behavior that remains untested.
