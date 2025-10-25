" ============================================================================
" Go Language Configuration
" ============================================================================

" Custom command to start Go debugging with arguments
" Usage: :GoDB arg1 arg2 arg3
command! -nargs=* GoDB call s:StartGoDebug([<f-args>], '')

" Custom command to prompt for arguments before debugging
" Usage: :GoDBPrompt
command! GoDBPrompt call s:GoDBWithPrompt()

" Custom command to debug with stdin from a file
" Usage: :GoDBStdin input.txt arg1 arg2
" Usage: :GoDBStdin testdata/input.txt --config dev.yaml
command! -nargs=+ GoDBStdin call s:GoDBWithStdin(<f-args>)

function! s:StartGoDebug(args, input_file)
  " Get the main.go file or current file
  let l:main_file = filereadable('main.go') ? 'main.go' : expand('%:p')

  " Build configuration
  let l:config = {
        \ 'configuration': 'Launch',
        \ 'program': l:main_file,
        \ 'args': a:args
        \ }

  " Add stdin redirection if input file is specified
  if a:input_file != ''
    let l:full_path = fnamemodify(a:input_file, ':p')
    let l:config['input'] = l:full_path
    let l:config['console'] = 'integratedTerminal'
  endif

  " Launch vimspector with configuration
  call vimspector#LaunchWithSettings(l:config)
endfunction

function! s:GoDBWithPrompt()
  " Prompt user for arguments
  let l:args_str = input('Debug arguments: ')

  " If user provided arguments, split and debug
  if l:args_str != ''
    execute 'GoDB ' . l:args_str
  else
    " No arguments, just run GoDB
    execute 'GoDB'
  endif
endfunction

function! s:GoDBWithStdin(...)
  " First argument is the input file, rest are program arguments
  if a:0 < 1
    echoerr "Usage: GoDBStdin <input-file> [args...]"
    return
  endif

  let l:input_file = a:1
  let l:args = a:000[1:]  " Rest of arguments

  " Check if input file exists
  if !filereadable(l:input_file)
    echoerr "Input file not found: " . l:input_file
    return
  endif

  " Call StartGoDebug with input file
  call s:StartGoDebug(l:args, l:input_file)
endfunction

" Command to debug the current Go file
command! GoDebugFile call vimspector#LaunchWithSettings({
      \ 'configuration': 'Debug current file'
      \ })

" Command to attach to a running Go process
command! -nargs=1 GoDebugAttach call vimspector#LaunchWithSettings({
      \ 'configuration': 'Attach to running process',
      \ 'processId': <f-args>
      \ })

" Go-specific settings can be added here
" For example:
" - Build tags
" - Test configurations
" - Formatting options
