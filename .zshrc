#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
[[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]] && source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

# Customize to your needs...
# Alias definition
[[ -f "$HOME/.local_aliases" ]] && source "$HOME/.local_aliases"
[[ -f "$HOME/.local_workspecalias" ]] && source "$HOME/.local_workspecalias"
[[ -f "$HOME/.user_env_pass" ]] && source "$HOME/.user_env_pass"

# golang
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=/usr/local/opt/go/gopath:/Users/ashokraja/workspace/code/gopath
export GOOS="darwin"

# jEnv
eval "$(jenv init -)"
export JAVA_HOME="$(jenv javahome)"

# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8

# AWS shell completer
[[ -f "/usr/local/bin/aws_zsh_completer.sh" ]] && source "/usr/local/bin/aws_zsh_completer.sh"

# python autoenv
[[ -f "/usr/local/opt/autoenv/activate.sh" ]] && source "/usr/local/opt/autoenv/activate.sh"

# Docker
# eval "$(docker-machine env codengine)"

# login banner
# archey -c

# added by travis gem
[ -f /Users/ashokraja/.travis/travis.sh ] && source /Users/ashokraja/.travis/travis.sh

# [[ -s "/Users/ashokraja/.gvm/scripts/gvm" ]] && source "/Users/ashokraja/.gvm/scripts/gvm"

# iTerm Shell Intergration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Chef
# eval "$(chef shell-init zsh)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f /Users/ashokraja/Downloads/google-cloud-sdk/path.zsh.inc ]; then
  source '/Users/ashokraja/Downloads/google-cloud-sdk/path.zsh.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f /Users/ashokraja/Downloads/google-cloud-sdk/completion.zsh.inc ]; then
  source '/Users/ashokraja/Downloads/google-cloud-sdk/completion.zsh.inc'
fi
