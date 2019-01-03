#!/bin/bash

# This script installs symbolic links and stub files that initialize a Linux
# system to use these dotfiles.

STAGING_DIR=`mktemp -d 2>/dev/null || mktemp -d -t 'mytmpdir'`

echo "Installing dotfiles..."
ln -s ~/etc/bashrc $STAGING_DIR/.bashrc
ln -s ~/etc/tmux.conf $STAGING_DIR/.tmux.conf
ln -s ~/etc/ghci.conf $STAGING_DIR/.ghci
ln -s ~/etc/nethackrc $STAGING_DIR/.nethackrc
echo "source ~/etc/vim/vimrc" > $STAGING_DIR/.vimrc
ls $STAGING_DIR
cp -b $STAGING_DIR/.* ~/
rm -rf $STAGING_DIR
mkfifo ~/etc/vim/hol4/fifo
mkdir -p ~/.vim/autoload
cp ~/etc/vim/vim-plug.vim ~/.vim/autoload/plug.vim
mkdir -p ~/.config/nvim
ln -s ~/etc/vim/nvim-init.vim ~/.config/nvim/init.vim
echo "Installation complete."

