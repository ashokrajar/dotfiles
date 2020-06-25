#!/usr/bin/env bash

# Install core packages/libraries
if [[ "${OSTYPE}" == darwin* ]]; then
    brew-install.sh
elif [[ "${OSTYPE}" == linux* ]]; then
    installer/linux-install.sh
else
    echo -en "\nUnSupported Operating System\n\n"
fi

# Install zprezto
if [[ -s "${HOME}/.zprezto/.git/config" ]]; then
    echo -en "zprezto already installed.\n"
else
    echo -en "Installing zprezto .....\n"
    git clone --recursive https://github.com/sorin-ionescu/prezto.git $HOME/.zprezto
fi

# Install neovim config
if [[ -s "${HOME}/.config/nvim/init.vim" ]]; then
    echo -en "NeoVim already initialized.\n"
else
    echo -en "Initializing nvim .....\n"
    curl 'https://vim-bootstrap.com/generate.vim' --data 'editor=nvim&langs=html&langs=go&langs=python&langs=c&langs=rust&langs=html&langs=javascript' > ~/.config/nvim/init.vim
    echo -en "Installing nvim plugins .....\n"
    vim +PlugInstall +UpdateRemotePlugins +qall
    vim -c 'CocInstall -sync coc-json coc-html coc-python coc-go coc-xml coc-yaml coc-sql|q'
fi

# Install tmux plugin manager
if [[ -s "${HOME}/.tmux/plugins/tpm/.git/config" ]]; then
    echo -en "tmux already initialized\n"
else
    echo -en "Initializing tmux .....\n"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Link all dotfiles
ln -sf ~/.dotfiles/common/tmux.conf ~/.tmux.conf
ln -sf ~/.dotfiles/common/local_aliases ~/.local_aliases
ln -sf ~/.dotfiles/common/screenrc ~/.screenrc

ln -sf ~/.dotfiles/git/gitconfig ~/.gitconfig
ln -sf ~/.dotfiles/git/gitignore_global ~/.gitignore_global

ln -sf ~/.dotfiles/nvim/local_init.vim ~/.config/nvim/local_init.vim
ln -sf ~/.dotfiles/nvim/local_bundles.vim ~/.config/nvim/local_bundles.vim
ln -sf ~/.dotfiles/nvim/coc-settings.json ~/.config/nvim/coc-settings.json

ln -sf ~/.dotfiles/ipython/ipython_config.py ~/.ipython/profile_default/ipython_config.py

ln -sf ~/.dotfiles/ssh/config ~/.ssh/config

ln -sf ~/.dotfiles/bash/bashrc ~/.bashrc
ln -sf ~/.dotfiles/bash/bash_aliases ~/.bash_aliases
ln -sf ~/.dotfiles/bash/bash_profile ~/.bash_profile

ln -sf ~/.dotfiles/zsh/zshrc ~/.zshrc
ln -sf ~/.dotfiles/zsh/zpreztorc ~/.zpreztorc
ln -sf ~/.dotfiles/zsh/zprofile ~/.zprofile
ln -sf ~/.dotfiles/zsh/zsh_history ~/.zsh_history
ln -sf ~/.dotfiles/zsh/themes/prompt_powerline_setup ~/.zprezto/modules/prompt/external/powerline/prompt_powerline_setup
ln -sf ~/.dotfiles/zsh/themes/prompt_myzssh_setup ~/.zprezto/modules/prompt/prompt_myzssh_setup
ln -sf ~/.dotfiles/zsh/themes/prompt_superlinh_setup ~/.zprezto/modules/prompt/functions/prompt_superlinh_setup


