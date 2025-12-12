" ============================================================================
" LaTeX/TeX Filetype Plugin
" Auto-loaded when opening .tex files
" ============================================================================

" Load LaTeX language configuration
if filereadable(expand('~/.vim/lang/tex.vim'))
  source ~/.vim/lang/tex.vim
endif

" Buffer-local settings for LaTeX files
setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab
setlocal spell
setlocal wrap
setlocal linebreak

" Prevent loading twice
let b:did_ftplugin_tex = 1
