" ============================================================================
" Python Filetype Plugin
" Auto-loaded when opening .py files
" ============================================================================

" Load Python language configuration
if filereadable(expand('~/.vim/lang/python.vim'))
  source ~/.vim/lang/python.vim
endif

" Buffer-local settings for Python files
setlocal tabstop=4
setlocal shiftwidth=4
setlocal expandtab

" Prevent loading twice
let b:did_ftplugin_python = 1
