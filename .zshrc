#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
[[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]] && source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

# Customize to your needs...
setopt ALIAS_FUNC_DEF
# Alias definition
[[ -f "$HOME/.local_aliases" ]] && source "$HOME/.local_aliases"
[[ -f "$HOME/.local_workspecalias" ]] && source "$HOME/.local_workspecalias"
[[ -f "$HOME/.user_env_pass" ]] && source "$HOME/.user_env_pass"

# LANG 
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8

# golang
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/gopath
export GOOS="darwin"

[[ -s "/Users/ashokraja/.gvm/scripts/gvm" ]] && source "/Users/ashokraja/.gvm/scripts/gvm"


# jEnv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
export JAVA_HOME="$(jenv javahome)"

# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm

# ZSH Auto complete
[[ -f "/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source "/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Helm Auto complete
[[ -f "/usr/local/share/zsh/site-functions/_helm" ]] && source "/usr/local/share/zsh/site-functions/_helm"

# AWS shell completer
[[ -f "/usr/local/bin/aws_zsh_completer.sh" ]] && source "/usr/local/bin/aws_zsh_completer.sh"

# GCP Auto complete
[[ -f "$HOME/Downloads/google-cloud-sdk/completion.zsh.inc" ]] && source "$HOME/Downloads/google-cloud-sdk/completion.zsh.inc"

# python autoenv
#[[ -f "/usr/local/opt/autoenv/activate.sh" ]] && source "/usr/local/opt/autoenv/activate.sh"

# pyenv
eval "$(pyenv init -)"

# Docker
# eval "$(docker-machine env codengine)"

# K8
if [ $commands[kubectl] ]; then source <(kubectl completion zsh); fi

# Travis CI
[ -f /Users/ashok.raja/.travis/travis.sh ] && source /Users/ashok.raja/.travis/travis.sh

# iTerm Shell Intergration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Chef
# eval "$(chef shell-init zsh)"

# Set openssl lib path
export LDFLAGS="-L/usr/local/opt/openssl/lib -L/usr/local/opt/zlib/lib -L/usr/local/opt/sqlite/lib"
export CFLAGS="-I/usr/local/include -L/usr/local/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include -I/usr/local/opt/sqlite/include"

# A command-line fuzzy finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Powerlevel9k Cutomization
[ -f ${HOME}/.powerlevel9k_custom ] && source ${HOME}/.powerlevel9k_custom

