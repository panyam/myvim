#!/bin/bash
# Vim Configuration Installation Script
# Repository: https://github.com/panyam/myvim

set -e  # Exit on error

echo "Installing Vim Configuration..."

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if already in ~/.vim
if [ "$PWD" = "$HOME/.vim" ]; then
    echo -e "${GREEN}[OK] Already in ~/.vim directory${NC}"
else
    echo -e "${RED}[ERROR] This script should be run from ~/.vim${NC}"
    echo "  Please clone the repo first:"
    echo "  git clone https://github.com/panyam/myvim ~/.vim"
    exit 1
fi

# Install vim-plug if not present
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
    echo -e "${YELLOW}Installing vim-plug...${NC}"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo -e "${GREEN}[OK] vim-plug installed${NC}"
else
    echo -e "${GREEN}[OK] vim-plug already installed${NC}"
fi

# Create swap directory
mkdir -p ~/.vim/swapfiles
echo -e "${GREEN}[OK] Swap directory created${NC}"

# Create sessions directory
mkdir -p ~/.vim/sessions
echo -e "${GREEN}[OK] Sessions directory created${NC}"

# Install Vim plugins
echo -e "${YELLOW}Installing Vim plugins...${NC}"
vim +PlugInstall +qall
echo -e "${GREEN}[OK] Vim plugins installed${NC}"

# Install vimspector Go adapter
if [ -d "$HOME/.vim/plugged/vimspector" ]; then
    echo -e "${YELLOW}Installing vimspector Go debugger adapter...${NC}"
    cd ~/.vim/plugged/vimspector

    if [ -f "./install_gadget.py" ]; then
        ./install_gadget.py --enable-go
        echo -e "${GREEN}[OK] Vimspector Go adapter installed${NC}"
    else
        echo -e "${RED}[ERROR] install_gadget.py not found${NC}"
        echo "  You may need to install it manually later"
    fi

    cd ~/.vim
else
    echo -e "${YELLOW}[WARNING] Vimspector not found in plugged directory${NC}"
    echo "  Run :PlugInstall in Vim and then install the adapter manually"
fi

# Generate help tags
echo -e "${YELLOW}Generating help tags...${NC}"
vim -u NONE -c "helptags ~/.vim/doc" -c "q" 2>/dev/null || true
echo -e "${GREEN}[OK] Help tags generated${NC}"

echo ""
echo -e "${GREEN}Installation complete!${NC}"
echo ""
echo "Next steps:"
echo "  1. Open Vim: vim"
echo "  2. Verify plugins: :PlugStatus"
echo "  3. Read the docs: vim ~/.vim/README.md"
echo "  4. Get help: :help myvim"
echo "  5. Try Go debugging: vim ~/.vim/QUICKSTART.md"
echo ""
echo "For more information, see ~/.vim/README.md"
