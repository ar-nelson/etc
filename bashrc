#!/bin/bash

##############################
##   Adam Nelson's bashrc   ##
##############################

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Options
# ------------------------------------------------------------

shopt -s extglob
shopt -s dotglob
shopt -s cdspell
export EDITOR=vim
export VIMHOL_FIFO="$HOME/etc/vim/hol4/fifo"

export HISTFILESIZE=20000
export HISTSIZE=10000
shopt -s histappend
shopt -s cmdhist
shopt -s checkwinsize
HISTCONTROL=ignoreboth
export HISTIGNORE="&:ls:[bf]g:exit"

PATH="~/bin:$PATH"

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

Color_Reset='\[\033[0m\]'
Color_Directory='\[\033[90m\]'
Color_Success='\[\033[93m\]'
Color_Failure='\[\033[33m\]'
Color_Git='\[\033[32m\]'
Color_Jobs='\[\033[91m\]'

if [ "$TERM" == "linux" ]; then
  # Use ASCII symbols
  Symbol_Ellipsis="..."
  Symbol_Jobs="*"
else
  # Use Unicode symbols
  Symbol_Ellipsis="…"
  Symbol_Jobs="⚐"
fi

set_prompt() {
  local Last_Command=$?
  local Current_Directory=$(pwd)

  # Window title
  PS1='\[\033]0;\u@\h:${PWD//[^[:ascii:]]/?}\007\]'
  
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

  # Background jobs
  if [ -n "$(jobs -p)" ]; then
    PS1+=" $Color_Jobs$Symbol_Jobs\\j$Color_Reset"
  fi

  # Colorized dash based on last command's exit code
  if [[ $Last_Command == 0 ]]; then
    PS1+=" $Color_Success->"
  else
    PS1+=" $Color_Failure~>"
  fi
  PS1+="$Color_Reset "
}

PROMPT_COMMAND='set_prompt'
PS2="$Color_Success$Symbol_Ellipsis$Color_Reset "

