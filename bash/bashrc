# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth
# ... and increase history size
export HISTSIZE=1000000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# bash prompt to support git branch recognition
__git_ps1 ()
{
    local b="$(git symbolic-ref HEAD 2>/dev/null)";

    if [ -n "$b" ]; then
        printf " (\e[1;35mgit->%s\e[1;34m)" "${b##refs/heads/}";
    fi
}

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u\[\033[01;32m\]@\[\033[01;36m\]\h\[\033[31m\]:\[\033[01;34m\]\w\[\033[00m\]\$\n'
    PS1='\e[1;34m(\e[1;33m\h\e[1;34m) - \e[1;34m(\e[1;36m\w\e[1;34m) $(__git_ps1)\e[m\n>> '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.local_aliases ]; then
    . ~/.local_aliases
fi

if [ -f ~/.local_workspecalias ]; then
    . ~/.local_workspecalias
fi

if [ -f ~/.bash_workspecalias ]; then
    . ~/.bash_workspecalias
fi

if [ -f ~/.user_env_pass ]; then
    . ~/.user_env_pass
fi

if [ -f ~/.screen_hack ]; then
    . ~/.screen_hack
fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='ls --color=auto --format=vertical'
    alias vdir='ls --color=auto --format=long'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
elif [ `uname -s` == "Darwin" ];then
    alias ls='ls -G'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# User specific environment and startup programs
export PATH=$HOME/bin:/usr/local/bin:/usr/local/Cellar/ruby/2.0.0-p195/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/bin:/usr/kerberos/bin:/var/lib/gems/1.8/bin/:/opt/hadoop/bin

# Display hostname as Title of the shell
function ssh () { echo -n -e "\033k`echo $1 | awk -F. '{ print $1 }'`\033\\"; /usr/bin/ssh "$@"; echo -n -e "\033kmybox\033\\"; }
function mssh () { echo -n -e "\033k`echo $1 | awk -F. '{ print $1 }'`\033\\"; /home/ashokr/bin/mssh "$@"; echo -n -e "\033kmybox\033\\"; }

# Hadoop
export HADOOP_OPTS="-Djava.security.krb5.realm=OX.AC.UK -Djava.security.krb5.kdc=kdc0.ox.ac.uk:kdc1.ox.ac.uk"
export JAVA_HOME="/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home"

# Perl LANG
export LC_ALL="en_GB.utf8"
export LC_CTYPE="en_GB.utf8"
