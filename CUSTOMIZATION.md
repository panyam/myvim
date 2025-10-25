# Vimspector Debugging Customization Guide

## Breakpoint Visibility

### Make Breakpoints More Visible

Edit `~/.vim/core/vimspector.vim` and uncomment/modify the sign definitions (around line 23):

```vim
" Uncomment and customize these lines:
sign define vimspectorBP text=●  texthl=WarningMsg
sign define vimspectorBPCond text=◆  texthl=WarningMsg
sign define vimspectorBPLog text=◆  texthl=SpellRare
sign define vimspectorBPDisabled text=●  texthl=LineNr
sign define vimspectorPC text=▶  texthl=MatchParen linehl=CursorLine
sign define vimspectorPCBP text=●▶ texthl=MatchParen linehl=CursorLine
```

### Sign Character Options

Common breakpoint characters:
- `●` - Filled circle (default, good visibility)
- `○` - Empty circle
- `⬤` - Large filled circle
- `◆` - Filled diamond
- `◇` - Empty diamond
- `▶` - Right arrow (for current execution line)
- `⚫` - Large black circle
- `🔴` - Red circle (if your terminal supports emoji)

### Highlight Colors

Customize the colors (around line 32):

```vim
" Terminal colors (ctermfg/ctermbg)
highlight vimspectorBP ctermfg=Red ctermbg=NONE
highlight vimspectorBPCond ctermfg=Yellow ctermbg=NONE
highlight vimspectorPC ctermbg=DarkBlue ctermfg=White

" GUI colors (guifg/guibg)
highlight vimspectorBP guifg=#ff0000 guibg=NONE
highlight vimspectorBPCond guifg=#ffff00 guibg=NONE
highlight vimspectorPC guibg=#005f87 guifg=#ffffff
```

### Line Highlighting

To highlight the entire line with a breakpoint:

```vim
sign define vimspectorBP text=● texthl=WarningMsg linehl=DiffAdd
sign define vimspectorPC text=▶ texthl=MatchParen linehl=CursorLine
```

## Panel Layout Customization

### Current Default Layout

```
┌─────────────────────────────────────┐
│ Variables | Watches | Stack         │  <- Top row
├─────────────────────────────────────┤
│                                     │
│         Your Code Here              │  <- Middle (main window)
│                                     │
├─────────────────────────────────────┤
│ Output | Console                    │  <- Bottom
└─────────────────────────────────────┘
```

### Option 1: Compact Layout (Variables on Right)

Edit `~/.vim/core/vimspector.vim` (around line 51) and replace:

```vim
let g:vimspector_ui_config = {}
```

With:

```vim
let g:vimspector_ui_config = {
  \   'Variables': { 'pos': 'right', 'width': 50 },
  \   'Watches': { 'pos': 'right', 'width': 50 },
  \   'Stack': { 'pos': 'right', 'width': 50 },
  \   'Output': { 'pos': 'bottom', 'height': 10 },
  \   'Console': { 'pos': 'bottom', 'height': 10 }
  \ }
```

Result:
```
┌────────────────────┬──────────┐
│                    │Variables │
│                    ├──────────┤
│   Your Code        │ Watches  │
│                    ├──────────┤
│                    │  Stack   │
├────────────────────┴──────────┤
│ Output | Console               │
└───────────────────────────────┘
```

### Option 2: IDE-Style Layout (Variables Left)

```vim
let g:vimspector_ui_config = {
  \   'Variables': { 'pos': 'left', 'width': 50 },
  \   'Watches': { 'pos': 'left', 'width': 50 },
  \   'Stack': { 'pos': 'left', 'width': 50 },
  \   'Output': { 'pos': 'bottom', 'height': 10 },
  \   'Console': { 'pos': 'bottom', 'height': 10 }
  \ }
```

### Option 3: Minimal Layout (Only Essential Panels)

```vim
let g:vimspector_ui_config = {
  \   'Variables': { 'pos': 'right', 'width': 40 },
  \   'Stack': { 'pos': 'right', 'width': 40 },
  \   'Console': { 'pos': 'bottom', 'height': 10 }
  \ }
```

### Option 4: Horizontal Split (All Bottom)

```vim
let g:vimspector_ui_config = {
  \   'Variables': { 'pos': 'bottom', 'height': 10 },
  \   'Watches': { 'pos': 'bottom', 'height': 10 },
  \   'Stack': { 'pos': 'bottom', 'height': 10 },
  \   'Output': { 'pos': 'bottom', 'height': 10 },
  \   'Console': { 'pos': 'bottom', 'height': 10 }
  \ }
```

## Available Panels

| Panel | Description |
|-------|-------------|
| `Variables` | Local variables in current scope |
| `Watches` | Custom watch expressions |
| `Stack` | Call stack / stacktrace |
| `Output` | Debugger output messages |
| `Console` | Interactive debug console (REPL) |
| `Breakpoints` | List of all breakpoints |
| `Disassembly` | Assembly code view |

## Panel Position Options

- `pos`: `'left'`, `'right'`, `'top'`, `'bottom'`
- `width`: Number (for left/right panels)
- `height`: Number (for top/bottom panels)

## Auto-Close Panels When Debugging Stops

This is now enabled by default. The panels automatically close when you run `:DebugStop` or when the program exits.

To disable auto-close, comment out this section in `~/.vim/core/vimspector.vim`:

```vim
" Auto-close vimspector panels when debugging stops
" augroup VimspectorAutoClose
"   autocmd!
"   autocmd User VimspectorDebugEnded call vimspector#Reset()
" augroup END
```

## Window Size Configuration

Adjust the default panel sizes (in `~/.vim/core/vimspector.vim`):

```vim
let g:vimspector_sidebar_width = 75        " Width of side panels
let g:vimspector_bottombar_height = 15     " Height of bottom panels
```

## Testing Your Configuration

1. Edit `~/.vim/core/vimspector.vim`
2. Save the file
3. Reload Vim: `:source ~/.vim/vimrc`
4. Start debugging: `:GoDB`
5. Check the layout and signs

## Quick Experiments

Try these in Vim to see different signs immediately:

```vim
" Test different breakpoint characters
:sign define vimspectorBP text=⬤ texthl=WarningMsg
:sign define vimspectorBP text=● texthl=ErrorMsg
:sign define vimspectorBP text=◆ texthl=DiffAdd

" Test line highlighting
:sign define vimspectorBP text=● texthl=WarningMsg linehl=DiffAdd
:sign define vimspectorPC text=▶ texthl=MatchParen linehl=Visual
```

## Recommended Configurations

### For Dark Themes

```vim
sign define vimspectorBP text=● texthl=WarningMsg linehl=DiffAdd
sign define vimspectorPC text=▶ texthl=MatchParen linehl=CursorLine

highlight vimspectorBP ctermfg=Red guifg=#ff5555
highlight vimspectorPC ctermbg=Blue guibg=#44475a
```

### For Light Themes

```vim
sign define vimspectorBP text=● texthl=WarningMsg linehl=DiffAdd
sign define vimspectorPC text=▶ texthl=MatchParen linehl=CursorLine

highlight vimspectorBP ctermfg=DarkRed guifg=#cc0000
highlight vimspectorPC ctermbg=LightBlue guibg=#d0d0ff
```

## Troubleshooting

### Breakpoints Not Visible

1. Check if sign column is enabled:
   ```vim
   :set signcolumn?
   ```
   Should show `signcolumn=yes` or `signcolumn=auto`

2. Enable sign column:
   ```vim
   :set signcolumn=yes
   ```

3. Add to your `~/.vim/core/settings.vim`:
   ```vim
   set signcolumn=yes
   ```

### Panels Don't Close

If panels don't auto-close, manually close with:
```vim
:VimspectorReset
:DebugReset
```

### Layout Not Applied

Make sure you reload Vim after changing `g:vimspector_ui_config`:
```vim
:source ~/.vim/vimrc
```

Or restart Vim completely.

## More Information

- Vimspector documentation: `:help vimspector`
- Layout options: `:help vimspector-configuration`
- Sign customization: `:help sign-define`
