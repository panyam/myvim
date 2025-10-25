" ============================================================================
" Vimspector Debugging Configuration
" ============================================================================

" Enable human-readable key mappings
let g:vimspector_enable_mappings = 'HUMAN'

" UI settings
let g:vimspector_sidebar_width = 75
let g:vimspector_bottombar_height = 15

" Sign priorities
let g:vimspector_sign_priority = {
  \    'vimspectorBP':         999,
  \    'vimspectorBPCond':     999,
  \    'vimspectorBPDisabled': 999,
  \    'vimspectorPC':         999,
  \ }

" ============================================================================
" Vimspector Key Mappings
" ============================================================================

" Main debugging controls
nmap <F5> <Plug>VimspectorContinue
nmap <F3> <Plug>VimspectorStop
nmap <F4> <Plug>VimspectorRestart
nmap <F6> <Plug>VimspectorPause

" Breakpoints
nmap <F9> <Plug>VimspectorToggleBreakpoint
nmap <Leader>F9 <Plug>VimspectorToggleConditionalBreakpoint
nmap <F8> <Plug>VimspectorAddFunctionBreakpoint

" Stepping
nmap <F10> <Plug>VimspectorStepOver
nmap <F11> <Plug>VimspectorStepInto
nmap <F12> <Plug>VimspectorStepOut

" Variable inspection
nmap <Leader>di <Plug>VimspectorBalloonEval
xmap <Leader>di <Plug>VimspectorBalloonEval

" ============================================================================
" Vimspector Helper Commands
" ============================================================================

" Quick command to reset vimspector
command! VimspectorReset call vimspector#Reset()

" Command to quickly create/edit .vimspector.json in current directory
command! VimspectorConfig call s:EditVimspectorConfig()

function! s:EditVimspectorConfig()
  let l:config_file = getcwd() . '/.vimspector.json'

  if !filereadable(l:config_file)
    " Create a default configuration
    let l:default_config = [
          \ '{',
          \ '  "configurations": {',
          \ '    "Launch": {',
          \ '      "adapter": "vscode-go",',
          \ '      "configuration": {',
          \ '        "request": "launch",',
          \ '        "program": "${workspaceRoot}/main.go",',
          \ '        "mode": "debug",',
          \ '        "args": []',
          \ '      }',
          \ '    },',
          \ '    "Launch with args": {',
          \ '      "adapter": "vscode-go",',
          \ '      "configuration": {',
          \ '        "request": "launch",',
          \ '        "program": "${workspaceRoot}/main.go",',
          \ '        "mode": "debug",',
          \ '        "args": ["${arg1}", "${arg2}"]',
          \ '      }',
          \ '    },',
          \ '    "Debug current file": {',
          \ '      "adapter": "vscode-go",',
          \ '      "configuration": {',
          \ '        "request": "launch",',
          \ '        "program": "${file}",',
          \ '        "mode": "debug"',
          \ '      }',
          \ '    },',
          \ '    "Attach to running process": {',
          \ '      "adapter": "vscode-go",',
          \ '      "configuration": {',
          \ '        "request": "attach",',
          \ '        "mode": "local",',
          \ '        "processId": "${processId}"',
          \ '      }',
          \ '    }',
          \ '  }',
          \ '}'
          \ ]
    call writefile(l:default_config, l:config_file)
    echo "Created default .vimspector.json"
  endif

  execute 'edit ' . l:config_file
endfunction
