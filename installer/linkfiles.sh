#!/usr/bin/env bash

# Link all dotfiles
echo -en "Linking dotfiles .....\n"
# tmux
ln -sf ~/.dotfiles/common/tmux.conf ~/.tmux.conf
ln -sf ~/.dotfiles/common/local_aliases ~/.local_aliases
ln -sf ~/.dotfiles/common/helper_functions.sh ~/.shell_helper_functions.sh
ln -sf ~/.dotfiles/common/screenrc ~/.screenrc

# git
ln -sf ~/.dotfiles/git/gitconfig ~/.gitconfig
ln -sf ~/.dotfiles/git/gitignore_global ~/.gitignore_global

# nvim
ln -sf ~/.dotfiles/nvim/init.vim ~/.config/nvim/init.vim
ln -sf ~/.dotfiles/nvim/local_init.vim ~/.config/nvim/local_init.vim
ln -sf ~/.dotfiles/nvim/local_bundles.vim ~/.config/nvim/local_bundles.vim
ln -sf ~/.dotfiles/nvim/coc-settings.json ~/.config/nvim/coc-settings.json

# ipython
ln -sf ~/.dotfiles/ipython/ipython_config.py ~/.ipython/profile_default/ipython_config.py

# ssh
ln -sf ~/.dotfiles/ssh/config ~/.ssh/config

# zsh
ln -sf ~/.dotfiles/zsh/zshrc ~/.zshrc
ln -sf ~/.dotfiles/zsh/zpreztorc ~/.zpreztorc
ln -sf ~/.dotfiles/zsh/zprofile ~/.zprofile
ln -sf ~/.dotfiles/zsh/p10k.zsh ~/.p10k.zsh
ln -sf ~/.dotfiles/zsh/p10k-warp.zsh ~/.p10k-warp.zsh

# warp
ln -sf ~/.dotfiles/warp/themes ~/.warp/themes

# OS specific zshrc
if [[ "${OSTYPE}" == darwin* ]]; then
    ln -sf ~/.dotfiles/zsh/maczshrc ~/.maczshrc
elif [[ "${OSTYPE}" == linux* ]]; then
    ln -sf ~/.dotfiles/zsh/linuxzshrc ~/.linuxzshrc
fi

