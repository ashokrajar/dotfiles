#!/usr/bin/env bash

# Install core packages/libraries
if [[ "${OSTYPE}" == darwin* ]]; then
    installer/brew-install.sh

    # link python
    ln -sf /usr/local/bin/python3 /usr/local/bin/python
    ln -sf /usr/local/bin/pip3 /usr/local/bin/pip
elif [[ "${OSTYPE}" == linux* ]]; then
    installer/linux-install.sh
else
    echo -en "\nUnSupported Operating System\n\n"
    exit 1
fi

# Install python
pyenv install 3.12.9

# alias nvim as vim
alias vim="nvim"

# Install essential golang packages, tools and applications
# set GOPATH
export GOPATH=${HOME}/gopaths/global
goenv install 1.23.4
goenv global 1.23.4
goenv shell 1.23.4

while IFS= read -r PKG
do
    echo -en "Installing/Upgrading Go package : ${PKG} .....\n"
    go install "$PKG@latest"
done <installer/gopkgs.txt

# Install zprezto
if [[ -s "${HOME}/.zprezto/.git/config" ]]; then
    echo -en "zprezto already installed.\n"
else
    echo -en "Installing zprezto .....\n"
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "$HOME/.zprezto"
    git clone --recurse-submodules https://github.com/belak/prezto-contrib "$HOME/.zprezto/contrib"
fi

# Install FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all --completion --key-bindings --no-update-rc

# Install neovim config
if [[ -s "${HOME}/.config/nvim/init.vim" ]]; then
    echo -en "NeoVim already initialized.\n"
else
    # Create python env for Nvim packages
    echo -en "Creating nvim python virtualenv .....\n"
    pyenv virtualenv 3.12.9 nvim
    pyenv shell nvim
    pip3 install neovim jedi pyflakes pylint pylint-venv node pytest black
    echo -en "Initializing nvim .....\n"
    curl 'https://vim-bootstrap.com/generate.vim' --data 'editor=nvim&langs=html&langs=go&langs=python&langs=c&langs=rust&langs=html&langs=javascript' >~/.config/nvim/init.vim
    echo -en "Installing nvim plugins .....\n"
    vim +PlugInstall +UpdateRemotePlugins +qall
    vim -c 'CocInstall -sync coc-json coc-html coc-go coc-sh coc-tsserver coc-markdownlint coc-pyright coc-xml coc-yaml|q'
fi

# linkfiles
installer/linkfiles.sh

# Install tmux plugin manager
if [[ -s "${HOME}/.tmux/plugins/tpm/.git/config" ]]; then
    echo -en "tmux already initialized\n"
else
    echo -en "Initializing tmux .....\n"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
