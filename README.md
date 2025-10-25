# Vim Configuration Guide

This is a modular Vim configuration system that keeps your setup organized, maintainable, and easy to extend.

##  Installation

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

# Install vimspector Go adapter for debugging
cd ~/.vim/plugged/vimspector
./install_gadget.py --enable-go
```

### Updating Your Configuration

```bash
cd ~/.vim
git pull
vim +PlugUpdate +qall
```

### Backup Existing Configuration

If you already have a `~/.vim` directory or `~/.vimrc`:

```bash
# Backup existing config
mv ~/.vim ~/.vim.backup.$(date +%Y%m%d)
mv ~/.vimrc ~/.vimrc.backup.$(date +%Y%m%d) 2>/dev/null || true

# Then proceed with installation above
```

##  Directory Structure

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

~/.vimrc.backup              # Backup of your original .vimrc
```

**Note:** Vim automatically looks for `~/.vim/vimrc` (no dot prefix) if `~/.vimrc` doesn't exist.
This keeps everything self-contained in the `~/.vim/` directory.

**Git Repository:** This configuration is designed to be a standalone Git repository that clones directly to `~/.vim/`.

##  Quick Start

After installation (see above), verify everything works:

1. **Verify installation**:
   ```bash
   vim
   ```

   In Vim:
   ```vim
   :scriptnames    " Should show all config files
   :PlugStatus     " Check plugins are installed
   :checkhealth    " (Neovim only)
   ```

2. **Test Go debugging** (see full example below)

### Basic Usage

Everything should work automatically! When you open a file, Vim will:
- Load the appropriate language configuration
- Apply filetype-specific settings
- Enable language-specific commands

##  Go Debugging with Vimspector

### Quick Start

1. **In your Go project root**, create a `.vimspector.json` (or use the helper):
   ```vim
   :VimspectorConfig
   ```
   This creates a default configuration file.

2. **Start debugging**:
   ```vim
   :GoDB arg1 arg2           " Debug main.go with arguments
   :GoDebugFile              " Debug current file
   ```

### Debugging Key Mappings

| Key | Action |
|-----|--------|
| `F5` | Continue/Start debugging |
| `F3` | Stop debugging |
| `F4` | Restart debugging |
| `F6` | Pause |
| `F9` | Toggle breakpoint |
| `Leader+F9` | Conditional breakpoint |
| `F8` | Function breakpoint |
| `F10` | Step over |
| `F11` | Step into |
| `F12` | Step out |
| `Leader+di` | Inspect variable under cursor |

### Example Usage

```vim
" Open your Go project
:cd ~/myproject

" Set a breakpoint on line 42
:42     " Go to line 42
<F9>    " Toggle breakpoint

" Start debugging with arguments
:GoDB --config=dev --port=8080

" When stopped at breakpoint:
<F11>   " Step into function
<F10>   " Step over line
<F12>   " Step out of function
```

### Custom Debugging Configurations

Edit `.vimspector.json` in your project root for custom configurations:

```json
{
  "configurations": {
    "Launch with custom args": {
      "adapter": "vscode-go",
      "configuration": {
        "request": "launch",
        "program": "${workspaceRoot}/cmd/myapp/main.go",
        "mode": "debug",
        "args": ["--config", "config.yaml"],
        "env": {
          "GO_ENV": "development"
        }
      }
    }
  }
}
```

## Viewing Error Messages

If you see an error flash by too quickly to read:

```vim
:messages         " View all recent messages and errors
,m                " Quick shortcut to view messages
```

Errors are now stored with `cmdheight=2` and larger history, making them easier to read and copy.

## Customizing Vimspector

See `~/.vim/CUSTOMIZATION.md` for detailed instructions on:
- Making breakpoints more visible
- Customizing panel layouts
- Changing sign characters and colors
- Auto-closing panels when debugging stops

Quick customization: Edit `~/.vim/core/vimspector.vim` (lines 20-52)

## 📝 Configuration Files Explained

### Core Files

#### `core/plugins.vim`
- All plugin declarations using vim-plug
- Modify this to add/remove plugins
- After changes, run `:PlugInstall` or `:PlugUpdate`

#### `core/settings.vim`
- General Vim settings (line numbers, tabs, etc.)
- Global editor behavior
- Common settings that apply everywhere

#### `core/mappings.vim`
- Global key mappings
- Custom shortcuts
- Does NOT include plugin-specific mappings

#### `core/ale.vim`
- Linter and fixer configurations
- Language-specific linter settings
- Error/warning signs

#### `core/vimspector.vim`
- Debugging key mappings
- Vimspector UI settings
- Helper commands for debugging

#### `core/profiles.vim`
- Profile switching system
- Auto-detection logic
- Workspace management

### Language Files

#### `lang/<language>.vim`
- Language-specific commands
- Custom functions for that language
- Example: `lang/go.vim` has `:GoDB` command

#### `ftplugin/<language>.vim`
- Auto-loaded when opening files of that type
- Buffer-local settings (tabs, indentation)
- Sources corresponding `lang/<language>.vim`

##  Profile/Workspace System

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
To enable it, uncomment the autocmd line.

## 🛠 Adding New Languages

### Example: Adding Ruby Support

1. **Create language config**:
   ```bash
   vim ~/.vim/lang/ruby.vim
   ```

   Add Ruby-specific settings:
   ```vim
   " Ruby-specific commands and settings
   command! RubyDebug echo "Ruby debugging setup"
   ```

2. **Create ftplugin**:
   ```bash
   vim ~/.vim/ftplugin/ruby.vim
   ```

   Add auto-load logic:
   ```vim
   " Load Ruby language configuration
   if filereadable(expand('~/.vim/lang/ruby.vim'))
     source ~/.vim/lang/ruby.vim
   endif

   " Ruby-specific settings
   setlocal tabstop=2
   setlocal shiftwidth=2
   setlocal expandtab
   ```

3. **Use it**:
   ```vim
   :Profile ruby     " Manual loading
   " Or just open a .rb file - ftplugin auto-loads it
   ```

##  Project-Specific Configuration

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

##  Customization

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

##  Common Tasks

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

### Debug Configuration Issues

```vim
:scriptnames          " See all loaded scripts
:verbose set tabstop? " See where setting was last set
:messages             " View recent messages
```

##  Troubleshooting

### Vimspector Not Working

1. Check if adapter is installed:
   ```bash
   ls ~/.vim/plugged/vimspector/gadgets/macos  # or linux
   ```

2. Install Go adapter:
   ```bash
   cd ~/.vim/plugged/vimspector
   ./install_gadget.py --enable-go
   ```

3. Verify `.vimspector.json` exists in project root:
   ```vim
   :VimspectorConfig
   ```

### Plugins Not Loading

```vim
:PlugStatus           " Check plugin status
:PlugInstall          " Install missing plugins
:PlugUpdate           " Update all plugins
```

### Settings Not Applied

1. Check load order in `~/.vim/vimrc`
2. Verify file exists: `:echo filereadable(expand('~/.vim/core/settings.vim'))`
3. Reload: `:source ~/.vim/vimrc`

### Language Config Not Loading

1. Check filetype is detected: `:set filetype?`
2. Enable filetype: `:filetype plugin indent on`
3. Check if file exists: `:echo filereadable(expand('~/.vim/ftplugin/go.vim'))`

##  Advanced Features

### Session Management

Save and restore entire Vim sessions:

```vim
:SaveSession myproject     " Save current session
:LoadSession myproject     " Load saved session
```

Sessions are stored in `~/.vim/sessions/`.

### Conditional Configuration

In any config file, you can use conditionals:

```vim
if has('nvim')
  " Neovim-specific settings
else
  " Regular Vim settings
endif

if has('mac')
  " macOS-specific settings
endif
```

##  Further Reading

### Vimspector Documentation
- GitHub: https://github.com/puremourning/vimspector
- `:help vimspector`

### Vim-Plug Documentation
- GitHub: https://github.com/junegunn/vim-plug
- `:help plug`

### Go Development in Vim
- vim-go: https://github.com/fatih/vim-go
- Delve (Go debugger): https://github.com/go-delve/delve

##  Getting Help

```vim
:help myvim                   " This configuration's help
:help myvim-go-debugging      " Go debugging help
:help GoDB                    " GoDB command help
:help vimspector              " Vimspector help
:help ale                     " ALE help
:help ftplugin                " Filetype plugin help
:help vim-plug                " Vim-Plug help
```

##  Testing Your Setup

### Quick Verification

1. **Test that Vim loads the new config**:
   ```bash
   vim --version  # Make sure you have Vim 7.4+
   vim
   ```

   In Vim:
   ```vim
   :scriptnames    " Should show all loaded config files
   ```

   Look for entries like:
   - `~/.vim/core/plugins.vim`
   - `~/.vim/core/settings.vim`
   - `~/.vim/core/vimspector.vim`

2. **Test plugin loading**:
   ```vim
   :PlugStatus     " Should show all plugins installed
   ```

3. **Test language-specific config**:
   Create a test Go file:
   ```bash
   echo 'package main' > /tmp/test.go
   vim /tmp/test.go
   ```

   In Vim:
   ```vim
   :set filetype?           " Should show: filetype=go
   :scriptnames             " Should show ftplugin/go.vim loaded
   :command GoDB            " Should show the GoDB command exists
   ```

4. **Test vimspector commands**:
   ```vim
   :command Vimspector      " Tab complete - should show Vimspector commands
   :VimspectorConfig        " Should offer to create .vimspector.json
   ```

5. **Test profile system**:
   ```vim
   :Profile go              " Should load Go profile
   :ProfileShow             " Should show: Current profile: go
   ```

### Full Integration Test

Create a simple Go program to test debugging:

```bash
# Create test directory
mkdir -p /tmp/vim-debug-test
cd /tmp/vim-debug-test

# Create a simple Go program
cat > main.go << 'EOF'
package main

import "fmt"

func main() {
    name := "World"
    greeting := fmt.Sprintf("Hello, %s!", name)
    fmt.Println(greeting)
}
EOF

# Initialize Go module
go mod init test
```

Now test debugging:

```bash
vim main.go
```

In Vim:
```vim
" 1. Create vimspector config
:VimspectorConfig

" 2. Set a breakpoint on line 7 (the greeting := line)
:7
<F9>

" 3. Start debugging
:GoDB

" 4. You should see:
"    - Vimspector windows open (variables, watches, stack)
"    - Execution paused at your breakpoint
"    - Current line highlighted

" 5. Test stepping
<F10>    " Step over - should move to next line
<F11>    " Step into - try on a function call
<F12>    " Step out

" 6. Inspect variables
" Hover over 'name' variable and press <Leader>di
" Should show the value "World"

" 7. Stop debugging
<F3>
```

### Verify File Structure

```bash
# Check all files were created
ls -la ~/.vim/

# Should see:
tree ~/.vim/
```

Expected output:
```
~/.vim/
├── vimrc
├── README.md
├── core/
│   ├── ale.vim
│   ├── mappings.vim
│   ├── plugins.vim
│   ├── profiles.vim
│   ├── settings.vim
│   ├── spelunker.vim
│   └── vimspector.vim
├── ftplugin/
│   ├── go.vim
│   ├── javascript.vim
│   ├── python.vim
│   └── rust.vim
├── lang/
│   ├── go.vim
│   ├── javascript.vim
│   ├── python.vim
│   └── rust.vim
└── sessions/
```

### Common Test Issues

**If Vim doesn't load the config:**
```bash
# Check if vimrc exists and is readable
ls -la ~/.vim/vimrc

# Manually source it
vim -u ~/.vim/vimrc
```

**If plugins don't work:**
```vim
:PlugInstall
:source ~/.vim/vimrc
```

**If vimspector doesn't start:**
```bash
# Install the Go adapter
cd ~/.vim/plugged/vimspector
./install_gadget.py --enable-go --force-all
```

##  Reverting to Original

If you want to go back to your original configuration:

```bash
# Remove the new setup (optional)
rm -rf ~/.vim/core ~/.vim/lang ~/.vim/ftplugin

# Restore original
cp ~/.vimrc.backup ~/.vimrc  # or ~/.vim/vimrc
```

Your original `.vimrc` is backed up at `~/.vimrc.backup`.

##  Quick Reference Card

```
DEBUGGING (Go)
  F5     Continue/Start    F9     Toggle BP      F10    Step Over
  F3     Stop              F8     Function BP    F11    Step Into
  F4     Restart           Leader+F9 Cond BP     F12    Step Out
  F6     Pause             Leader+di Inspect Var

PROFILES
  :Profile go              Switch to Go profile
  :ProfileShow             Show current profile

PROJECT SETUP
  :VimspectorConfig        Create/edit .vimspector.json
  :VimspectorReset         Reset debugger state

DEBUGGING COMMANDS (Go)
  :GoDB arg1 arg2          Debug main.go with args
  :GoDebugFile             Debug current file
  :GoDebugAttach PID       Attach to running process
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

Update all Vim plugins to their latest versions:

```bash
vim +PlugUpdate +qall
```

Or interactively in Vim:
```vim
:PlugUpdate
```

**When to update:** Monthly, or when you need a specific bug fix or feature from a plugin.

### Update Vimspector Debug Adapters

Update the Go debug adapter and other debuggers:

```bash
cd ~/.vim/plugged/vimspector
./install_gadget.py --enable-go --force-all
```

Or update all installed adapters:
```bash
cd ~/.vim/plugged/vimspector
./install_gadget.py --update-gadget-config
./install_gadget.py --all --force-all
```

**When to update:**
- When Go is updated to a new version
- When you encounter debugging issues
- Quarterly for bug fixes and improvements

### Regenerate Help Tags

After updating plugins or modifying help documentation:

```vim
:helptags ~/.vim/doc
```

Or from command line:
```bash
vim -u NONE -c "helptags ~/.vim/doc" -c "q"
```

**When to regenerate:** After modifying `~/.vim/doc/myvim.txt` or updating plugins with documentation.

### Check Plugin Health

View status of all plugins:
```vim
:PlugStatus
```

Clean up unused plugins (after removing from plugins.vim):
```vim
:PlugClean
```

### Verify Debug Adapter Installation

Check which debug adapters are installed:
```bash
ls ~/.vim/plugged/vimspector/gadgets/macos/  # or linux
```

You should see:
- `vscode-go` - Go debugging (recommended)
- `delve` - Direct Delve adapter (alternative)

### Available Debug Adapters

**Go Debugging - Two Options:**

1. **vscode-go** (Recommended):
   - Official VS Code Go extension adapter
   - Full-featured, best supported
   - Used in default configurations

2. **delve** (Alternative):
   - Direct Delve debugger access
   - Simpler, fewer features
   - Use if vscode-go has issues

**Switching adapters:** Edit `.vimspector.json` in your project and change:
```json
"adapter": "vscode-go"  // or "delve"
```

### Troubleshooting Adapter Issues

**Adapter not found error:**
```
The specified adapter 'vscode-go' is not available
```

**Solution:**
```bash
cd ~/.vim/plugged/vimspector
./install_gadget.py --enable-go --force-all
```

**List available adapters:**
```vim
:VimspectorInstall <Tab>  " Shows available adapters
```

### Complete Reinstall

If things are broken, start fresh:

```bash
# Backup current config
cp -r ~/.vim ~/.vim.backup

# Remove and reinstall
rm -rf ~/.vim
git clone https://github.com/panyam/myvim ~/.vim
cd ~/.vim
./install.sh
```

### Maintenance Schedule

**Weekly:**
- None required (configuration is stable)

**Monthly:**
- Update plugins: `:PlugUpdate`
- Check for vim config updates: `cd ~/.vim && git pull`

**Quarterly:**
- Update debug adapters: `./install_gadget.py --enable-go --force-all`
- Review and update language-specific configs

**As Needed:**
- After Go version upgrade: Update vimspector adapters
- When debugging fails: Reinstall adapters with `--force-all`
- After adding new plugins: Run `:PlugInstall`

---

**Last Updated:** 2025-10-25
**Configuration Version:** 1.0
