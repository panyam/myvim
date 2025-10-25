# Vimspector - Visual Debugging Guide

Vimspector provides a complete visual debugging experience in Vim, supporting multiple languages including Go, Python, JavaScript, C/C++, Rust, and more.

## Table of Contents

- [Quick Start](#quick-start)
- [Installation](#installation)
- [Go Debugging](#go-debugging)
- [Key Mappings](#key-mappings)
- [Configuration](#configuration)
- [Debugging Commands](#debugging-commands)
- [Example Workflows](#example-workflows)
- [Troubleshooting](#troubleshooting)
- [Advanced Topics](#advanced-topics)

## Quick Start

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

3. **Set breakpoints** and use F-keys to control execution (see [Key Mappings](#key-mappings))

## Installation

### Install Go Debug Adapter

After installing plugins with `:PlugInstall`, install the Go adapter:

```bash
cd ~/.vim/plugged/vimspector
./install_gadget.py --enable-go
```

### Verify Installation

```bash
ls ~/.vim/plugged/vimspector/gadgets/macos/  # or linux
```

You should see:
- `vscode-go` - Go debugging (recommended)
- `delve` - Direct Delve adapter (alternative)

## Go Debugging

### Quick Setup

The configuration includes custom Go debugging commands that make it easy to start debugging:

| Command | Description |
|---------|-------------|
| `:GoDB [args...]` | Debug main.go with optional arguments |
| `:GoDebugFile` | Debug the current Go file |
| `:GoDebugAttach [PID]` | Attach to a running process |

### Creating Configuration Files

**Option 1: Use the helper command** (Recommended)
```vim
:VimspectorConfig
```

**Option 2: Create manually**

Create `.vimspector.json` in your project root:

```json
{
  "configurations": {
    "Launch": {
      "adapter": "vscode-go",
      "configuration": {
        "request": "launch",
        "program": "${workspaceRoot}/main.go",
        "mode": "debug"
      }
    }
  }
}
```

### Custom Debugging Configurations

Edit `.vimspector.json` for advanced scenarios:

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
    },
    "Debug tests": {
      "adapter": "vscode-go",
      "configuration": {
        "request": "launch",
        "mode": "test",
        "program": "${workspaceRoot}"
      }
    }
  }
}
```

## Key Mappings

### Debugging Key Mappings

| Key | Action |
|-----|--------|
| `F5` | Continue/Start debugging |
| `F3` | Stop debugging |
| `F4` | Restart debugging |
| `F6` | Pause |
| `F9` | Toggle breakpoint |
| `<Leader>F9` | Conditional breakpoint |
| `F8` | Function breakpoint |
| `F10` | Step over |
| `F11` | Step into |
| `F12` | Step out |
| `<Leader>di` | Inspect variable under cursor |

**Note:** `<Leader>` is typically `,` (comma) by default.

### Custom Key Mappings

You can customize these in `~/.vim/core/vimspector.vim`. Example:

```vim
" Custom debugging shortcuts
nnoremap <Leader>db :call vimspector#ToggleBreakpoint()<CR>
nnoremap <Leader>dc :call vimspector#Continue()<CR>
nnoremap <Leader>ds :call vimspector#Stop()<CR>
```

## Configuration

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

### UI Layout Configuration

See [CUSTOMIZATION.md](CUSTOMIZATION.md) for detailed UI customization options.

Quick example - add to `.vimspector.json`:

```json
{
  "ui": {
    "Variables": { "pos": "right", "width": 60 },
    "Watches": { "pos": "right", "width": 60 },
    "Stack": { "pos": "right", "width": 60 },
    "Output": { "pos": "bottom", "height": 10 },
    "Console": { "pos": "bottom", "height": 10 }
  },
  "configurations": {
    ...
  }
}
```

## Debugging Commands

### Built-in Vimspector Commands

```vim
:VimspectorConfig          " Create/edit .vimspector.json
:VimspectorReset           " Reset debugger state
:VimspectorShowOutput      " Show debugger output
:VimspectorToggleLog       " Toggle debug logging
```

### Custom Go Commands

These are provided by this configuration (`lang/go.vim`):

```vim
:GoDB [args...]            " Debug main.go with arguments
:GoDebugFile               " Debug current file
:GoDebugAttach [PID]       " Attach to running process
```

## Example Workflows

### Example 1: Basic Go Program

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

Now debug it:

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

### Example 2: Debugging with Arguments

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

### Example 3: Conditional Breakpoints

```vim
" Go to the line where you want a conditional breakpoint
:50

" Set a conditional breakpoint
<Leader>F9

" Enter condition (e.g., i == 10)
" The debugger will only stop when the condition is true
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

### Adapter Not Found Error

```
The specified adapter 'vscode-go' is not available
```

**Solution:**
```bash
cd ~/.vim/plugged/vimspector
./install_gadget.py --enable-go --force-all
```

### Breakpoints Not Visible

1. Check if sign column is enabled:
   ```vim
   :set signcolumn?
   ```
   Should show `signcolumn=yes` or `signcolumn=auto`

2. Enable sign column:
   ```vim
   :set signcolum=yes
   ```

3. Add to your `~/.vim/core/settings.vim`:
   ```vim
   set signcolumn=yes
   ```

See [CUSTOMIZATION.md](CUSTOMIZATION.md) for breakpoint visibility customization.

### Panels Don't Close

If panels don't auto-close, manually close with:
```vim
:VimspectorReset
```

Auto-close is enabled by default in this configuration.

### Debugger Output Not Showing

View debugger messages:
```vim
:VimspectorShowOutput
:messages                 " View all Vim messages
```

## Advanced Topics

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

### List Available Adapters

```vim
:VimspectorInstall <Tab>  " Shows available adapters
```

### Available Language Adapters

Install adapters for other languages:

```bash
cd ~/.vim/plugged/vimspector

# Python
./install_gadget.py --enable-python

# JavaScript/TypeScript
./install_gadget.py --enable-node

# C/C++/Rust
./install_gadget.py --enable-c --enable-rust

# All adapters
./install_gadget.py --all
```

### Multiple Configurations

You can have multiple debug configurations in `.vimspector.json`:

```json
{
  "configurations": {
    "Launch Development": {
      "adapter": "vscode-go",
      "configuration": {
        "request": "launch",
        "program": "${workspaceRoot}/main.go",
        "env": { "ENV": "dev" }
      }
    },
    "Launch Production": {
      "adapter": "vscode-go",
      "configuration": {
        "request": "launch",
        "program": "${workspaceRoot}/main.go",
        "env": { "ENV": "prod" }
      }
    },
    "Attach to Process": {
      "adapter": "vscode-go",
      "configuration": {
        "request": "attach",
        "mode": "local",
        "processId": "${processId}"
      }
    }
  }
}
```

Then select which configuration to use:
```vim
:VimspectorLaunch Launch Development
:VimspectorLaunch Launch Production
:VimspectorLaunch Attach to Process
```

### Remote Debugging

Debug programs running on remote machines:

```json
{
  "configurations": {
    "Remote Debug": {
      "adapter": "vscode-go",
      "configuration": {
        "request": "attach",
        "mode": "remote",
        "remotePath": "/remote/path/to/project",
        "port": 2345,
        "host": "192.168.1.100"
      }
    }
  }
}
```

## Further Reading

### Vimspector Documentation
- GitHub: https://github.com/puremourning/vimspector
- `:help vimspector`

### Go Debugging
- vim-go: https://github.com/fatih/vim-go
- Delve (Go debugger): https://github.com/go-delve/delve

### Related Guides
- [CUSTOMIZATION.md](CUSTOMIZATION.md) - UI customization and layouts
- [PLUGINS.md](PLUGINS.md) - All plugins and configuration

---

**Last Updated:** 2025-10-25
