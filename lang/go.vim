" ============================================================================
" Go Language Configuration
" ============================================================================

" Custom command to start Go debugging with arguments
" Usage: :GoDB arg1 arg2 arg3
command! -nargs=* GoDB call s:StartGoDebug([<f-args>])

function! s:StartGoDebug(args)
  " Get the main.go file or current file
  let l:main_file = filereadable('main.go') ? 'main.go' : expand('%:p')

  " Launch vimspector with configuration
  call vimspector#LaunchWithSettings({
        \ 'configuration': 'Launch',
        \ 'program': l:main_file,
        \ 'args': a:args
        \ })
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
