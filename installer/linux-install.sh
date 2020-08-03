#!/bin/bash

hash apt 2>/dev/null && PKG_CMD="apt"
hash yum 2>/dev/null && PKG_CMD="yum"
hash pacman 2>/dev/null && PKG_CMD="packman"

case $PKG_CMD in
    apt)
        installer/apt-install.sh
        installer/nvim-install.sh
        installer/tmux-install.sh
        installer/gitui-install.sh
        ;;
    yum)
        installer/yum-install.sh
        installer/nvim-install.sh
        installer/tmux-install.sh
        ;;
    packman)
        installer/pacman-install.sh
        ;;
    *)
        echo -en "\nUnSupported Opearating System\n\n"
        exit 1
        ;;
esac

# Install golang & goenv
if [[ -s "${HOME}/.goenv/.git/config" ]]; then
    echo -en "genv is already installed.\n"
else
    echo -en "Installing genv .....\n"
    git clone https://github.com/syndbg/goenv.git ~/.goenv
    export GOENV_ROOT="$HOME/.goenv"
    export PATH="$GOENV_ROOT/bin:$PATH"
    goenv install 1.14.4
    goenv global 1.14.4
fi

# zsh auto suggestion
if [[ -s ${HOME}/.zsh-autosuggestions/.git/config ]]; then
    echo -en "zsh-autosuggestions already installed.\n"
else
    echo -en "Installing zsh-autosuggestions .....\n"
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh-autosuggestions
fi

