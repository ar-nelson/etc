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
shopt -s nullglob
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

if [ "$TERM" == "linux" ]; then
  # Use ASCII symbols
  PS_SYM_LINEARROW=">"
  PS_SYM_SOLIDARROW=">"
  PS_SYM_GIT="git"
  PS_SYM_ELLIPSIS=""
else
  # Use Powerline symbols
  PS_SYM_LINEARROW=""
  PS_SYM_SOLIDARROW=""
  PS_SYM_GIT=""
  PS_SYM_ELLIPSIS="…"
fi

# Choose prompt color based on the md5sum of user@host
case "$(echo "`whoami`@`hostname`" | md5sum)" in
  [0-3]*)      PROMPT_COLOR='\[\033[32m\]';; # green
  [4-7]*)      PROMPT_COLOR='\[\033[33m\]';; # yellow
  [89abAB]*)   PROMPT_COLOR='\[\033[35m\]';; # purple
  [cdefCDEF]*) PROMPT_COLOR='\[\033[36m\]';; # cyan
  *)           PROMPT_COLOR='\[\033[31m\]';; # red (error)
esac

small_pwd() {
  local pwd=$(pwd)
  case "$pwd" in
    $HOME) echo -n '~';;
    '/') echo -n '/';;
    /[!-.0-~]) echo -n "$pwd";;
    *) echo -n "$PS_SYM_ELLIPSIS/$(basename "$pwd")";;
  esac
}

git_ps1_block() {
  local gitresult=$(__git_ps1 | sed "s/[.][.][.]/$PS_SYM_ELLIPSIS/g")
  if [[ ! -z "$gitresult" ]]; then
    echo -n " $PS_SYM_GIT$gitresult $PS_SYM_LINEARROW"
  fi
}

PS1='\[\033]0;$MSYSTEM:${PWD//[^[:ascii:]]/?}\007\]' # set window title
PS1="$PS1$PROMPT_COLOR"       # colorize
PS1="$PS1$PS_SYM_SOLIDARROW "
PS1="$PS1"'\u@\h'             # user@host
PS1="$PS1 $PS_SYM_LINEARROW "
PS1="$PS1"'`small_pwd`'       # current working directory
PS1="$PS1 $PS_SYM_LINEARROW"
if test -z "$WINELOADERNOEXEC"
then
	GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
	COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
	COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
	COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
	if test -f "$COMPLETION_PATH/git-prompt.sh"
	then
		. "$COMPLETION_PATH/git-completion.bash"
		. "$COMPLETION_PATH/git-prompt.sh"
                GIT_PS1_SHOWDIRTYSTATE=1
                GIT_PS1_SHOWSTASHSTATE=1
		PS1="$PS1"'`git_ps1_block`' # git branch
	fi
fi
PS1="$PS1"'\[\033[0;37m\] '   # reset color

