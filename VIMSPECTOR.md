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
  - [Debugging with Stdin Redirection](#example-4-debugging-with-stdin-redirection)
- [Troubleshooting](#troubleshooting)
- [Advanced Topics](#advanced-topics)

## Quick Start

1. **Set a breakpoint** (program will exit immediately without one):
   ```vim
   :call vimspector#ToggleBreakpoint()
   " or press <F9>
   ```

2. **Start debugging**:
   ```vim
   :GoDebug main.go              " Debug a specific file
   :GoDebug .                    " Debug current directory (all .go files)
   :GoDebug . arg1 arg2          " Debug with arguments
   ```

3. **Use F-keys to control execution** (see [Key Mappings](#key-mappings))

4. **Optional: Use `.vimspector.json`** for saved configurations:
   ```vim
   :VimspectorConfig             " Create config file
   <F5>                          " Launch using .vimspector.json
   ```

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

| Command | Description | Example |
|---------|-------------|---------|
| `:GoDebug <target> [args...]` | Debug a Go program with optional arguments | `:GoDebug . --config dev.yaml --port 8080` |
| `:GoDebugStdin <input-file> <target> [args...]` | Debug with stdin from file | `:GoDebugStdin testdata/input.txt . --verbose` |
| `:GoDebugAttach <pid>` | Attach to a running process | `:GoDebugAttach 12345` |

**Target Options:**
- `main.go` - Debug a specific file
- `.` - Debug current directory (all .go files in the package)
- `./cmd/cli` - Debug a specific directory/package
- Any valid Go package path

**Two Debugging Workflows:**

1. **Ad-hoc debugging** (command-line style):
   - Use `:GoDebug` or `:GoDebugStdin` commands
   - Great for testing different arguments quickly
   - No `.vimspector.json` file needed

2. **Saved configurations** (using `.vimspector.json`):
   - Use `<F5>` or `:call vimspector#Launch()`
   - Define `program`, `args`, `input` in the JSON file
   - Great for standard/repeated debug sessions

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

**Basic configuration with arguments:**
```json
{
  "configurations": {
    "Launch with args": {
      "adapter": "vscode-go",
      "configuration": {
        "request": "launch",
        "program": "${workspaceRoot}/main.go",
        "mode": "debug",
        "args": ["--config", "config.yaml", "--verbose"]
      }
    }
  }
}
```

**With environment variables:**
```json
{
  "configurations": {
    "Launch development": {
      "adapter": "vscode-go",
      "configuration": {
        "request": "launch",
        "program": "${workspaceRoot}/cmd/myapp/main.go",
        "mode": "debug",
        "args": ["--config", "config.yaml"],
        "env": {
          "GO_ENV": "development",
          "DEBUG": "true"
        }
      }
    }
  }
}
```

**With stdin redirection from file:**
```json
{
  "configurations": {
    "Launch with stdin": {
      "adapter": "vscode-go",
      "configuration": {
        "request": "launch",
        "program": "${workspaceRoot}/main.go",
        "mode": "debug",
        "args": ["arg1", "arg2"],
        "console": "integratedTerminal",
        "input": "${workspaceRoot}/testdata/input.txt"
      }
    }
  }
}
```

**With integrated console (for interactive input):**
```json
{
  "configurations": {
    "Launch interactive": {
      "adapter": "vscode-go",
      "configuration": {
        "request": "launch",
        "program": "${workspaceRoot}/main.go",
        "mode": "debug",
        "console": "integratedTerminal"
      }
    }
  }
}
```

**Debug tests:**
```json
{
  "configurations": {
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

### Convenience Commands

**Quick Mappings (debug mode only)**:

| Key | Action | Description |
|-----|--------|-------------|
| `<Enter>` | Step Over | Step over current line (most common action!) |
| `<Shift-Enter>` | Step Into | Step into function call |

**Quick Commands (always available)**:

| Command | Action | Description |
|---------|--------|-------------|
| `:BR` | Toggle Breakpoint | Add/remove breakpoint at current line |
| `:DR` | Restart | Restart debug session with same args |

**Quick Commands (debug mode only)**:

| Command | Action         | Description                                    |
|---------|----------------|------------------------------------------------|
| `:SI`   | Step Into      | Step into function call                        |
| `:SN`   | Step Over      | Step over current line (same as `<Enter>`)     |
| `:SO`   | Step Out       | Step out of current function                   |
| `:CO`   | Smart Continue | Continue if at paused line, else Run To Cursor |
| `:DS`   | Stop           | Stop debugging                                 |

**Pro Tip:** Just press `<Enter>` repeatedly to step through your code line by line!

**Smart Continue (`:CO`)**:
- If you're at the paused line: continues execution
- If you move to a different line: runs to that line (like a temporary breakpoint)

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

### Configuration Options

**Common configuration options for `.vimspector.json`:**

| Option | Description | Example |
|--------|-------------|---------|
| `program` | Path to program to debug | `"${workspaceRoot}/main.go"` |
| `args` | Command-line arguments as array | `["--config", "dev.yaml", "--verbose"]` |
| `env` | Environment variables | `{"GO_ENV": "dev"}` |
| `cwd` | Working directory | `"${workspaceRoot}"` |
| `console` | Console type | `"integratedTerminal"` or `"externalTerminal"` |
| `input` | Stdin redirection from file | `"${workspaceRoot}/testdata/input.txt"` |
| `mode` | Debug mode | `"debug"`, `"test"`, or `"exec"` |

**Console options:**
- `"integratedTerminal"` - Run in Vim's terminal (supports interactive input)
- `"externalTerminal"` - Run in external terminal window
- Not specified - Run without terminal (no stdin/stdout interaction)

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
:GoDebug <target> [args...]                      " Debug with optional arguments
:GoDebugStdin <input-file> <target> [args...]    " Debug with stdin from file
:GoDebugAttach <pid>                             " Attach to running process
```

**Examples:**
```vim
" Debug specific file
:GoDebug main.go

" Debug current directory (all .go files)
:GoDebug .

" Debug with arguments
:GoDebug . --config dev.yaml --port 8080

" Debug specific package with arguments
:GoDebug ./cmd/cli --dryrun --game-id c5380903 tiles

" Debug with stdin redirection
:GoDebugStdin testdata/input.txt . --verbose

" Debug with stdin and arguments
:GoDebugStdin input.txt ./cmd/cli --config dev.yaml
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
" 1. Set a breakpoint on line 7 (the greeting := line)
:7
<F9>

" 2. Start debugging
:GoDebug main.go

" 3. You should see:
"    - Vimspector windows open (variables, watches, stack)
"    - Execution paused at your breakpoint
"    - Current line highlighted

" 4. Test stepping
<F10>    " Step over - should move to next line
<F11>    " Step into - try on a function call
<F12>    " Step out

" 5. Inspect variables
" Hover over 'name' variable and press <Leader>di
" Should show the value "World"

" 6. Stop debugging
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
:GoDebug . --config=dev --port=8080

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

### Example 4: Debugging with Stdin Redirection

For programs that read from stdin, you have several options:

**Option 1: Using `:GoDebugStdin` command (Easiest!)**

Create `testdata/input.txt`:
```
line 1
line 2
line 3
```

Then simply run:
```vim
:GoDebugStdin testdata/input.txt main.go

" Or debug current directory:
:GoDebugStdin testdata/input.txt .

" Or with additional arguments:
:GoDebugStdin testdata/input.txt . --verbose --config dev.yaml
```

This automatically:
- Redirects stdin from the file
- Debugs the specified target (file or directory)
- Passes remaining arguments to your program
- No need to edit `.vimspector.json`!

**Option 2: Using `.vimspector.json` configuration**

Create `.vimspector.json`:
```json
{
  "configurations": {
    "Launch with input": {
      "adapter": "vscode-go",
      "configuration": {
        "request": "launch",
        "program": "${workspaceRoot}/main.go",
        "mode": "debug",
        "console": "integratedTerminal",
        "input": "${workspaceRoot}/testdata/input.txt"
      }
    }
  }
}
```

Then launch with F5 or `:call vimspector#Launch()`

**Option 3: Interactive terminal**

For programs that need interactive input during debugging:

```json
{
  "configurations": {
    "Launch interactive": {
      "adapter": "vscode-go",
      "configuration": {
        "request": "launch",
        "program": "${workspaceRoot}/main.go",
        "mode": "debug",
        "console": "integratedTerminal"
      }
    }
  }
}
```

With `console: "integratedTerminal"`, you can type input directly in the terminal window.

**Option 4: Using shell redirection (external terminal)**

```json
{
  "configurations": {
    "Launch external": {
      "adapter": "vscode-go",
      "configuration": {
        "request": "launch",
        "program": "${workspaceRoot}/main.go",
        "mode": "debug",
        "console": "externalTerminal",
        "args": []
      }
    }
  }
}
```

This opens an external terminal where you can manually use shell redirection.

### Passing Arguments: Two Approaches

**Approach 1: Runtime arguments (Recommended for testing)**

Use the `:GoDebug` command to specify arguments each time you debug:

```vim
:GoDebug . --config dev.yaml --verbose --port 8080
```

This is perfect when:
- You're testing different argument combinations
- Arguments change frequently
- You don't want to edit `.vimspector.json` each time

**Approach 2: Pre-configured arguments**

Define arguments in `.vimspector.json` for consistent debugging:

```json
{
  "configurations": {
    "Launch with args": {
      "adapter": "vscode-go",
      "configuration": {
        "request": "launch",
        "program": ".",
        "mode": "debug",
        "args": ["--config", "dev.yaml", "--verbose", "--port", "8080"]
      }
    }
  }
}
```

Then simply:
```vim
:call vimspector#Launch()
" or press F5
```

This is better when:
- You have standard arguments for this project
- You want to save typing
- You have multiple configurations (dev, prod, test)

**Using `:VimspectorRestart`**

Once you start debugging with either approach, you can restart with the same configuration:
```vim
:VimspectorRestart
```

This preserves your target and arguments from the initial launch!

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
