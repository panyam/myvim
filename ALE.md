# ALE - Asynchronous Linting and Fixing Guide

ALE (Asynchronous Lint Engine) provides real-time linting and code fixing for multiple languages. It runs linters asynchronously, so they don't block your editing.

## Table of Contents

- [What is ALE?](#what-is-ale)
- [Supported Languages](#supported-languages)
- [Configuration](#configuration)
- [Usage](#usage)
- [Customization](#customization)
- [Troubleshooting](#troubleshooting)

## What is ALE?

ALE runs linters and fixers in the background while you edit:
- **Linters**: Check your code for errors and style issues
- **Fixers**: Automatically fix formatting and style problems
- **Asynchronous**: Runs without blocking Vim
- **Language Server Protocol**: Supports LSP for advanced features

## Supported Languages

This configuration includes linters and fixers for:

| Language | Linters | Fixers |
|----------|---------|--------|
| **JavaScript** | eslint | eslint |
| **TypeScript** | tsserver, eslint | eslint |
| **React (JSX/TSX)** | eslint | eslint |
| **Python** | pylint | - |
| **Go** | gopls | - |
| **Vue** | eslint | eslint |
| **SCSS** | - | prettier |
| **HTML** | - | prettier |

## Configuration

### Current Setup

The configuration is in `~/.vim/core/ale.vim`:

```vim
" Linters configuration
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['tsserver', 'eslint'],
\   'python': ['pylint'],
\   'go': ['gopls']
\}

" Fixers configuration
let g:ale_fixers = {
\    'javascript': ['eslint'],
\    'typescript': ['eslint'],
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
```

### What This Means

- **Lint on save**: ALE checks your code when you save the file
- **Fix on save**: ALE automatically fixes issues when you save
- **Don't lint on text change**: Disabled to avoid performance issues while typing
- **Visual indicators**: Errors show as ❌, warnings as ⚠️ in the sign column

## Usage

### Basic Commands

```vim
:ALEFix                    " Manually fix the current file
:ALELint                   " Manually lint the current file
:ALEInfo                   " Show ALE configuration and status
:ALEDetail                 " Show detailed error information
:ALEToggle                 " Enable/disable ALE
```

### Navigation

```vim
:ALENext                   " Jump to next error/warning
:ALEPrevious               " Jump to previous error/warning
:ALEFirst                  " Jump to first error/warning
:ALELast                   " Jump to last error/warning
```

### Viewing Errors

Errors and warnings appear in several places:
1. **Sign column** (left gutter): ❌ for errors, ⚠️ for warnings
2. **Status line**: Shows error count
3. **Hover**: Place cursor on the line to see details
4. **Detail window**: Use `:ALEDetail` for full information

## Customization

### Add Linters for New Languages

Edit `~/.vim/core/ale.vim` and add to `g:ale_linters`:

```vim
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'python': ['pylint'],
\   'ruby': ['rubocop'],        " Add Ruby linter
\   'rust': ['cargo']           " Add Rust linter
\}
```

### Add Fixers

Edit `~/.vim/core/ale.vim` and add to `g:ale_fixers`:

```vim
let g:ale_fixers = {
\    'javascript': ['eslint'],
\    'python': ['autopep8'],     " Add Python fixer
\    'rust': ['rustfmt']         " Add Rust fixer
\}
```

### Change Error/Warning Signs

Edit `~/.vim/core/ale.vim`:

```vim
" Simple text signs (better for some terminals)
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'

" Or different emoji
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
```

### Customize Behavior

Edit `~/.vim/core/ale.vim`:

```vim
" Lint as you type (may slow down editing)
let g:ale_lint_on_text_changed = 'always'

" Don't automatically fix on save
let b:ale_fix_on_save = 0

" Don't lint on save
let g:ale_lint_on_save = 0

" Lint when entering a file
let g:ale_lint_on_enter = 1

" Show errors in location list
let g:ale_open_list = 1

" Keep location list open
let g:ale_keep_list_window_open = 1
```

### Ignore Specific Linters

To disable specific linters for certain file types:

```vim
let g:ale_linters_ignore = {
\   'typescript': ['tslint'],
\   'python': ['flake8']
\}
```

### Project-Specific Configuration

You can disable ALE for specific projects by adding to your project's `.vimrc`:

```vim
" Disable ALE for this project
let g:ale_enabled = 0
```

Or configure different linters:

```vim
" Use different Python linters for this project
let g:ale_linters = {'python': ['flake8', 'mypy']}
```

## Installing Linters and Fixers

ALE doesn't include the actual linters/fixers - you need to install them separately.

### JavaScript/TypeScript

```bash
# Install ESLint
npm install -g eslint

# Install Prettier
npm install -g prettier

# Project-specific (recommended)
npm install --save-dev eslint prettier
```

### Python

```bash
# Install pylint
pip install pylint

# Install autopep8 (for fixing)
pip install autopep8

# Install flake8 (alternative linter)
pip install flake8
```

### Go

```bash
# Install gopls (Go language server)
go install golang.org/x/tools/gopls@latest

# Install golint
go install golang.org/x/lint/golint@latest
```

### Check What's Installed

```vim
:ALEInfo
```

This shows:
- Which linters are enabled
- Which linters are available (installed on your system)
- Current file's linter status
- Any errors in configuration

## Troubleshooting

### ALE Not Working

1. Check if ALE is enabled:
   ```vim
   :ALEInfo
   ```

2. Enable ALE if disabled:
   ```vim
   :ALEEnable
   ```

3. Check if linters are installed:
   ```vim
   :ALEInfo
   ```
   Look for "Available Linters" section

### Linter Not Found

If `:ALEInfo` shows "executable not found":

1. Install the linter (see [Installing Linters](#installing-linters-and-fixers))
2. Make sure it's in your PATH:
   ```bash
   which eslint    # Should show path to eslint
   which pylint    # Should show path to pylint
   ```

3. For project-local tools (like `node_modules/.bin/eslint`), ALE should find them automatically

### Errors Not Showing

1. Check sign column is enabled:
   ```vim
   :set signcolumn?
   ```

2. Enable sign column:
   ```vim
   :set signcolumn=yes
   ```

3. Check ALE signs are defined:
   ```vim
   :echo g:ale_sign_error
   :echo g:ale_sign_warning
   ```

### Too Many False Positives

1. Configure your linter with a config file:
   - ESLint: Create `.eslintrc.js` in project root
   - Pylint: Create `.pylintrc` in project root
   - Prettier: Create `.prettierrc` in project root

2. Disable specific rules in ALE:
   ```vim
   let g:ale_python_pylint_options = '--disable=C0111'
   let g:ale_javascript_eslint_options = '--rule "no-console: 0"'
   ```

### Performance Issues

If ALE is slowing down your editing:

1. Disable lint on text change (already done in this config):
   ```vim
   let g:ale_lint_on_text_changed = 0
   ```

2. Increase the delay:
   ```vim
   let g:ale_lint_delay = 1000  " Wait 1 second before linting
   ```

3. Disable automatic fixing:
   ```vim
   let b:ale_fix_on_save = 0
   ```

## Advanced Configuration

### Multiple Fixers

You can chain multiple fixers:

```vim
let g:ale_fixers = {
\    'javascript': ['prettier', 'eslint'],  " Run prettier, then eslint
\    'python': ['black', 'isort']           " Run black, then isort
\}
```

### Language Server Protocol (LSP)

Some linters (like `gopls`, `tsserver`) are LSP servers that provide:
- Advanced linting
- Auto-completion
- Go to definition
- Find references
- Rename refactoring

These are automatically used when configured in `g:ale_linters`.

### Custom Error Format

Highlight errors differently:

```vim
highlight ALEError ctermbg=DarkRed ctermfg=White
highlight ALEWarning ctermbg=DarkYellow ctermfg=Black
```

### Status Line Integration

Show ALE status in your status line (if you have a custom statusline):

```vim
set statusline+=%{ALEGetStatusLine()}
```

## Common Linters and Fixers

### JavaScript/TypeScript Ecosystem

**Linters:**
- `eslint` - Configurable JavaScript linter (most popular)
- `tsserver` - TypeScript language server
- `jshint` - Alternative JavaScript linter
- `standard` - JavaScript Standard Style

**Fixers:**
- `eslint` - Can auto-fix many issues
- `prettier` - Opinionated code formatter
- `standard` - Auto-fixes to Standard Style

### Python Ecosystem

**Linters:**
- `pylint` - Comprehensive Python linter
- `flake8` - Fast and simple linter
- `mypy` - Static type checker
- `pycodestyle` - PEP 8 style checker

**Fixers:**
- `autopep8` - Auto-format to PEP 8
- `black` - Opinionated Python formatter
- `isort` - Sort import statements

### Go Ecosystem

**Linters:**
- `gopls` - Official Go language server (recommended)
- `golint` - Go linter
- `go vet` - Go's built-in vet tool
- `staticcheck` - Advanced Go linter

**Fixers:**
- `gofmt` - Official Go formatter
- `goimports` - Formats and manages imports

## Quick Reference

```vim
COMMANDS
  :ALEFix                  Auto-fix current file
  :ALELint                 Lint current file
  :ALEInfo                 Show ALE info and diagnostics
  :ALEDetail               Show detailed error info
  :ALEToggle               Toggle ALE on/off

NAVIGATION
  :ALENext                 Next error/warning
  :ALEPrevious             Previous error/warning
  :ALEFirst                First error/warning
  :ALELast                 Last error/warning

CONFIGURATION
  Edit ~/.vim/core/ale.vim to customize linters and fixers
```

## Further Reading

- ALE GitHub: https://github.com/dense-analysis/ale
- `:help ale`
- `:help ale-linters`
- `:help ale-fixers`
- [PLUGINS.md](PLUGINS.md) - All plugins and configuration

---

**Last Updated:** 2025-10-25
