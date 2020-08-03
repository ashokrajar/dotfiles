#!/bin/bash

# Core
sudo apt-get install -y build-essential inetutils-traceroute traceroute hwinfo xdg-utils

# Editors
# sudo apt-get install -y neovim

# Git
sudo apt-get install -y git

# Languages
sudo apt-get install -y python-is-python3 python3-pip rustc

# Debug tools
sudo apt-get install -y strace

# Developer tools
sudo apt-get install -y direnv legit

# Terminal Tools
sudo apt-get install -y htop wget curl httpie
# sudo apt-get install -y tmux

# Install node.js
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs
