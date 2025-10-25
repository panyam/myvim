" ============================================================================
" Profile/Workspace Management
" ============================================================================

" Track current profile
let g:vim_profile = get(g:, 'vim_profile', 'default')

" Load a specific profile
function! LoadProfile(profile)
  let l:profile_file = expand('~/.vim/lang/' . a:profile . '.vim')
  if filereadable(l:profile_file)
    execute 'source ' . l:profile_file
    let g:vim_profile = a:profile
    echo "Loaded profile: " . a:profile
  else
    echoerr "Profile not found: " . a:profile
  endif
endfunction

" Command to switch profiles
command! -nargs=1 -complete=customlist,ProfileComplete Profile call LoadProfile(<f-args>)

" Auto-completion for Profile command
function! ProfileComplete(ArgLead, CmdLine, CursorPos)
  let l:profiles = []
  for file in split(globpath('~/.vim/lang', '*.vim'), '\n')
    let l:profile_name = fnamemodify(file, ':t:r')
    call add(l:profiles, l:profile_name)
  endfor
  return filter(l:profiles, 'v:val =~ "^" . a:ArgLead')
endfunction

" Auto-detect profile based on project files
function! AutoDetectProfile()
  if filereadable('go.mod') || filereadable('main.go') || expand('%:e') == 'go'
    call LoadProfile('go')
  elseif filereadable('package.json') || filereadable('tsconfig.json')
    call LoadProfile('javascript')
  elseif filereadable('requirements.txt') || filereadable('setup.py')
    call LoadProfile('python')
  elseif filereadable('Cargo.toml')
    call LoadProfile('rust')
  endif
endfunction

" Auto-detect profile on startup (optional - comment out if not wanted)
" autocmd VimEnter * call AutoDetectProfile()

" Command to show current profile
command! ProfileShow echo "Current profile: " . g:vim_profile
