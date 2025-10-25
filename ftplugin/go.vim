" ============================================================================
" Go Filetype Plugin
" Auto-loaded when opening .go files
" ============================================================================

" Load Go language configuration
if filereadable(expand('~/.vim/lang/go.vim'))
  source ~/.vim/lang/go.vim
endif

" Buffer-local settings for Go files
setlocal tabstop=4
setlocal shiftwidth=4
setlocal noexpandtab

" Go-specific key mappings (buffer-local)
" Example: map ,r :!go run %<CR>

" Prevent loading twice
let b:did_ftplugin_go = 1
