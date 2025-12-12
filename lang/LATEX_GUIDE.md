# LaTeX Setup Guide

This guide covers the prerequisites and setup for LaTeX editing in Vim using VimTeX.

## Prerequisites

### 1. Install LaTeX Distribution

You need a full LaTeX distribution. On macOS, install MacTeX (recommended) or BasicTeX:

```bash
# Full MacTeX (~4GB) - recommended for most users
brew install --cask mactex

# OR BasicTeX (~100MB) - minimal install, may need additional packages
brew install --cask basictex
```

After installing MacTeX/BasicTeX, add it to your PATH:

```bash
# Add to your ~/.zshrc or ~/.bashrc
export PATH="/Library/TeX/texbin:$PATH"
```

Restart your terminal or run `source ~/.zshrc`.

### 2. Install PDF Viewer (Skim)

Skim is configured as the PDF viewer with SyncTeX support for forward/inverse search:

```bash
brew install --cask skim
```

#### Configure Skim for Inverse Search

1. Open Skim
2. Go to **Skim > Preferences > Sync**
3. Set **PDF-TeX Sync support** preset to **Custom**
4. Set **Command** to: `nvim` (or `vim` or `mvim` depending on your setup)
5. Set **Arguments** to: `--headless -c "VimtexInverseSearch %line '%file'"`

This allows Cmd+Shift+Click in Skim to jump to the corresponding line in Vim.

### 3. Install LaTeX Linters

For ALE linting support:

```bash
# chktex - LaTeX semantic checker
brew install chktex

# lacheck is typically included with MacTeX
# Verify with: which lacheck
```

### 4. Install the Vim Plugin

In Vim, run:

```vim
:source ~/.vim/vimrc
:PlugInstall
```

## Verification

Test your setup:

```bash
# Verify LaTeX is installed
pdflatex --version
latexmk --version

# Verify linters
chktex --version
lacheck
```

## Usage

### Key Mappings (VimTeX defaults)

| Key | Action |
|-----|--------|
| `\ll` | Start/stop continuous compilation |
| `\lv` | View PDF in Skim |
| `\lc` | Clean auxiliary files |
| `\lC` | Clean all output files |
| `\lt` | Toggle table of contents |
| `\le` | View errors in quickfix |
| `\lk` | Stop compilation |
| `\lg` | Show compilation status |
| `\lm` | Show insert mode mappings |

### Custom Commands

These buffer-local commands are available in `.tex` files:

| Command | Action |
|---------|--------|
| `:TexCompile` | Start compilation |
| `:TexView` | Open PDF viewer |
| `:TexClean` | Clean auxiliary files |
| `:TexToc` | Toggle table of contents |
| `:TexErrors` | Show errors |

### Forward Search (Vim to PDF)

Press `\lv` to jump from your cursor position in Vim to the corresponding location in the PDF.

### Inverse Search (PDF to Vim)

In Skim, Cmd+Shift+Click on text to jump to the corresponding line in Vim.

## Troubleshooting

### "latexmk not found"

Ensure MacTeX bin is in your PATH:

```bash
export PATH="/Library/TeX/texbin:$PATH"
```

### Skim doesn't open

Verify the view method is set correctly in `~/.vim/lang/tex.vim`:

```vim
let g:vimtex_view_method = 'skim'
```

### Compilation errors not showing

Check quickfix window with `\le` or `:copen`.

### Missing LaTeX packages

With BasicTeX, install missing packages via tlmgr:

```bash
sudo tlmgr update --self
sudo tlmgr install <package-name>
```

## Configuration Files

| File | Purpose |
|------|---------|
| `core/plugins.vim` | VimTeX plugin declaration |
| `core/ale.vim` | LaTeX linter configuration |
| `ftplugin/tex.vim` | Auto-loaded settings for .tex files |
| `lang/tex.vim` | VimTeX configuration and commands |
