set nocompatible
filetype off

call plug#begin('~/.vim/bundle')

Plug 'nanotech/jellybeans.vim'
if has('nvim-0.5.0')
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'elentok/format-on-save.nvim'
  Plug 'folke/trouble.nvim'
  Plug 'mrcjkb/haskell-tools.nvim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'scalameta/nvim-metals'
else
  Plug 'sheerun/vim-polyglot'
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
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
Plug 'Shougo/echodoc.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'lervag/vimtex'
Plug 'cypok/vim-sml'
Plug 'ar-nelson/vim-syntax-hol4'
Plug 'tjvr/vim-nearley'
Plug 'lluchs/vim-wren'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'bfrg/vim-cpp-modern'
Plug 'mcnelson/vim-pawn'
Plug 'ziglang/zig.vim'
Plug 'bakpakin/janet.vim'
Plug 'dcharbon/vim-flatbuffers'
Plug 'vim-scripts/gitignore'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

