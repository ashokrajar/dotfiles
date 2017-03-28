#!/usr/bin/env zsh

local NEWLINE=$'\n'
local PROMPT_SUFIX="${NEWLINE}%{$fg_bold[red]%}❯%{$fg_bold[yellow]%}❯%{$fg_bold[green]%}❯"
local LAMBDA="%(?,%{$FG[208]%}λ,%{$fg_bold[red]%}λ)"
if [[ "$USER" == "root"  ]]; then USERCOLOR="red"; else USERCOLOR="green"; fi

#local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
#PROMPT='${ret_status} %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

# Git sometimes goes into a detached head state. git_prompt_info doesn't
# return anything in this case. So wrap it in another function and check
# for an empty string.
# Outputs current branch info in prompt format
function git_prompt_info() {
  local ref
  if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]; then
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

function check_git_prompt_info() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        if [[ -z $(git_prompt_info) ]]; then
            echo "%{$fg[blue]%}detached-head%{$reset_color%}) $(git_prompt_status) ${SECOND_LINE_PROMPT}"
        else
            echo "$(git_prompt_info) $(git_prompt_status) ${SECOND_LINE_PROMPT}"
        fi
    else
        echo "${SECOND_LINE_PROMPT}"
    fi
}

function get_right_prompt() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        if [[ -z $(git_prompt_info)  ]]; then
            echo "%{$fg[blue]%}detached-head%{$reset_color%}) $(git_prompt_status) %{$reset_color%}"
        else
            echo -n "$(git_prompt_status) $(git_remote_status) $(git_prompt_info) $(parse_git_dirty)%{$reset_color%}"
        fi
    else
        echo -n "%{$reset_color%}"
    fi
}

function virtualenv_prompt_info(){
  [[ -n ${VIRTUAL_ENV} ]] || return
  echo "${ZSH_THEME_VIRTUALENV_PREFIX:=[}${VIRTUAL_ENV:t}${ZSH_THEME_VIRTUALENV_SUFFIX:=]}"
}

PROMPT='
%{$fg_bold[$USERCOLOR]%}%n@%m%f\
 ${LAMBDA}\
 %{$fg_bold[cyan]%}[%3~]\
 $(virtualenv_prompt_info)\
 ${PROMPT_SUFIX}\
%{$reset_color%}'

RPROMPT='$(get_right_prompt)'

# Format for git_prompt_info()
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[blue]%})%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}⚡ "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✔ "

# Format for git_prompt_status()
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%}✚ "
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[blue]%}⚑ "
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%}✖ "
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[magenta]%}➜ "
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[yellow]%}═ "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[cyan]%}◒ "

# Format for git_prompt_ahead()
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[white]%}⬆ "
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg_bold[white]%}⬇ "


# Format for git_prompt_long_sha() and git_prompt_short_sha()
ZSH_THEME_GIT_PROMPT_SHA_BEFORE="%{$fg_bold[white]%}[%{$fg_bold[blue]%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$fg_bold[white]%}]"
