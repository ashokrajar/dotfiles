#!/usr/bin/env bash

# Install core packages/libraries
if [[ "${OSTYPE}" == darwin* ]]; then
    installer/brew-install.sh

    # link python
    ln -sf /usr/local/bin/python3 /usr/local/bin/python
    ln -sf /usr/local/bin/pip3 /usr/local/bin/pip

    # Enable fzf
    /usr/local/opt/fzf/install --all

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

# NPM based tools like,
# sql-lint, azurite
installer/npm-tools.sh

# alias nvim as vim
alias vim="nvim"

# Install essential golang packages, tools and applicaitons
# set GOPATH
export GOPATH=${HOME}/gopaths/global
while IFS= read -r PKG
do
    echo -en "Installing/UPgrading Go package : ${PKG} .....\n"
    go get "$PKG"
done < installer/gopkgs.txt

# Install zprezto
if [[ -s "${HOME}/.zprezto/.git/config" ]]; then
    echo -en "zprezto already installed.\n"
else
    echo -en "Installing zprezto .....\n"
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "$HOME/.zprezto"
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

# Install doom emacs
if [[ -s "${HOME}/.emacs.d/.git/config" ]]; then
    echo -en "Doom Emacs already installed.\n"
else
    echo -en "Installing Doom Emacs .....\n"
    git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
    ~/.emacs.d/bin/doom install
fi

# Install tmux plugin manager
if [[ -s "${HOME}/.tmux/plugins/tpm/.git/config" ]]; then
    echo -en "tmux already initialized\n"
else
    echo -en "Initializing tmux .....\n"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    ~/.tmux/plugins/tpm/bin/install_plugins
fi

# Link all dotfiles
echo -en "Linking dotfiles .....\n"
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
ln -sf ~/.dotfiles/zsh/p10k.zsh ~/.p10k.zsh

if [[ "${OSTYPE}" == darwin* ]]; then
    ln -sf ~/.dotfiles/zsh/maczshrc ~/.maczshrc
elif [[ "${OSTYPE}" == linux* ]]; then
    ln -sf ~/.dotfiles/zsh/linuxzshrc ~/.linuxzshrc
fi
