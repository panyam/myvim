" ============================================================================
" Rust Filetype Plugin
" Auto-loaded when opening .rs files
" ============================================================================

" Load Rust language configuration
if filereadable(expand('~/.vim/lang/rust.vim'))
  source ~/.vim/lang/rust.vim
endif

" Buffer-local settings for Rust files
setlocal tabstop=4
setlocal shiftwidth=4
setlocal expandtab

" Prevent loading twice
let b:did_ftplugin_rust = 1
