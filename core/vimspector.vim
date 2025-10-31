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
" These define the visual appearance of debugging indicators in the sign column

" Breakpoint signs
sign define vimspectorBP text=●  texthl=WarningMsg
sign define vimspectorBPCond text=◆  texthl=WarningMsg
sign define vimspectorBPLog text=◆  texthl=SpellRare
sign define vimspectorBPDisabled text=●  texthl=LineNr

" Program Counter (current line) signs with line highlighting
" linehl= parameter highlights the entire line for clear visibility during stepping
sign define vimspectorPC text=▶  texthl=MatchParen linehl=VimspectorCurrentLine
sign define vimspectorPCBP text=●▶ texthl=MatchParen linehl=VimspectorCurrentLine

" Highlight groups for better visibility
" Customize these colors to your preference
highlight vimspectorBP ctermfg=Red guifg=#ff0000
highlight vimspectorBPCond ctermfg=Yellow guifg=#ffff00

" Current line highlighting - using a distinct color that stands out
" This is applied to the entire line when the debugger is paused
highlight VimspectorCurrentLine ctermbg=DarkBlue ctermfg=White guibg=#005f87 guifg=#ffffff

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
nmap <F3> :call vimspector#Stop()<CR>:call vimspector#Reset()<CR>
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
" NOTE: We handle this in the DebugStop command instead of using an autocommand
" to avoid infinite recursion (Reset triggers DebugEnded which would trigger Reset again)
" augroup VimspectorAutoClose
"   autocmd!
"   autocmd User VimspectorDebugEnded call vimspector#Reset()
" augroup END

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

" Short convenience commands (available anytime)
command! -nargs=0 BR call vimspector#ToggleBreakpoint()
command! -nargs=0 DR call vimspector#Restart()

" Legacy command for backwards compatibility
command! VimspectorReset call vimspector#Reset()

" Command to quickly create/edit .vimspector.json in current directory
command! VimspectorConfig call s:EditVimspectorConfig()

" ============================================================================
" Vimspector UI Customization
" ============================================================================

" Customize UI windows when vimspector starts
function! s:CustomizeVimspectorUI()
  " Enable text wrapping in the Stack Trace window so long method names wrap
  " instead of requiring horizontal scrolling or window resizing
  if exists('g:vimspector_session_windows.stack_trace')
    call win_gotoid(g:vimspector_session_windows.stack_trace)
    setlocal wrap
    setlocal linebreak  " Break at word boundaries for cleaner wrapping
    wincmd p  " Return to previous window
  endif
endfunction

" Auto-customize UI when vimspector session starts
augroup VimspectorUICustomization
  autocmd!
  autocmd User VimspectorUICreated call s:CustomizeVimspectorUI()
augroup END

" ============================================================================
" Debug Mode Convenience Mappings (only active during debug sessions)
" ============================================================================

" Smart continue function: Continue if at paused line, RunToCursor otherwise
function! s:SmartContinue()
  " Get current line
  let l:current_line = line('.')

  " Try to get the current PC (program counter) line from vimspector
  " If we're at the same line as PC, do Continue; otherwise RunToCursor
  try
    let l:pc_line = vimspector#GetPCLine()
    if l:pc_line == l:current_line
      call vimspector#Continue()
    else
      call vimspector#RunToCursor()
    endif
  catch
    " If we can't get PC line, just do RunToCursor
    call vimspector#RunToCursor()
  endtry
endfunction

" Track debug session state
let g:vimspector_debug_active = 0

" Set up debug commands for a buffer
function! s:SetupDebugCommandsForBuffer()
  " Only set commands in code buffers, not debug windows
  if &buftype == '' && g:vimspector_debug_active
    " Buffer-local convenience commands (only active during debug)
    if !exists(':SI')
      command! -buffer -nargs=0 SI call vimspector#StepInto()
    endif
    if !exists(':SN')
      command! -buffer -nargs=0 SN call vimspector#StepOver()
    endif
    if !exists(':SO')
      command! -buffer -nargs=0 SO call vimspector#StepOut()
    endif
    if !exists(':CO')
      command! -buffer -nargs=0 CO call <SID>SmartContinue()
    endif
    if !exists(':DS')
      command! -buffer -nargs=0 DS call vimspector#Stop() | call vimspector#Reset()
    endif

    " Map Enter to Step Over (most common action)
    nnoremap <buffer> <silent> <CR> :call vimspector#StepOver()<CR>
  endif
endfunction

" Set up debug commands when debug session starts
function! s:OnDebugStart()
  let g:vimspector_debug_active = 1
  " Set up commands for current buffer
  call s:SetupDebugCommandsForBuffer()
  echo "Debug commands: <Enter>=StepOver :SI=StepInto :SN=StepOver :SO=StepOut :CO=Continue :DS=Stop | Always: :BR=Break :DR=Restart"
endfunction

" Remove debug commands from a buffer
function! s:RemoveDebugCommandsFromBuffer()
  if &buftype == ''
    " Remove buffer-local commands
    silent! delcommand SI
    silent! delcommand SN
    silent! delcommand SO
    silent! delcommand CO
    silent! delcommand DS

    " Remove Enter mapping
    silent! nunmap <buffer> <CR>
  endif
endfunction

" Remove debug commands when debug session ends
function! s:OnDebugEnd()
  let g:vimspector_debug_active = 0

  " Remove commands from all buffers
  let l:current_buf = bufnr('%')
  for l:buf in getbufinfo({'buflisted': 1})
    if getbufvar(l:buf.bufnr, '&buftype') == ''
      execute 'buffer ' . l:buf.bufnr
      call s:RemoveDebugCommandsFromBuffer()
    endif
  endfor
  execute 'buffer ' . l:current_buf
endfunction

" Set up autocommands to enable/disable commands automatically
augroup VimspectorDebugMappings
  autocmd!
  " When debug UI is created, mark debug as active and set up commands
  autocmd User VimspectorUICreated call s:OnDebugStart()
  " When entering a buffer during debug, set up commands for that buffer
  autocmd BufEnter * call s:SetupDebugCommandsForBuffer()
  " When debug session ends, remove all commands
  autocmd User VimspectorDebugEnded call s:OnDebugEnd()
augroup END

" ============================================================================
" Vimspector Helper Functions
" ============================================================================

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
