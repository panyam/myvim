# Plugins Guide

This guide covers all plugins included in this Vim configuration, their purpose, and how to use them.

## Table of Contents

- [Plugin Overview](#plugin-overview)
- [Core Development Plugins](#core-development-plugins)
- [Language-Specific Plugins](#language-specific-plugins)
- [Productivity Plugins](#productivity-plugins)
- [Adding and Removing Plugins](#adding-and-removing-plugins)
- [Plugin Tips and Tricks](#plugin-tips-and-tricks)

## Plugin Overview

This configuration uses **vim-plug** as the plugin manager. All plugins are declared in `~/.vim/core/plugins.vim`.

### Installed Plugins

| Plugin | Category | Purpose |
|--------|----------|---------|
| vim-plug | Management | Plugin manager |
| vimspector | Debugging | Visual debugger for multiple languages |
| ALE | Linting | Asynchronous linting and fixing |
| coc.nvim | Completion | IntelliSense code completion |
| vim-go | Language | Go development |
| rust.vim | Language | Rust development |
| vim-javascript | Language | JavaScript syntax and indentation |
| jsdoc.vim | Language | JSDoc documentation generation |
| vim-fireplace | Language | Clojure REPL integration |
| NERDTree | Navigation | File system explorer |
| fzf | Navigation | Fuzzy file finder |
| spelunker.vim | Writing | Advanced spell checker |
| vimwiki | Writing | Personal wiki and note-taking |
| vim-easy-align | Formatting | Text alignment plugin |
| vim-autoformat | Formatting | Auto-formatting code |
| vim-github-dashboard | Integration | GitHub integration |
| gocode | Completion | Go completion (legacy) |
| YCM-Generator | Completion | Generate YouCompleteMe configs |
| nvim-yarp/vim-hug-neovim-rpc | Compatibility | Neovim RPC for Vim |

## Core Development Plugins

### Vimspector - Visual Debugging

**What it does:** Provides a complete visual debugging experience with breakpoints, stepping, variable inspection, and more.

**See:** [VIMSPECTOR.md](VIMSPECTOR.md) for complete guide

**Quick start:**
```vim
:VimspectorConfig          " Create debug config
:GoDB arg1 arg2            " Debug Go program
<F9>                       " Toggle breakpoint
<F5>                       " Start/continue
<F10>                      " Step over
```

### ALE (Asynchronous Lint Engine)

**What it does:** Real-time linting and code fixing without blocking Vim.

**See:** [ALE.md](ALE.md) for complete guide

**Quick start:**
```vim
:ALEFix                    " Fix current file
:ALEInfo                   " Show linter info
:ALENext                   " Jump to next error
```

**Supported languages:** JavaScript, TypeScript, Python, Go, Vue, and more.

### coc.nvim - IntelliSense Completion

**What it does:** Provides VSCode-like intelligent code completion using Language Server Protocol (LSP).

**Features:**
- Smart auto-completion
- Go to definition
- Find references
- Hover documentation
- Rename refactoring
- Code actions

**Quick start:**
```vim
" Auto-completion appears as you type
<Tab>                      " Navigate completions
<CR>                       " Accept completion
gd                         " Go to definition
gr                         " Find references
K                          " Show documentation
```

**Configuration:**
```vim
:CocConfig                 " Edit coc configuration
:CocInstall coc-go         " Install Go language server
:CocInstall coc-tsserver   " Install TypeScript server
:CocInstall coc-python     " Install Python server
```

**Popular coc extensions:**
- `coc-go` - Go support
- `coc-tsserver` - TypeScript/JavaScript
- `coc-python` - Python support
- `coc-json` - JSON support
- `coc-yaml` - YAML support
- `coc-rust-analyzer` - Rust support

## Language-Specific Plugins

### vim-go - Go Development

**What it does:** Complete Go development environment in Vim.

**Features:**
- Syntax highlighting
- Auto-import management
- Code formatting (gofmt)
- Build and test integration
- Documentation lookup
- Struct tags
- Rename refactoring

**Commands:**
```vim
:GoBuild                   " Build Go program
:GoRun                     " Run Go program
:GoTest                    " Run tests
:GoCoverage                " Show test coverage
:GoDoc                     " Show documentation
:GoRename                  " Rename identifier
:GoImplements              " Show implementations
:GoCallees                 " Show function callees
```

**Key mappings:** (set in `lang/go.vim`)
```vim
:GoDB [args]               " Custom: Debug with vimspector
:GoDebugFile               " Custom: Debug current file
```

### rust.vim - Rust Development

**What it does:** Rust language support for Vim.

**Features:**
- Syntax highlighting
- Automatic formatting with rustfmt
- Integration with Cargo
- Playpen integration

**Commands:**
```vim
:RustFmt                   " Format with rustfmt
:RustRun                   " Compile and run
:RustTest                  " Run tests
:Cargo build               " Build with Cargo
:Cargo test                " Test with Cargo
```

**Configuration:**
```vim
let g:rustfmt_autosave = 1 " Auto-format on save
```

### vim-javascript - JavaScript Support

**What it does:** Enhanced JavaScript syntax highlighting and indentation.

**Features:**
- ES6+ syntax support
- JSX support
- Improved indentation
- Concealment of syntax

**Auto-loaded:** Automatically works when you open `.js` files.

### jsdoc.vim - JSDoc Generation

**What it does:** Generates JSDoc comments for JavaScript functions.

**Usage:**
```vim
" Position cursor on function definition
:JsDoc                     " Generate JSDoc comment
```

Example:
```javascript
// Before:
function add(a, b) {
  return a + b;
}

// After :JsDoc:
/**
 * add
 * @param {type} a
 * @param {type} b
 * @returns {type}
 */
function add(a, b) {
  return a + b;
}
```

### vim-fireplace - Clojure Support

**What it does:** Clojure REPL integration and development tools.

**Features:**
- Connect to running REPL
- Evaluate expressions
- Go to definition
- Documentation lookup
- Code completion

**Commands:**
```vim
:Eval                      " Evaluate current expression
:Require                   " Require namespace
:Doc symbol                " Show documentation
```

## Productivity Plugins

### NERDTree - File Explorer

**What it does:** Tree-style file system explorer.

**Usage:**
```vim
:NERDTreeToggle            " Toggle file tree
:NERDTreeFind              " Find current file in tree
```

**Navigation in NERDTree:**
- `o` - Open file/directory
- `t` - Open in new tab
- `i` - Open in horizontal split
- `s` - Open in vertical split
- `p` - Go to parent directory
- `P` - Go to root
- `m` - Show menu (add, move, delete files)
- `?` - Show help

**Configuration:**
```vim
" Auto-open NERDTree on Vim start
autocmd VimEnter * NERDTree

" Close Vim if NERDTree is the only window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
```

### fzf - Fuzzy Finder

**What it does:** Blazingly fast fuzzy file finder.

**Usage:**
```vim
:FZF                       " Fuzzy find files
:FZF ~                     " Search from home directory
```

**In fzf window:**
- Type to filter files
- `Ctrl-j/k` - Navigate up/down
- `Enter` - Open file
- `Ctrl-t` - Open in tab
- `Ctrl-x` - Open in split
- `Ctrl-v` - Open in vertical split

**Advanced usage:**
```vim
:Files                     " Fuzzy find files (if configured)
:Buffers                   " Fuzzy find open buffers
:Lines                     " Fuzzy find lines in open buffers
```

**Tip:** Map to a key for quick access:
```vim
nnoremap <C-p> :FZF<CR>
```

### spelunker.vim - Advanced Spell Checker

**What it does:** Context-aware spell checking for code and text.

**Features:**
- Camel case support (e.g., `myVariableName`)
- Ignores certain patterns in code
- Only checks comments and strings in code
- Custom word lists

**Commands:**
```vim
:SpelunkerCheck            " Check spelling
:SpelunkerCorrect          " Correct word under cursor
```

**Configuration:** See `~/.vim/core/spelunker.vim`

### vimwiki - Personal Wiki

**What it does:** Personal wiki and note-taking system in Vim.

**Features:**
- Markdown or Wiki syntax
- Internal linking
- Todo lists
- Diary entries
- Tables
- Export to HTML

**Usage:**
```vim
:VimwikiIndex              " Open wiki index
<Leader>ww                 " Open default wiki
<Leader>wt                 " Open wiki in new tab
```

**In wiki files:**
- `<Enter>` - Follow/create link
- `<Backspace>` - Go back
- `<Tab>` - Go to next link
- `<Shift-Tab>` - Go to previous link
- `=` - Add header level
- `-` - Remove header level

**Create links:**
```
[[Link to page]]           " Wiki link
[Description](url)         " Markdown link
```

### vim-easy-align - Text Alignment

**What it does:** Align text and code by delimiters.

**Usage:**
```vim
" Visual mode: select lines, then
:EasyAlign                 " Interactive mode

" Or use shortcuts
vip<Enter>=                " Align by = sign
vip<Enter>:                " Align by : colon
```

**Example:**
```javascript
// Before:
let name = "John"
let age = 30
let city = "New York"

// Select lines, then vip<Enter>=
// After:
let name = "John"
let age  = 30
let city = "New York"
```

**Common delimiters:**
- `=` - Assignment operators
- `:` - Colons (JSON, CSS)
- `|` - Tables
- `,` - Comma-separated values
- `<Space>` - Whitespace

### vim-autoformat - Auto-formatting

**What it does:** Automatically format code using external formatters.

**Supported formatters:**
- **JavaScript/TypeScript:** prettier, eslint
- **Python:** autopep8, yapf, black
- **Go:** gofmt, goimports
- **Rust:** rustfmt
- **HTML/CSS:** prettier
- **JSON:** jq, prettier

**Usage:**
```vim
:Autoformat                " Format current file
```

**Auto-format on save:**
```vim
" Add to ~/.vim/vimrc or ftplugin
au BufWrite * :Autoformat
```

**Note:** You need to install formatters separately (e.g., `npm install -g prettier`).

### vim-github-dashboard - GitHub Integration

**What it does:** Browse GitHub from Vim.

**Usage:**
```vim
:GHDashboard               " Open your GitHub dashboard
:GHDashboard user          " Open specific user's dashboard
:GHActivity                " Show GitHub activity
```

**Features:**
- View issues and pull requests
- Browse repositories
- View activity feed

## Adding and Removing Plugins

### Adding a New Plugin

1. **Find the plugin** on GitHub or vim.org

2. **Edit** `~/.vim/core/plugins.vim`

3. **Add the plugin** between `call plug#begin()` and `call plug#end()`:
   ```vim
   Plug 'author/plugin-name'
   ```

4. **Install** the plugin:
   ```vim
   :source ~/.vim/vimrc
   :PlugInstall
   ```

**Examples:**
```vim
" Basic plugin
Plug 'tpope/vim-surround'

" Plugin with specific branch/tag
Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin for specific filetype
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Lazy-loaded plugin (loads on command)
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Plugin with build step
Plug 'junegunn/fzf', { 'do': './install --all' }
```

### Removing a Plugin

1. **Edit** `~/.vim/core/plugins.vim`

2. **Comment out or delete** the Plug line:
   ```vim
   " Plug 'author/plugin-name'
   ```

3. **Clean up** the plugin:
   ```vim
   :source ~/.vim/vimrc
   :PlugClean
   ```

### Updating Plugins

**Update all plugins:**
```vim
:PlugUpdate
```

**Update specific plugin:**
```vim
:PlugUpdate plugin-name
```

**Check status:**
```vim
:PlugStatus
```

## Adding New Languages

Want to add support for a new language? Here's a complete guide:

### 1. Create Language Configuration

Create `~/.vim/lang/ruby.vim`:
```vim
" Ruby-specific commands and settings
command! RubyRun !ruby %
command! RubyTest !ruby -I test %

" Ruby-specific mappings
nnoremap <buffer> <Leader>r :RubyRun<CR>
```

### 2. Create Filetype Plugin

Create `~/.vim/ftplugin/ruby.vim`:
```vim
" Load Ruby language configuration
if filereadable(expand('~/.vim/lang/ruby.vim'))
  source ~/.vim/lang/ruby.vim
endif

" Ruby-specific settings
setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab
setlocal textwidth=80
```

### 3. Add Plugins (Optional)

Edit `~/.vim/core/plugins.vim`:
```vim
" Ruby plugins
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
```

### 4. Configure ALE (Optional)

Edit `~/.vim/core/ale.vim`:
```vim
let g:ale_linters = {
\   'ruby': ['rubocop', 'ruby']
\}

let g:ale_fixers = {
\   'ruby': ['rubocop']
\}
```

### 5. Add to Profile System (Optional)

Edit `~/.vim/core/profiles.vim`:
```vim
elseif a:profile ==# 'ruby'
  call LoadLanguageConfig('ruby')
```

## Plugin Tips and Tricks

### Performance Tips

1. **Lazy load plugins** when possible:
   ```vim
   Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
   Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
   ```

2. **Disable unused features:**
   ```vim
   let g:loaded_netrw = 1        " Disable netrw if using NERDTree
   let g:loaded_netrwPlugin = 1
   ```

3. **Profile startup time:**
   ```bash
   vim --startuptime timings.log
   ```

### Common Plugin Conflicts

**coc.nvim vs ALE:**
- Both provide completion and linting
- Solution: Use coc for completion, ALE for linting
- Or disable ALE linting: `let g:ale_linting_on = 0`

**Multiple completion plugins:**
- Choose one: coc.nvim, YouCompleteMe, or deoplete
- Don't install multiple completion engines

### Checking Plugin Health

```vim
:scriptnames               " See all loaded scripts
:PlugStatus                " Check plugin status
:checkhealth               " Neovim only - comprehensive health check
```

### Plugin Documentation

Most plugins include help documentation:
```vim
:help plugin-name
:help vimspector
:help ale
:help coc-nvim
```

## Recommended Additional Plugins

Here are some popular plugins you might want to add:

### Code Editing
- **vim-surround** - Easily change surrounding quotes, parentheses, etc.
- **vim-commentary** - Comment/uncomment code easily
- **vim-repeat** - Repeat plugin actions with `.`
- **auto-pairs** - Auto-close brackets and quotes

### Navigation
- **vim-airline** - Enhanced status line
- **tagbar** - Display tags in a sidebar
- **ctrlp.vim** - Alternative to fzf

### Git Integration
- **vim-fugitive** - Git wrapper for Vim
- **vim-gitgutter** - Show git diff in sign column

### Themes
- **gruvbox** - Retro groove color scheme
- **onedark.vim** - Atom's One Dark theme
- **dracula** - Dark theme

## Quick Reference

```vim
PLUGIN MANAGEMENT
  :PlugInstall             Install plugins
  :PlugUpdate              Update all plugins
  :PlugClean               Remove unused plugins
  :PlugStatus              Check plugin status
  :PlugUpgrade             Upgrade vim-plug itself

DEBUGGING (Vimspector)
  See VIMSPECTOR.md

LINTING (ALE)
  See ALE.md

FILE NAVIGATION
  :NERDTreeToggle          Toggle file tree
  :FZF                     Fuzzy file finder

CODE COMPLETION (coc.nvim)
  <Tab>                    Navigate completions
  gd                       Go to definition
  gr                       Find references
  K                        Show documentation
```

## Further Reading

- [VIMSPECTOR.md](VIMSPECTOR.md) - Debugging guide
- [ALE.md](ALE.md) - Linting guide
- [CUSTOMIZATION.md](CUSTOMIZATION.md) - UI customization
- vim-plug: https://github.com/junegunn/vim-plug
- Awesome Vim Plugins: https://github.com/vim-awesome/vim-awesome

---

**Last Updated:** 2025-10-25
