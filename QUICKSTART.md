# Vim Configuration - Quick Start

## Installation

### Automated Installation (Recommended)

```bash
# Clone the repository
git clone https://github.com/panyam/myvim ~/.vim

# Run the installation script
cd ~/.vim
./install.sh
```

The script will:
- Install vim-plug
- Install all plugins
- Install vimspector Go debugger adapter
- Create necessary directories

### Manual Installation

```bash
# Clone repo
git clone https://github.com/panyam/myvim ~/.vim

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install plugins
vim +PlugInstall +qall

# Install Go debugger
cd ~/.vim/plugged/vimspector
./install_gadget.py --enable-go
```

## Verify Installation

Open Vim and check:

```bash
vim
```

In Vim, run:
```vim
:scriptnames        " Should show all config files loaded
:PlugStatus         " Check plugins
:command GoDB       " Verify Go debugging command exists
```

## Go Debugging with Vimspector

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
      "adapter": "vimspector-go",
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

## Key Commands

### Getting Help
- `:help myvim` - Main help for this configuration
- `:help GoDB` - Help for GoDB command
- `:help myvim-go-debugging` - Complete Go debugging documentation
- `:help myvim-go-mappings` - List of all debugging key mappings

### Go Debugging
- `:GoDB arg1 arg2` - Debug main.go with arguments
- `:GoDebugFile` - Debug current file
- `:GoDebugAttach PID` - Attach to running process
- `:VimspectorConfig` - Create/edit .vimspector.json
- `:VimspectorReset` - Reset debugger state

### Profiles
- `:Profile go` - Load Go profile
- `:Profile javascript` - Load JavaScript profile
- `:ProfileShow` - Show current profile

### Plugin Management
- `:PlugInstall` - Install plugins
- `:PlugUpdate` - Update plugins
- `:PlugClean` - Remove unused plugins
- `:PlugStatus` - Check plugin status

## Full Integration Test

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

## Troubleshooting

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

## Full Documentation

See `~/.vim/README.md` for complete documentation including:
- Adding new languages
- Project-specific configuration
- Customization guide
- Advanced features

## Updating

```bash
cd ~/.vim
git pull
vim +PlugUpdate +qall
```

---

**Repository:** https://github.com/panyam/myvim
