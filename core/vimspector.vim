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

" Customize breakpoint and execution signs
" You can customize the appearance with signcolumn characters
" Uncomment and modify these to change the appearance:
" sign define vimspectorBP text=●  texthl=WarningMsg
" sign define vimspectorBPCond text=◆  texthl=WarningMsg
" sign define vimspectorBPLog text=◆  texthl=SpellRare
" sign define vimspectorBPDisabled text=●  texthl=LineNr
" sign define vimspectorPC text=▶  texthl=MatchParen linehl=CursorLine
" sign define vimspectorPCBP text=●▶ texthl=MatchParen linehl=CursorLine

" Highlight groups for better visibility
" Customize these colors to your preference
highlight vimspectorBP ctermfg=Red guifg=#ff0000
highlight vimspectorBPCond ctermfg=Yellow guifg=#ffff00
highlight vimspectorPC ctermbg=DarkBlue guibg=#005f87

" UI Layout Configuration
" Customize the window layout by setting g:vimspector_ui_config
"
" Available windows and their default positions:
" let g:vimspector_ui_config = {
"   \   'WinBar': { 'pos': 'top' },
"   \   'Variables': { 'pos': 'left', 'width': 50 },
"   \   'Watches': { 'pos': 'left', 'width': 50 },
"   \   'Stack': { 'pos': 'left', 'width': 50 },
"   \   'Breakpoints': { 'pos': 'left', 'width': 50 },
"   \   'Output': { 'pos': 'bottom', 'height': 10 },
"   \   'Console': { 'pos': 'bottom', 'height': 10 },
"   \   'Disassembly': { 'pos': 'bottom', 'height': 10 }
"   \ }
"
" Position options: 'left', 'right', 'top', 'bottom'
" Size options: 'width' (for left/right), 'height' (for top/bottom)
"
" Project-specific layouts:
"   You can also set this in your project's .vimspector.json:
"   {
"     "ui": {
"       "Variables": { "pos": "right", "width": 60 },
"       "Stack": { "pos": "right", "width": 60 }
"     },
"     "configurations": { ... }
"   }
"
" Default: Use vimspector's built-in layout
let g:vimspector_ui_config = {}
" To customize globally, uncomment and modify the dictionary above

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
" Vimspector Helper Commands (Command-Mode Interface)
" ============================================================================

" Debugging control commands
command! DebugStart call vimspector#Continue()
command! DebugContinue call vimspector#Continue()
command! DebugStop call vimspector#Stop() | call vimspector#Reset()
command! DebugRestart call vimspector#Restart()
command! DebugPause call vimspector#Pause()
command! DebugReset call vimspector#Reset()

" Auto-close vimspector panels when debugging stops
augroup VimspectorAutoClose
  autocmd!
  " When a debug session ends, reset vimspector (closes panels)
  autocmd User VimspectorDebugEnded call vimspector#Reset()
augroup END

" Breakpoint commands
command! BreakAdd call vimspector#ToggleBreakpoint()
command! BreakToggle call vimspector#ToggleBreakpoint()
command! BreakDel call vimspector#ToggleBreakpoint()
command! BreakCond call vimspector#ToggleAdvancedBreakpoint()
command! BreakFunc call vimspector#AddFunctionBreakpoint()
command! BreakClearAll call vimspector#ClearBreakpoints()

" Stepping commands
command! StepOver call vimspector#StepOver()
command! StepInto call vimspector#StepInto()
command! StepOut call vimspector#StepOut()
command! RunToCursor call vimspector#RunToCursor()

" Legacy command for backwards compatibility
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
