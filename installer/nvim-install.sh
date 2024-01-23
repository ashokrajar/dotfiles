#!/bin/bash

# Install neovim
if [[ -s "${HOME}/bin/vim" ]]; then
    echo -en "NeoVim is already installed."
else
    echo -en "Installing NeoVim ....."
    sudo snap install nvim --classic
fi

