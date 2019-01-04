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

lnb ~/etc/bashrc ~/.bashrc
lnb ~/etc/tmux.conf ~/.tmux.conf
lnb ~/etc/ghci.conf ~/.ghci
lnb ~/etc/nethackrc ~/.nethackrc
lnb ~/etc/vim/vimrc ~/.vimrc

# Pipe for Vim HOL4
if [ ! -p ~/etc/vim/hol4/fifo ]; then
  mkfifo ~/etc/vim/hol4/fifo
fi

# Set up Vim and Neovim folder structure
lnb ~/etc/vim/vim-plug.vim ~/.vim/autoload/plug.vim
lnb ~/etc/vim/nvim-init.vim ~/.config/nvim/init.vim

# Set Git identity
if [ -z "$(git config --get user.email)" ]; then
  echo "Setting Git identity..."
  git config --global user.name "Adam R. Nelson"
  git config --global user.email "adam@nels.onl"
fi

echo "Installation complete."

