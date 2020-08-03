#!/bin/bash

# Install gitui
if [[ -s "${HOME}/bin/gitui" ]]; then
    echo -en "GitUI is already installed."
else
    echo -en "Installing GitUI ....."
    wget https://github.com/extrawurst/gitui/releases/download/v0.9.1/gitui-linux-musl.tar.gz -O /tmp/gitui-linux-musl.tar.gz
    tar -zxf /tmp/gitui-linux-musl.tar.gz -C $HOME/bin/
fi

