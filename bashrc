#!/bin/bash

##############################
##   Adam Nelson's bashrc   ##
##############################

# Options
# ------------------------------------------------------------

shopt -s extglob
shopt -s dotglob
shopt -s cdspell
export EDITOR=vim

export HISTFILESIZE=20000
export HISTSIZE=10000
shopt -s histappend
shopt -s cmdhist
HISTCONTROL=ignoredups
export HISTIGNORE="&:ls:[bf]g:exit"

eval `dircolors ~/etc/teal-orange.dircolors`

# Aliases
# ------------------------------------------------------------

alias ls="ls --color=auto --classify"
alias l='ls -lFh'   # size,show type,human readable
alias la='ls -lAFh' # long list,show almost all,show type,human readable
alias lr='ls -tRFh' # sorted by date,recursive,show type,human readable
alias lt='ls -ltFh' # long list,sorted by date,show type,human readable
alias ll='ls -l'    # long list

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias xcopy='xclip -i -selection clipboard'
alias xpaste='xclip -o -selection clipboard'

# Prompt
# ------------------------------------------------------------

source ~/etc/scripts/git-prompt.sh

Color_Reset='\[\033[0;37m\]'

if [ "$TERM" == "linux" ]; then
  # Use ASCII symbols and standard ANSI colors
  Symbol_LBracket="["
  Symbol_RBracket="]"
  Symbol_Ellipsis="..."
  Symbol_Prompt=" $ "

  Color_Bracket='\[\033[1;37m\]'
  Color_Hostname='\[\033[1;37m\]'
  Color_Directory='\[\033[35m\]'
  Color_Git='\[\033[32m\]'
  Color_Success='\[\033[33m\]'
  Color_Failure='\[\033[31m\]'
else
  # Use Unicode symbols and teal-orange colors
  Symbol_LBracket="❮"
  Symbol_RBracket="❯"
  Symbol_Ellipsis="…"
  Symbol_Prompt=" — "

  Color_Bracket='\[\033[34m\]'
  Color_Hostname='\[\033[36m\]'
  Color_Directory='\[\033[32m\]'
  Color_Git='\[\033[33m\]'
  Color_Success='\[\033[96m\]'
  Color_Failure='\[\033[91m\]'
fi

set_prompt() {
  local Last_Command=$?
  local Current_Directory=$(pwd)

  # Window title
  PS1='\[\033]0;\u@\h:${PWD//[^[:ascii:]]/?}\007\]'
  
  # [user@host]
  PS1+="$Color_Bracket$Symbol_LBracket"
  PS1+="$Color_Hostname"'\u@\h'
  PS1+="$Color_Bracket$Symbol_RBracket"
  PS1+="$Color_Reset "
  
  # Working directory
  PS1+="$Color_Directory"
  case "$Current_Directory" in
    $HOME) PS1+='~';;
    '/') PS1+='/';;
    /[!-.0-~]) PS1+="$Current_Directory";;
    *) PS1+="$Symbol_Ellipsis/$(basename "$Current_Directory")";;
  esac
  PS1+="$Color_Reset"
  
  # Git branch
  if command -v git >/dev/null 2>&1; then
    PS1+="$Color_Git$(__git_ps1)$Color_Reset"
  fi

  # Colorized dash based on last command's exit code
  if [[ $Last_Command == 0 ]]; then
    PS1+="$Color_Success"
  else
    PS1+="$Color_Failure"
  fi
  PS1+="$Symbol_Prompt$Color_Reset"
}

PROMPT_COMMAND='set_prompt'
PS2="$Color_Success$Symbol_Ellipsis$Color_Reset "

