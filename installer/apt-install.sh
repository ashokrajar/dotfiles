#!/bin/bash

sudo apt-get update

# Core
sudo apt-get upgrade -y
sudo apt-get install -y net-tools inetutils-traceroute hwinfo sysstat lm-sensors python-is-python3 zsh nfs-common git

# Languages
sudo apt-get install -y python-is-python3

# Debug tools
sudo apt-get install -y strace

# Developer tools
sudo apt-get install -y direnv legit hugo yamllint gh

# Terminal Tools
sudo apt-get install -y htop wget curl httpie sshpass bat fzf fd-find
sudo apt-get install -y tmux
sudo ln -s /usr/bin/fdfind /usr/bin/fd

# Load/Performance Testing Tool
sudo apt-get install -y iperf3

# Monitoring Tools
sudo apt-get install -y iotop iftop htop sysstat
