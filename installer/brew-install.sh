#!/usr/bin/env bash

# install brew
if [[ -s "/usr/local/bin/brew" ]]; then
    echo -en "brew already installed.\n"
    exit 
else
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"    
fi

# Core
brew install gcc libffi libxmlsec1 gmp ta-lib libpq cmake zsh zsh-autosuggestions

brew install aspell editorconfig shellcheck marked ripgrep

# Editors
brew install neovim

brew tap d12frosted/emacs-plus
brew install emacs-plus

brew install code-server

# Git
brew install gh
brew tap git-chglog/git-chglog
brew install git legit git-chglog git-secrets git-flow-avh gitui
# brew install gitversion TODO: need to wait for dotnet 6.x release

# Languages
brew install python3 pypy3 pyenv pipenv go goenv node nvm rustup

# Developer tools
brew install direnv libfaketime maven autoenv glide legit jq yamllint
brew tap git-chglog/git-chglog
brew install git-chglog
brew install golangci/tap/golangci-lint
brew install hugo
brew tap azure/functions
brew install azure-functions-core-tools@3
brew install --cask snowflake-snowsql
brew tap sqitchers/sqitch
brew install sqitch --with-postgres-support --with-sqlite-support --with-mysql-support --with-snowflake-support
brew install dapr/tap/dapr-cli
brew install encoredev/tap/encore

# BigData
brew install hadoop

# Cloud Tools
brew install awscli azure-cli certbot
brew tap aws/tap
brew install aws-sam-cli
brew tap azure/functions
brew install azure-functions-core-tools@3
brew install azcopy

# Build pack SRC to OCI images
brew tap buildpack/tap
brew install pack

# Docker
brew install ctop lazydocker

# K8
brew install kubernetes-cli
brew install kubectx minikube derailed/k9s/k9s
brew install skaffold

# Terminal Tools
brew install fzf tmux htop tree wget hping kube-ps1 fzf zsh-autosuggestions nmap speedtest-cli the_silver_searcher httpie bat newman bat telnet
brew install https://raw.githubusercontent.com/kadwanev/bigboybrew/master/Library/Formula/sshpass.rb

# DevOps Tools
brew install hashicorp/tap/terraform terragrunt ansible

# Network tools
brew install ngrok

# Load/Performance Testing Tool
brew install vegeta iperf3

# Terminal Plotting Tools
brew install rs/tap/jaggr
brew install rs/tap/jplot
