# .bashrc

# User specific aliases and functions
alias vi='vim'
alias grep='grep --color'
alias psstate='ps -axo pid,comm,stat --sort=-stat'

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# User specific environment and startup programs
export PATH=/home/y/bin:/usr/local/bin:/usr/bin:/bin::/usr/sbin:/usr/local/sbin:/sbin:/usr/X11R6/bin:/usr/local/sbin:/usr/kerberos/bin
export ROOT=/home/y
export LANG=en_US.UTF-8

# Custom Terminal Prompt
export PS1='\[\033[01;31m\][\u@\h \w]\$\n\[\033[00m\]'
