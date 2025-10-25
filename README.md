# Portable Vim Configuration

A modular, portable Vim configuration system designed for software development. This setup keeps your Vim configuration organized, version-controlled, and easily transferable across machines.

## Key Features

- **Fully Portable**: Clone to `~/.vim/` and you're ready to go
- **Modular Design**: Organized configuration files by purpose
- **Language Support**: Pre-configured for Go, Python, JavaScript, Rust
- **Debugging Built-in**: Vimspector integration for visual debugging
- **Profile System**: Switch between language environments
- **Project-Specific Settings**: Support for per-project `.vimrc` files

## Quick Start

### Fresh Installation

```bash
# Clone directly to ~/.vim
cd ~
git clone https://github.com/panyam/myvim .vim

# Install vim-plug (if not already installed)
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Open Vim and install plugins
vim +PlugInstall +qall
```

### Updating Your Configuration

```bash
cd ~/.vim
git pull
vim +PlugUpdate +qall
```

### Backup Existing Configuration

```bash
# Backup existing config
mv ~/.vim ~/.vim.backup.$(date +%Y%m%d)
mv ~/.vimrc ~/.vimrc.backup.$(date +%Y%m%d) 2>/dev/null || true
```

## Directory Structure

```
~/.vim/
├── vimrc                     # Main configuration (loads everything)
├── README.md                 # This file
├── core/                     # Core configuration files
│   ├── plugins.vim          # Plugin declarations (vim-plug)
│   ├── settings.vim         # General Vim settings
│   ├── mappings.vim         # Key mappings
│   ├── ale.vim              # ALE (linter) configuration
│   ├── spelunker.vim        # Spell checker configuration
│   ├── vimspector.vim       # Debugging configuration
│   └── profiles.vim         # Profile/workspace management
├── lang/                     # Language-specific configurations
│   ├── go.vim
│   ├── javascript.vim
│   ├── python.vim
│   └── rust.vim
├── ftplugin/                # Auto-loaded by filetype
│   ├── go.vim
│   ├── javascript.vim
│   ├── python.vim
│   └── rust.vim
└── sessions/                # Vim session files (optional)
```

**Note:** Vim automatically looks for `~/.vim/vimrc` (no dot prefix) if `~/.vimrc` doesn't exist.
This keeps everything self-contained in the `~/.vim/` directory.

## Configuration Files Explained

### Core Files

| File | Purpose |
|------|---------|
| `core/plugins.vim` | All plugin declarations using vim-plug |
| `core/settings.vim` | General Vim settings (line numbers, tabs, etc.) |
| `core/mappings.vim` | Global key mappings and shortcuts |
| `core/ale.vim` | Linter and fixer configurations |
| `core/vimspector.vim` | Debugging setup and key mappings |
| `core/profiles.vim` | Profile switching and auto-detection |

### Language Files

| File | Purpose |
|------|---------|
| `lang/<language>.vim` | Language-specific commands and functions |
| `ftplugin/<language>.vim` | Auto-loaded settings when opening files of that type |

## Plugin Documentation

This configuration includes several powerful plugins. See detailed guides for each:

- **[VIMSPECTOR.md](VIMSPECTOR.md)** - Visual debugging for Go, Python, and more
- **[ALE.md](ALE.md)** - Asynchronous linting and code fixing
- **[PLUGINS.md](PLUGINS.md)** - Complete plugin list with tips and tricks
- **[CUSTOMIZATION.md](CUSTOMIZATION.md)** - UI customization and layout options

## Language Profiles

### Switching Profiles Manually

```vim
:Profile go           " Load Go profile
:Profile javascript   " Load JavaScript profile
:Profile python       " Load Python profile
:Profile rust         " Load Rust profile
```

### Auto-Detection

The system can auto-detect your project type based on files:
- `go.mod` or `main.go` → Go profile
- `package.json` → JavaScript profile
- `requirements.txt` → Python profile
- `Cargo.toml` → Rust profile

**Note:** Auto-detection is commented out by default in `core/profiles.vim`.

## Common Tasks

### Install New Plugin

1. Edit `~/.vim/core/plugins.vim`
2. Add: `Plug 'author/plugin-name'`
3. In Vim: `:source ~/.vimrc` then `:PlugInstall`

### Change Key Mapping

1. Edit `~/.vim/core/mappings.vim` (global) or
2. Edit `~/.vim/lang/go.vim` (language-specific)
3. In Vim: `:source ~/.vimrc`

### Disable a Plugin

1. Edit `~/.vim/core/plugins.vim`
2. Comment out the line: `" Plug 'author/plugin-name'`
3. In Vim: `:source ~/.vimrc` then `:PlugClean`

### Add New Language Support

See [PLUGINS.md](PLUGINS.md#adding-new-languages) for a complete guide.

## Project-Specific Configuration

### Local .vimrc Files

You can have project-specific settings:

1. In your project root, create `.vimrc`:
   ```vim
   " Project-specific settings
   set textwidth=100
   let g:project_name = "myproject"
   ```

2. When you open Vim in that directory, it auto-loads.

**Security:** Only safe commands are allowed (`:set secure` is enabled).

### Example Project Setup

```
~/myproject/
├── .vimrc                    # Project-specific settings
├── .vimspector.json         # Debugging configuration
├── main.go
└── go.mod
```

## Viewing Error Messages

If you see an error flash by too quickly to read:

```vim
:messages         " View all recent messages and errors
,m                " Quick shortcut to view messages
```

## Customization

### Adding Your Own Settings

Edit `~/.vim/vimrc` and add customizations at the bottom:

```vim
" Custom Project Settings (at the end of ~/.vim/vimrc)
" ============================================================================

" Your custom mappings
nnoremap <leader>t :terminal<CR>

" Your custom settings
set relativenumber

" Your custom commands
command! MyCommand echo "Hello!"
```

These override anything in the modular configs.

## Troubleshooting

### Plugins Not Loading

```vim
:PlugStatus           " Check plugin status
:PlugInstall          " Install missing plugins
:PlugUpdate           " Update all plugins
```

### Settings Not Applied

1. Check load order in `~/.vim/vimrc`
2. Verify file exists: `:echo filereadable(expand('~/.vim/core/settings.vim'))`
3. Reload: `:source ~/.vimrc`

### Language Config Not Loading

1. Check filetype is detected: `:set filetype?`
2. Enable filetype: `:filetype plugin indent on`
3. Check if file exists: `:echo filereadable(expand('~/.vim/ftplugin/go.vim'))`

### Debug Configuration Issues

```vim
:scriptnames          " See all loaded scripts
:verbose set tabstop? " See where setting was last set
:messages             " View recent messages
```

## Updating and Maintenance

### Update Vim Configuration

Pull latest changes from the repository:

```bash
cd ~/.vim
git pull
vim +PlugUpdate +qall
```

### Update Plugins

```bash
vim +PlugUpdate +qall
```

Or interactively in Vim:
```vim
:PlugUpdate
```

**When to update:** Monthly, or when you need a specific bug fix or feature from a plugin.

### Check Plugin Health

```vim
:PlugStatus           " View status of all plugins
:PlugClean            " Clean up unused plugins
```

### Maintenance Schedule

**Monthly:**
- Update plugins: `:PlugUpdate`
- Check for vim config updates: `cd ~/.vim && git pull`

**Quarterly:**
- Update debug adapters (see [VIMSPECTOR.md](VIMSPECTOR.md))
- Review and update language-specific configs

**As Needed:**
- After adding new plugins: Run `:PlugInstall`
- When debugging fails: See [VIMSPECTOR.md](VIMSPECTOR.md#troubleshooting)

## Getting Help

```vim
:help myvim                   " This configuration's help
:help myvim-go-debugging      " Go debugging help
:help vimspector              " Vimspector help
:help ale                     " ALE help
:help ftplugin                " Filetype plugin help
:help vim-plug                " Vim-Plug help
```

## Further Reading

- **[VIMSPECTOR.md](VIMSPECTOR.md)** - Complete debugging guide
- **[ALE.md](ALE.md)** - Linting and fixing guide
- **[PLUGINS.md](PLUGINS.md)** - All plugins and their usage
- **[CUSTOMIZATION.md](CUSTOMIZATION.md)** - UI and layout customization

## Quick Reference

```
PROFILES
  :Profile go              Switch to Go profile
  :ProfileShow             Show current profile

DEBUGGING
  See VIMSPECTOR.md for complete debugging guide

PLUGIN MANAGEMENT
  :PlugInstall             Install plugins
  :PlugUpdate              Update all plugins
  :PlugClean               Remove unused plugins
  :PlugStatus              Check plugin status

MESSAGES
  :messages                View all messages and errors
  ,m                       Quick shortcut to view messages
```

---

**Last Updated:** 2025-10-25
**Configuration Version:** 1.0
