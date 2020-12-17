set nocompatible
filetype off

call plug#begin('~/.vim/bundle')

Plug 'nanotech/jellybeans.vim'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
"Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'
Plug 'chip/vim-fat-finger'
Plug 'sheerun/vim-polyglot'
Plug 'mileszs/ack.vim', { 'on': 'Ack' }
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'Shougo/echodoc.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'w0rp/ale'
Plug 'ar-nelson/haskell-vim'
Plug 'wb14123/vim-stylish-haskell'
Plug 'lervag/vimtex'
Plug 'Shougo/deoplete.nvim'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'cypok/vim-sml'
Plug 'ar-nelson/vim-syntax-hol4'
Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'tjvr/vim-nearley'
Plug 'mxw/vim-jsx'
Plug 'vim-scripts/gitignore'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

