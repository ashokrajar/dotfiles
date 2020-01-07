#!/bin/bash

# Install zprezto
if [ ! -s "~/.zprezto/.git/config" ]; then
  git clone --recursive https://github.com/sorin-ionescu/prezto.git $HOME/.zprezto
  cd $ZPREZTODIR
  git clone --recurse-submodules https://github.com/belak/prezto-contrib contrib
fi

# Install spf13 vim
if [ ! -s "~/.spf13-vim-3/.git/config"]; then
  curl http://j.mp/spf13-vim3 -L -o - | sh
fi

# Install tmux plugin manager
if [ ! -s "~/.tmux/plugins/tmp/.git/config" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

brew install `cat brew-requirements.txt`

npm install -g spaceship-prompt

# Copy the custom dofiles
cp -rv .zpreztorc .zprofile .zshenv .zshrc .local_aliases .powerlevel9k_custom .tmux.conf .screenrc .vimrc.bundles.local .vimbundles.vim .vimrc.local bin ~/
