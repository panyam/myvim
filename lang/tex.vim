" ============================================================================
" LaTeX/TeX Language Configuration (VimTeX)
" ============================================================================

" Ensure vim treats .tex files as LaTeX (not plain TeX)
let g:tex_flavor = 'latex'

" ============================================================================
" PDF Viewer Configuration (macOS - Skim)
" ============================================================================
" Skim supports SyncTeX for forward/inverse search
let g:vimtex_view_method = 'skim'

" Skim settings for better integration
let g:vimtex_view_skim_sync = 1
let g:vimtex_view_skim_activate = 1

" ============================================================================
" Compiler Configuration
" ============================================================================
" Use latexmk for continuous compilation
let g:vimtex_compiler_method = 'latexmk'

" Latexmk options
let g:vimtex_compiler_latexmk = {
    \ 'build_dir': '',
    \ 'callback': 1,
    \ 'continuous': 1,
    \ 'executable': 'latexmk',
    \ 'options': [
    \   '-pdf',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}

" ============================================================================
" Quickfix Configuration
" ============================================================================
" Open quickfix on errors but don't focus it
let g:vimtex_quickfix_mode = 2
let g:vimtex_quickfix_open_on_warning = 0

" ============================================================================
" Folding Configuration
" ============================================================================
let g:vimtex_fold_enabled = 1

" ============================================================================
" Table of Contents Configuration
" ============================================================================
let g:vimtex_toc_config = {
    \ 'split_pos': 'vert leftabove',
    \ 'split_width': 40,
    \}

" ============================================================================
" Completion Configuration
" ============================================================================
" Enable completion with coc.nvim (if installed)
" Note: You may want to install coc-vimtex for enhanced completion

" ============================================================================
" Key Mappings (VimTeX defaults, listed for reference)
" ============================================================================
" VimTeX provides these mappings by default (leader is usually \):
"   \ll - Start/stop continuous compilation
"   \lv - View PDF
"   \lc - Clean auxiliary files
"   \lC - Clean auxiliary and output files
"   \lt - Toggle table of contents
"   \le - View errors in quickfix
"   \lk - Stop compilation
"   \lg - Show compilation status

" ============================================================================
" Custom Commands
" ============================================================================
" Quick compile and view
command! -buffer TexCompile VimtexCompile
command! -buffer TexView VimtexView
command! -buffer TexClean VimtexClean
command! -buffer TexToc VimtexTocToggle
command! -buffer TexErrors VimtexErrors
