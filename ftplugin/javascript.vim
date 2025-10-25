" ============================================================================
" JavaScript Filetype Plugin
" Auto-loaded when opening .js files
" ============================================================================

" Load JavaScript language configuration
if filereadable(expand('~/.vim/lang/javascript.vim'))
  source ~/.vim/lang/javascript.vim
endif

" Buffer-local settings for JavaScript files
setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab

" Prevent loading twice
let b:did_ftplugin_javascript = 1
