#!/usr/bin/env bash

# Install core packages/libraries
if [[ "${OSTYPE}" == darwin* ]]; then
    installer/brew-install.sh

    # Install core python packages
    pip install -r installer/pip-requirements.txt

elif [[ "${OSTYPE}" == linux* ]]; then
    installer/linux-install.sh

    # Install core python packages
    pip3 install -r installer/pip-requirements.txt

else
    echo -en "\nUnSupported Operating System\n\n"
    exit 1
fi

# alias nvim as vim
alias vim="nvim"

# set GOPATH
export GOPATH=${HOME}/gopaths/global

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
    vim -c 'CocInstall -sync coc-json coc-html coc-python coc-xml coc-yaml coc-sql|q'
fi

# Install tmux plugin manager
if [[ -s "${HOME}/.tmux/plugins/tpm/.git/config" ]]; then
    echo -en "tmux already initialized\n"
else
    echo -en "Initializing tmux .....\n"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Link all dotfiles
# tmux
ln -sf ~/.dotfiles/common/tmux.conf ~/.tmux.conf
ln -sf ~/.dotfiles/common/local_aliases ~/.local_aliases
ln -sf ~/.dotfiles/common/screenrc ~/.screenrc

# git
ln -sf ~/.dotfiles/git/gitconfig ~/.gitconfig
ln -sf ~/.dotfiles/git/gitignore_global ~/.gitignore_global

# nvim
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
ln -sf ~/.dotfiles/zsh/zsh_history ~/.zsh_history
ln -sf ~/.dotfiles/zsh/themes/prompt_powerline_setup ~/.zprezto/modules/prompt/external/powerline/prompt_powerline_setup
ln -sf ~/.dotfiles/zsh/themes/prompt_myzssh_setup ~/.zprezto/modules/prompt/prompt_myzssh_setup
ln -sf ~/.dotfiles/zsh/themes/prompt_superlinh_setup ~/.zprezto/modules/prompt/functions/prompt_superlinh_setup

if [[ "${OSTYPE}" == darwin* ]]; then
    ln -sf ~/.dotfiles/zsh/maczshrc ~/.maczshrc
elif [[ "${OSTYPE}" == linux* ]]; then
    ln -sf ~/.dotfiles/zsh/linuxzshrc ~/.linuxzshrc
fi
