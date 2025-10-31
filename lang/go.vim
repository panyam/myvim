" ============================================================================
" Go Language Configuration
" ============================================================================

" Main debugging command
" Usage: :GoDebug <target> [args...]
" Examples:
"   :GoDebug main.go
"   :GoDebug . --port 8080
"   :GoDebug ./cmd/cli --dryrun --game-id c5380903 tiles
command! -nargs=+ GoDebug call s:GoDebug(<f-args>)

" Debug with stdin redirection
" Usage: :GoDebugStdin <input-file> <target> [args...]
" Examples:
"   :GoDebugStdin testdata/input.txt main.go
"   :GoDebugStdin input.txt . --config dev.yaml
command! -nargs=+ GoDebugStdin call s:GoDebugStdin(<f-args>)

" Attach to a running Go process
" Usage: :GoDebugAttach <pid>
command! -nargs=1 GoDebugAttach call s:GoDebugAttach(<f-args>)

function! s:GoDebug(target, ...)
  " First argument is the target (main.go, ., ./cmd/cli, etc.)
  " Rest are program arguments
  let l:target = a:target
  let l:args = a:000

  " Build configuration
  let l:launch_config = {
        \ 'request': 'launch',
        \ 'program': l:target,
        \ 'mode': 'debug'
        \ }

  " Add args if provided
  if len(l:args) > 0
    let l:launch_config['args'] = l:args
  endif

  " Create ad-hoc configuration
  let l:configurations = {
        \ 'GoDebug': {
        \   'adapter': 'vscode-go',
        \   'configuration': l:launch_config
        \ }
        \ }

  " Launch vimspector
  call vimspector#LaunchWithConfigurations(l:configurations)
endfunction

function! s:GoDebugStdin(input_file, target, ...)
  " First argument is the input file
  " Second argument is the target
  " Rest are program arguments
  let l:input_file = a:input_file
  let l:target = a:target
  let l:args = a:000

  " Check if input file exists
  if !filereadable(l:input_file)
    echoerr "Input file not found: " . l:input_file
    return
  endif

  " Build configuration with stdin redirection
  let l:launch_config = {
        \ 'request': 'launch',
        \ 'program': l:target,
        \ 'mode': 'debug',
        \ 'input': fnamemodify(l:input_file, ':p'),
        \ 'console': 'integratedTerminal'
        \ }

  " Add args if provided
  if len(l:args) > 0
    let l:launch_config['args'] = l:args
  endif

  " Create ad-hoc configuration
  let l:configurations = {
        \ 'GoDebugStdin': {
        \   'adapter': 'vscode-go',
        \   'configuration': l:launch_config
        \ }
        \ }

  " Launch vimspector
  call vimspector#LaunchWithConfigurations(l:configurations)
endfunction

function! s:GoDebugAttach(pid)
  " Attach to a running process by PID
  let l:configurations = {
        \ 'GoDebugAttach': {
        \   'adapter': 'vscode-go',
        \   'configuration': {
        \     'request': 'attach',
        \     'mode': 'local',
        \     'processId': a:pid
        \   }
        \ }
        \ }
  call vimspector#LaunchWithConfigurations(l:configurations)
endfunction

" Go-specific settings can be added here
" For example:
" - Build tags
" - Test configurations
" - Formatting options
