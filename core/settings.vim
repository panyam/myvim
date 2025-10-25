" ============================================================================
" General Settings
" ============================================================================

" Compatibility and basic settings
set nocompatible
filetype plugin indent on
syntax on

" Display settings
set number                " Show line numbers
set hlsearch             " Highlight search results
set signcolumn=yes       " Always show sign column (for breakpoints, etc.)
colorscheme slate

" Tab and indentation settings
set tabstop=2            " Width (in spaces) that a <tab> is displayed as
set expandtab            " Expand tabs to spaces
set shiftwidth=2         " Width (in spaces) used in each step of autoindent
set tw=120               " Text width

" File handling
set wildignore+=*.js.map
set wildignore+=*.d.ts

" Swap and backup files
set directory=$HOME/.vim/swapfiles//,/tmp//

" Bell and visual settings
set noerrorbells visualbell t_vb=

" Regular expression engine
set regexpengine=0

" Python host for plugins
let g:python3_host_prog="/Users/sri/.pyenv/shims/python"

" Deoplete (autocomplete)
let g:deoplete#enable_at_startup = 1

" Project-local vimrc support (secure mode)
set exrc              " Enable reading .vimrc in current directory
set secure            " Restrict unsafe commands in local .vimrc
