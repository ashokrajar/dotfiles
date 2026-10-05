dotfiles
========

dot files and configs.

:( shouldn't these files be hidden

# Tested on

* macOS 10.15.X
* Ubuntu 18.04
* Archlinux

# Usage/Installion

Ensure your shell is a zsh & you have make installed

```bash
git clone git@github.com:ashokrajar/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

make install
```

# Update only the dotfiles

```bash
make update-links
```

# Update VIM Plugins

```bash
make update-vim-plugins
```

# Editor setup (Neovim + Zellij + iTerm2)

See [docs/neovim-zellij-iterm.md](docs/neovim-zellij-iterm.md) for the LazyVim migration, the Zellij IDE layout and the remaining iTerm2/Zellij integration steps.

# UnInstall

```bash
make clean
```

