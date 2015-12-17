#!/bin/bash

##############################
##   Adam Nelson's bashrc   ##
##############################

# Options
# ------------------------------------------------------------

# Use extra globing features. See man bash, search extglob.
shopt -s extglob
# Include .files when globbing.
shopt -s dotglob
# When a glob expands to nothing, make it an empty string instead of the literal characters.
# (disabled because it screws up tab-completion somehow...)
#shopt -s nullglob
# fix spelling errors for cd, only in interactive shell
shopt -s cdspell
# vi mode
set -o vi
export EDITOR=vim

# Large history
export HISTFILESIZE=20000
export HISTSIZE=10000
shopt -s histappend
# Combine multiline commands into one in history
shopt -s cmdhist
# Ignore duplicates, ls without options and builtin commands
HISTCONTROL=ignoredups
export HISTIGNORE="&:ls:[bf]g:exit"

# Solarized dircolors
eval `dircolors ~/dotfiles/dircolors-solarized/dircolors.ansi-dark`

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

source ~/dotfiles/git-prompt.sh

if [ "$TERM" == "linux" ]; then
  # Use ASCII symbols
  Symbol_LBracket="["
  Symbol_RBracket="]"
  Symbol_Ellipsis="..."
else
  # Use Unicode symbols
  Symbol_LBracket="‹"
  Symbol_RBracket="›"
  Symbol_Ellipsis="…"
fi

set_prompt() {
  local Last_Command=$?
  local Current_Directory=$(pwd)
  local Bracket_Color='\[\033[1;37;40m\]'
  local Hostname_Color='\[\033[1;33;40m\]'
  local Directory_Color='\[\033[34m\]'
  local Git_Color='\[\033[33m\]'
  local Success_Color='\[\033[32m\]'
  local Failure_Color='\[\033[31m\]'
  local Reset_Color='\[\033[0;37m\]'

  # Window title
  PS1='\[\033]0;\u@\h:${PWD//[^[:ascii:]]/?}\007\]'
  
  # [user@host]
  PS1+="$Bracket_Color$Symbol_LBracket"
  PS1+="$Hostname_Color"'\u@\h'
  PS1+="$Bracket_Color$Symbol_RBracket"
  PS1+="$Reset_Color"
  
  # Working directory
  PS1+="$Directory_Color "
  case "$Current_Directory" in
    $HOME) PS1+='~';;
    '/') PS1+='/';;
    /[!-.0-~]) PS1+="$Current_Directory";;
    *) PS1+="$Symbol_Ellipsis/$(basename "$Current_Directory")";;
  esac
  PS1+="$Reset_Color"
  
  # Git branch
  if command -v git >/dev/null 2>&1; then
    PS1+="$Git_Color$(__git_ps1)$Reset_Color"
  fi

  # Colorized dash based on last command's exit code
  if [[ $Last_Command == 0 ]]; then
    PS1+="$Success_Color"
  else
    PS1+="$Failure_Color"
  fi
  PS1+=" -$Reset_Color "
}

PROMPT_COMMAND='set_prompt'
PS2='\[\033[1;33m\]'"$Symbol_Ellipsis "'\[\033[0;37m\]'

