#!/bin/bash

# Defines METACHROME-compatible Git colors.

git config --global color.ui "auto"

git config --global color.branch.current "yellow reverse"
git config --global color.branch.local "yellow"
git config --global color.branch.remote "green"

git config --global color.diff.meta "white bold"
git config --global color.diff.frag "blue bold"
git config --global color.diff.old "red bold"
git config --global color.diff.new "green bold"

git config --global color.status.added "green bold"
git config --global color.status.changed "white bold"
git config --global color.status.untracked "red bold"

