#!/bin/bash

which apt && PKG_CMD="apt"
which yum && PKG_CMD="yum"

case $PKG_CMD in
    apt)
        installer/apt-install.sh
        ;;
    yum)
        installer/yum-install.sh
        ;;
    *)
        echo -en "\nUnSupported Opearating System\n\n"
        exit 1
        ;;
esac

# Install neovim
if [[ -s "${HOMe}/bin/vim" ]]; then
    echo -en "NeoVim is already installed."
else
    echo -en "Installing NeoVim ....."
    curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
    chmod u+x nvim.appimage
    mv nvim.appimage $HOME/bin/vim
fi

# Install goenv
if [[ -s "${HOMe}/bin/vim" ]]; then
    echo -en "NeoVim is already installed."
else
    git clone https://github.com/syndbg/goenv.git ~/.goenv
    export GOENV_ROOT="$HOME/.goenv"
    export PATH="$GOENV_ROOT/bin:$PATH"
    goenv install 1.14.4
fi

# Install tmux
if [[ -s "${HOMe}/bin/vim" ]]; then
    echo -en "NeoVim is already installed."
else
    curl -LO https://github.com/tmux/tmux/releases/download/3.1b/tmux-3.1b-x86_64.AppImage
    chmod u+x tmux-3.1b-x86_64.AppImage
    mv tmux-3.1b-x86_64.AppImage $HOME/bin/tmux
fi

# zsh auto suggestion
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh-autosuggestions

