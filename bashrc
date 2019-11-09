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
if which nvim > /dev/null; then
  export EDITOR=nvim
elif which vim > /dev/null; then
  export EDITOR=vim
else
  export EDITOR=vi
fi
export VIMHOL_FIFO="$HOME/etc/vim/hol4/fifo"

export HISTFILESIZE=20000
export HISTSIZE=10000
shopt -s histappend
shopt -s cmdhist
shopt -s checkwinsize
HISTCONTROL=ignoreboth
export HISTIGNORE="&:ls:[bf]g:exit"

source /usr/share/doc/fzf/examples/key-bindings.bash
export FZF_TMUX=1
export FZF_DEFAULT_COMMAND='rg --files --hidden'

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

if which nvim > /dev/null; then
  alias vim='nvim'
fi
if which rg > /dev/null; then
  alias ag='rg'
fi
if which most > /dev/null; then
  alias less=most
  export PAGER=most
fi

alias lg='lazygit'

# Prompt
# ------------------------------------------------------------

source ~/etc/scripts/git-prompt.sh

Color_Reset='\[\033[0m\]'
Color_Hostname='\[\033[90m\]'
Color_Directory='\[\033[90m\]'
Color_Success='\[\033[93m\]'
Color_Failure='\[\033[91m\]'
Color_Git='\[\033[32m\]'
Color_Jobs='\[\033[91m\]'

if [[ "$TERM" == "linux" ]]; then
  # Use ASCII symbols
  Symbol_Ellipsis="..."
  Symbol_Prompt="$"
  Symbol_Jobs="*"
else
  # Use Unicode symbols
  Symbol_Ellipsis="…"
  Symbol_Prompt="•"
  Symbol_Jobs="⚐"
fi

# If the PWD matches this regex, it will be cut down to only the match
Directory_Clip_Regex='~?/(.{0,15}|[^/]*)$'

Bashrc_Directory() {
  if [[ "$(dirs +0)" =~ $Directory_Clip_Regex ]]; then
    if [[ "$(dirs +0)" != "$BASH_REMATCH" ]]; then
      echo -n "$Symbol_Ellipsis"
    fi
    echo -n "$BASH_REMATCH"
  else
    dirs +0
  fi
}

Bashrc_Prompt() {
  local Last_Command=$?
  local Directory="$(Bashrc_Directory)"

  # Window Title
  PS1="\[\e]0;$Directory\a\]"

  # Hostname
  PS1+="$Color_Hostname\\h "

  # Working directory
  PS1+="$Color_Directory"
  PS1+="$Directory"
  PS1+="$Color_Reset"
  
  # Git branch
  if command -v git >/dev/null 2>&1; then
    PS1+="$Color_Git$(__git_ps1)$Color_Reset"
  fi

  # Background jobs
  if [[ -n "$(jobs -p)" ]]; then
    PS1+=" $Color_Jobs$Symbol_Jobs\\j$Color_Reset"
  fi

  # Colorized dot based on last command's exit code
  if [[ $Last_Command == 0 ]]; then
    PS1+=" $Color_Success"
  else
    PS1+=" $Color_Failure"
  fi
  PS1+="$Symbol_Prompt$Color_Reset "
}

PROMPT_COMMAND='Bashrc_Prompt'
PS2="$Color_Success$Symbol_Ellipsis$Color_Reset "

# Window Title
# ------------------------------------------------------------

Bashrc_Window_Title() {
  case "$1" in
    # The first two cases prevent recursion
    *\033]O*|*\\e]0*)
      true;;
    Bashrc_*)
      true;;
    *)
      printf "\e]0;%s $ %s\a" "$(Bashrc_Directory)" "$1";;
  esac
}

# Open a file descriptor to /dev/tty, to write window titles
# without printing them into command groups.
#
# The trailing "||:" prevents this from being an error if it fails.
#
# https://stackoverflow.com/a/48407412
#
exec {tty_fd}>/dev/tty ||:

# Use a DEBUG trap to rewrite the window title on each command.
# This provides a command name in the title bar, for KeePass to autofill on.
#
trap '[[ $tty_fd ]] && Bashrc_Window_Title "${BASH_COMMAND}" >&$tty_fd ||:' DEBUG
