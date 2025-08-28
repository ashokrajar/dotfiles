# Dotfiles Repository - Coding Agent Instructions

## Build/Test/Lint Commands
```bash
make install        # Full installation of dotfiles and dependencies
make update-links   # Update only the dotfile symlinks
make update-vim-plugins  # Update Vim/Neovim plugins
make clean         # Uninstall dotfiles and clean directories
make init          # Initialize required directories
```

## Code Style Guidelines

### Shell Scripts (.sh files)
- Use `#!/usr/bin/env bash` shebang for portability
- Follow POSIX-compliant syntax where possible
- Use double brackets `[[ ]]` for conditionals
- Quote variables: `"${VAR}"` to prevent word splitting
- Use `-sf` flags for `ln` commands to force symlink creation
- Check OS type with `${OSTYPE}` (darwin* for macOS, linux* for Linux)
- Exit with meaningful codes: 0 for success, 1 for errors

### File Organization
- Configuration files grouped by tool: `bash/`, `zsh/`, `nvim/`, `git/`, etc.
- Installation scripts in `installer/` directory
- Common configs in `common/` directory
- Platform-specific configs use prefixes: `mac*`, `linux*`

### Error Handling
- Check command existence: `command -v <cmd> &> /dev/null`
- Provide clear error messages before `exit 1`
- Use `echo -en` for formatted output messages