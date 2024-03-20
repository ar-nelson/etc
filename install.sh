#!/bin/bash

# This script installs symbolic links and stub files that initialize a Linux
# system to use these dotfiles.

lnb() {
  if [ -f "$2" ]; then
    mv -f "$2" "$2~"
  fi
  mkdir -p "$(dirname "$2")"
  ln -s "$1" "$2"
}

echo "Installing dotfiles..."

# .bashrc needs to be a file, not a link, because Debian's .profile uses -f to
# check for its existence
if [[ -f ~/.bashrc  ]]; then
  if [[ "$(head -1 ~/.bashrc)" != "source ~/etc/bashrc" ]]; then
    mv ~/.bashrc ~/.bashrc~
    echo "source ~/etc/bashrc" > ~/.bashrc
  fi
else
  echo "source ~/etc/bashrc" > ~/.bashrc
fi

lnb ~/etc/tmux.conf ~/.tmux.conf
lnb ~/etc/ghci.conf ~/.ghci
lnb ~/etc/nethackrc ~/.nethackrc
lnb ~/etc/vim/vimrc ~/.vimrc

# Pipe for Vim HOL4
#if [ ! -p ~/etc/vim/hol4/fifo ]; then
#  mkfifo ~/etc/vim/hol4/fifo
#fi

# Set up Vim and Neovim folder structure
lnb ~/etc/vim/vim-plug.vim ~/.vim/autoload/plug.vim
lnb ~/etc/vim/nvim-init.vim ~/.config/nvim/init.vim

# Install Vim plugins
if which nvim > /dev/null; then
  nvim --headless +'PlugInstall --sync' +qa
else
  vim +'PlugInstall --sync' +qa
fi

# Set up nvim Python env
if which nvim > /dev/null; then
  mkdir -p ~/.local/venv && pushd ~/.local/venv
  python3 -m venv nvim
  cd nvim
  . ./bin/activate
  pip install pynvim black
  popd
fi

# Set Git identity
if [ -z "$(git config --get user.email)" ]; then
  echo "Setting Git identity..."
  git config --global user.name "Adam R. Nelson"
  git config --global user.email "adam@nels.onl"
fi

echo "Installation complete."

