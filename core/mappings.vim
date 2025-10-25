" ============================================================================
" Key Mappings
" ============================================================================

" File operations with current file's directory
map ,f :ALEFix <CR>
map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
map ,t :tabe <C-R>=expand("%:p:h") . "/" <CR>
map ,s :split <C-R>=expand("%:p:h") . "/" <CR>

" Leader key mappings can be added here
" Example: let mapleader = ","
