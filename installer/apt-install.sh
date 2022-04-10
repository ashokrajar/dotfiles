#!/bin/bash

curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt-get update

# Core
sudo apt-get upgrade -y
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
sudo apt-get install -y direnv legit hugo yamllint gh

# Cloud Tools
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get update
sudo apt-get install -y azure-functions-core-tools-3

# Terminal Tools
sudo apt-get install -y htop wget curl httpie sshpass
# sudo apt-get install -y tmux

# Install node.js
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs

# Load/Performance Testing Tool
sudo apt-get install -y iperf3

# Monitoring Tools
sudo apt-get install -y iotop iftop htop sysstat
