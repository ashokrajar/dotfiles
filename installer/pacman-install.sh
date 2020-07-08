#!/bin/bash

# install AUR helper - YAY
if [[ -s "/usr/bin/yay" ]]; then
    echo -en "yay already installed.\n"
else
    mkdir ${HOME}/src
    git clone https://aur.archlinux.org/yay-git.git ${HOME}/src/yay-git
    cd yay
    makepkg -si
    yay -Syu
fi

# Core
sudo pacman -S --noconfirm --needed base-devel net-tools which zsh sudo

# Editors
sudo pacman -S --noconfirm --needed neovim

# Git
sudo pacman -S --noconfirm --needed git
yay -S --removemake --answerclean A --answerdiff N --noconfirm --needed legit git-chglog git-secrets
# git-flow

# Languages
sudo pacman -S --noconfirm --needed python pypy python-pip pyenv go nodejs

# Developer tools
sudo pacman -S --noconfirm --needed jq
yay -S --removemake --answerclean A --answerdiff N --noconfirm --needed direnv nvm golangci-lint-bin

# Cloud CLIs
sudo pacman -S --noconfirm --needed certbot aws-cli
yay -S --removemake --answerclean A --answerdiff N --noconfirm --needed azure-cli

# k8
sudo pacman -S --noconfirm --needed kubectl kubectx k9s

# Terminal Tools
sudo pacman -S --noconfirm --needed htop wget curl fzf tree nmap httpie bat sshpass the_silver_searcher
yay -S --removemake --answerclean A --answerdiff N --noconfirm --needed kube-ps1

# Automation Tools
sudo pacman -S --noconfirm --needed terraform ansible

# Load Testing Tool
sudo pacman -S --noconfirm --needed vegeta

