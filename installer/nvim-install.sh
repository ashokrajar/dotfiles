#!/bin/bash

# Install neovim
if [[ -s "${HOME}/bin/vim" ]]; then
    echo -en "NeoVim is already installed."
else
    echo -en "Installing NeoVim ....."
    curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
    chmod u+x nvim.appimage
    mv nvim.appimage $HOME/bin/vim
fi

