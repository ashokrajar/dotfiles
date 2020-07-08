#!/bin/bash

hash apt 2>/dev/null && PKG_CMD="apt"
hash yum 2>/dev/null && PKG_CMD="yum"
hash pacman 2>/dev/null && PKG_CMD="packman"

case $PKG_CMD in
    apt)
        installer/apt-install.sh
        installer/nvim-install.sh
        ;;
    yum)
        installer/yum-install.sh
        installer/nvim-install.sh
        ;;
    packman)
        installer/pacman-install.sh
        ;;
    *)
        echo -en "\nUnSupported Opearating System\n\n"
        exit 1
        ;;
esac

# Install goalng & goenv
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

# Install tmux
if [[ -s "${HOME}/bin/tmux" ]]; then
    echo -en "tmux is already installed.\n"
else
    echo -en "Installing tmux .....\n"
    curl -LO https://github.com/tmux/tmux/releases/download/3.1b/tmux-3.1b-x86_64.AppImage
    chmod u+x tmux-3.1b-x86_64.AppImage
    mv tmux-3.1b-x86_64.AppImage $HOME/bin/tmux
fi

# zsh auto suggestion
if [[ -s ${HOME}/.zsh-autosuggestions/.git/config ]]; then
    echo -en "zsh-autosuggestions already installed.\n"
else
    echo -en "Installing zsh-autosuggestions .....\n"
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh-autosuggestions
fi

