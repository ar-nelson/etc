set nocompatible
filetype off

set rtp+=~/dotfiles/vim/bundle/Vundle.vim
call vundle#begin('~/dotfiles/vim/bundle')

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-sensible'
Plugin 'rking/ag.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'mtth/scratch.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'Lokaltog/vim-distinguished'
Plugin 'bitc/vim-hdevtools'
Plugin 'kchmck/vim-coffee-script'
Plugin 'dag/vim-fish'
Plugin 'digitaltoad/vim-jade'
Plugin 'ar-nelson/haskell-vim'
Plugin 'PProvost/vim-ps1'
Plugin 'derekwyatt/vim-scala'
Plugin 'wb14123/vim-stylish-haskell'

call vundle#end()
filetype plugin indent on

