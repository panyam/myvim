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

| Key | Action | Command Mode Alternative |
|-----|--------|-------------------------|
| `F5` | Continue/Start debugging | `:DebugStart` |
| `F3` | Stop debugging | `:DebugStop` |
| `F4` | Restart debugging | `:DebugRestart` |
| `F6` | Pause | `:DebugPause` |
| `F9` | Toggle breakpoint | `:BreakAdd` or `:BreakDel` |
| `Leader+F9` | Conditional breakpoint | `:BreakCond` |
| `F8` | Function breakpoint | `:BreakFunc` |
| `F10` | Step over | `:StepOver` |
| `F11` | Step into | `:StepInto` |
| `F12` | Step out | `:StepOut` |
| `Leader+di` | Inspect variable under cursor | (key mapping only) |

**Prefer command mode?** All debugging operations have `:Command` equivalents!

### Example Usage

```vim
" Open your Go project
:cd ~/myproject

" Set a breakpoint on line 42
:42     " Go to line 42
<F9>    " Toggle breakpoint
" OR use command mode:
:BreakAdd

" Start debugging with arguments
:GoDB --config=dev --port=8080
:DebugStart

" When stopped at breakpoint (use keys or commands):
<F11>   " Step into function
:StepInto

<F10>   " Step over line
:StepOver

<F12>   " Step out of function
:StepOut

" Stop debugging
<F3>
:DebugStop
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

## Key Commands

### Getting Help
- `:help myvim` - Main help for this configuration
- `:help GoDB` - Help for GoDB command
- `:help myvim-go-debugging` - Complete Go debugging documentation
- `:help myvim-go-mappings` - List of all debugging key mappings
- `:help DebugStart` - Help for command-mode debugging commands

### Go Debugging Commands
- `:GoDB arg1 arg2` - Debug main.go with arguments
- `:GoDebugFile` - Debug current file
- `:GoDebugAttach PID` - Attach to running process
- `:VimspectorConfig` - Create/edit .vimspector.json
- `:VimspectorReset` - Reset debugger state

### Debugging Control (Command Mode)
- `:DebugStart` / `:DebugContinue` - Start or continue execution
- `:DebugStop` - Stop debugging
- `:DebugRestart` - Restart session
- `:DebugPause` - Pause execution
- `:BreakAdd` / `:BreakDel` - Toggle breakpoint on current line
- `:BreakCond` - Add conditional breakpoint
- `:BreakClearAll` - Clear all breakpoints
- `:StepOver` - Step over current line
- `:StepInto` - Step into function
- `:StepOut` - Step out of function
- `:RunToCursor` - Run until cursor position

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
