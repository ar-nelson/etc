set nocompatible
filetype off

call plug#begin('~/.vim/bundle')

Plug 'nanotech/jellybeans.vim'
if has('nvim-0.5.0')
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/playground'
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-compe'
else
  Plug 'sheerun/vim-polyglot'
  Plug 'w0rp/ale'
endif
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'
Plug 'chip/vim-fat-finger'
Plug 'mileszs/ack.vim', { 'on': 'Ack' }
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'Shougo/echodoc.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'ar-nelson/haskell-vim'
Plug 'wb14123/vim-stylish-haskell'
Plug 'lervag/vimtex'
Plug 'cypok/vim-sml'
Plug 'ar-nelson/vim-syntax-hol4'
Plug 'tjvr/vim-nearley'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'vim-scripts/gitignore'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

