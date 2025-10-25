" ============================================================================
" Spelunker (Spell Checker) Configuration
" ============================================================================

" Enable spelunker.vim (default: 1)
" 1: enable, 0: disable
let g:enable_spelunker_vim = 0

" Enable spelunker.vim on readonly files or buffer (default: 0)
let g:enable_spelunker_vim_on_readonly = 0

" Check spelling for words longer than set characters (default: 4)
let g:spelunker_target_min_char_len = 3

" Max amount of word suggestions (default: 15)
let g:spelunker_max_suggest_words = 15

" Max amount of highlighted words in buffer (default: 100)
let g:spelunker_max_hi_words_each_buf = 100

" Spellcheck type (default: 1)
" 1: File checked when opening and saving (may be slow on large files)
" 2: Spellcheck displayed words in buffer (fast and dynamic)
let g:spelunker_check_type = 2

" Highlight type (default: 1)
" 1: Highlight all types (SpellBad, SpellCap, SpellRare, SpellLocal)
" 2: Highlight only SpellBad
let g:spelunker_highlight_type = 1

" Disable specific checking options
let g:spelunker_disable_uri_checking = 1
let g:spelunker_disable_email_checking = 1
let g:spelunker_disable_account_name_checking = 1
let g:spelunker_disable_acronym_checking = 1
let g:spelunker_disable_backquoted_checking = 1
let g:spelunker_disable_auto_group = 1

" Custom autogroup for specific filetypes
augroup spelunker
  autocmd!
  " Setting for g:spelunker_check_type = 1:
  " autocmd BufWinEnter,BufWritePost *.vim,*.js,*.jsx,*.json,*.md call spelunker#check()

  " Setting for g:spelunker_check_type = 2:
  " autocmd CursorHold *.vim,*.js,*.jsx,*.json,*.md call spelunker#check_displayed_words()
augroup END

" Highlight groups
let g:spelunker_spell_bad_group = 'SpelunkerSpellBad'
let g:spelunker_complex_or_compound_word_group = 'SpelunkerComplexOrCompoundWord'

" Override highlight settings
highlight SpelunkerSpellBad cterm=underline ctermfg=247 gui=underline guifg=#9e9e9e
highlight SpelunkerComplexOrCompoundWord cterm=underline ctermfg=NONE gui=underline guifg=NONE
