#! /bin/bash
# ~/.local_aliases
# only local aliases goes here

# common alaias
alias myip='echo -en "Private IPs :\n\t"; ifconfig | grep inet | egrep -v "inet6|127.0.0.1" | cut -f2 -d" "; echo -en "Public IPs :\n\t"; dig +short myip.opendns.com @resolver1.opendns.com'
alias flushdns='sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder; say cache flushed'

# tmux
alias owork='tmux attach -t work'

# debugging
alias psstate='ps -axo pid,comm,stat --sort=-stat'

# Docker
alias drm_notrunning="docker ps -a | grep Exited | awk '{print $1}' | xargs docker rm"

# SSH Tunnel for SOCKS Proxy
alias startproxy="ssh -D 8123 -f -C -q -N remotengine"
