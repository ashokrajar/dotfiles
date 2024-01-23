#!/bin/bash

curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

sudo apt-get update

# Core
sudo apt-get upgrade -y
sudo apt-get install -y build-essential net-tools inetutils-traceroute hwinfo sysstat lm-sensors python-is-python3 zsh nfs-common git

# Languages
sudo apt-get install -y python-is-python3 python3-pip rustc

# Debug tools
sudo apt-get install -y strace

# Developer tools
sudo apt-get install -y direnv legit hugo yamllint gh

# Terminal Tools
sudo apt-get install -y htop wget curl httpie sshpass bat fzf fd-find
sudo apt-get install -y tmux
sudo ln -s /usr/bin/fdfind /usr/bin/fd

# Install node.js
sudo apt-get install -y nodejs

# Load/Performance Testing Tool
sudo apt-get install -y iperf3

# Monitoring Tools
sudo apt-get install -y iotop iftop htop sysstat
