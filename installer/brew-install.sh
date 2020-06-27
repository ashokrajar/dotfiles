#!/usr/bin/env bash

# install brew
if [[ -s "/usr/local/bin/brew" ]]; then
    echo -en "brew already installed.\n"
    exit 
else
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"    
fi

# Core
brew install gcc libffi libxmlsec1 gmp ta-lib libpq cmake

# Editors
brew install neovim

# Git
brew tap git-chglog/git-chglog
brew install git legit git-chglog git-secrets git-flow 

#git-tag

# Languages
brew install python3 pypy3 pyenv pipenv go goenv node nvm

# Developer tools
brew install direnv libfaketime maven autoenv glide cobra legit jq
brew tap git-chglog/git-chglog
brew install git-chglog
brew install golangci/tap/golangci-lint

# Cloud CLIs
brew install awscli azure-cli certbot

# Buildpack SRC to OCI images
brew tap buildpack/tap
brew install pack

# K8
brew install kubectx minikube derailed/k9s/k9s

# Terminal Tools
brew install fzf tmux htop tree wget hping kube-ps1 fzf zsh-autosuggestions nmap speedtest-cli the_silver_searcher httpie bat newman
brew install https://raw.githubusercontent.com/kadwanev/bigboybrew/master/Library/Formula/sshpass.rb

# Automation Tools
brew install terraform

# Load Testing Tool
brew install vegeta

# Terminal Plotting Tools
brew install rs/tap/jaggr
brew install rs/tap/jplot

# link python
ln -sf /usr/local/bin/python3 /usr/local/bin/python
ln -sf /usr/local/bin/pip3 /usr/local/bin/pip

# Enable fzf
/usr/local/opt/fzf/install --all
