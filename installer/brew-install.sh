#!/usr/bin/env bash

# install brew
if [[ -s "/usr/local/bin/brew" ]] || [[ -s "/opt/homebrew/bin/brew" ]]; then
    echo -en "brew already installed.\n"
    exit 
else
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"    
fi

cp -fv ~/.dotfiles/homebrew/Brewfile ~/.Brewfile
brew bundle --global