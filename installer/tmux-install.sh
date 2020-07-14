#!/bin/bash

# Install tmux
if [[ -s "${HOME}/bin/tmux" ]]; then
    echo -en "tmux is already installed.\n"
else
    echo -en "Installing tmux .....\n"
    curl -LO https://github.com/tmux/tmux/releases/download/3.1b/tmux-3.1b-x86_64.AppImage
    chmod u+x tmux-3.1b-x86_64.AppImage
    mv tmux-3.1b-x86_64.AppImage $HOME/bin/tmux
fi
