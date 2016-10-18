#!/bin/bash

# This script installs symbolic links and stub files that initialize a Linux
# system to use these dotfiles.

STAGING_DIR=`mktemp -d 2>/dev/null || mktemp -d -t 'mytmpdir'`

echo "Installing dotfiles..."
ln -s ~/etc/bashrc $STAGING_DIR/.bashrc
ln -s ~/etc/tmux.conf $STAGING_DIR/.tmux.conf
ln -s ~/etc/ghci.conf $STAGING_DIR/.ghci
ln -s ~/etc/Xresources $STAGING_DIR/.Xresources
echo "source ~/etc/vim/vimrc" > $STAGING_DIR/.vimrc
ls $STAGING_DIR
cp -b $STAGING_DIR/.* ~/
rm -rf $STAGING_DIR
~/etc/scripts/git-colors.sh
mkfifo ~/etc/vim/hol4/fifo
echo "Installation complete."

