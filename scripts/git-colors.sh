#!/bin/bash

# Defines 'teal-orange'-compatible Git colors.

git config --global color.ui "auto"

git config --global color.branch.current "yellow bold"
git config --global color.branch.local "yellow"
git config --global color.branch.remote "green"

git config --global color.diff.meta "yellow bold"
git config --global color.diff.frag "yellow"
git config --global color.diff.old "red"
git config --global color.diff.new "cyan"

git config --global color.status.added "cyan"
git config --global color.status.changed "yellow"
git config --global color.status.untracked "red"

