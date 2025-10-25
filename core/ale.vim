" ============================================================================
" ALE (Asynchronous Lint Engine) Configuration
" ============================================================================

" Linters configuration
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['tsserver', 'eslint'],
\   'javascriptreact': ['prettier', 'eslint'],
\   'typescriptreact': ['tsserver', 'eslint'],
\   'python': ['pylint'],
\   'vue': ['eslint'],
\   'go': ['gopls']
\}

" Fixers configuration
let g:ale_fixers = {
\    'javascript': ['eslint'],
\    'typescript': ['eslint'],
\    'typescriptreact': ['eslint'],
\    'js': ['eslint'],
\    'ts': ['eslint'],
\    'tsx': ['eslint'],
\    'vue': ['eslint'],
\    'scss': ['prettier'],
\    'html': ['prettier']
\}

" ALE signs
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'

" ALE behavior
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let b:ale_fix_on_save = 1

" Ignore specific linters
let g:ale_linters_ignore = {'typescript': ['tslint']}
