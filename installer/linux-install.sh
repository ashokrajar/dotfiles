#!/bin/bash

which apt && PKG_CMD="apt"
which yum && PKG_CMD="yum"

case $PKG_CMD in
    apt)
        apt-install.sh
        ;;
    yum)
        yum-install.sh
        ;;
    *)
        echo -en "\nUnSupported Opearating System\n\n"
        exit 1
        ;;
esac

# Install latest nvim
curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod u+x nvim.appimage
mv nvim.appimage ~/bin/nvim

