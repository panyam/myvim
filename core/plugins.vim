" ============================================================================
" Plugin Management
" ============================================================================
" All plugin declarations using vim-plug

if has('nvim')
  call plug#begin('~/.local/share/nvim/plugged')
else
  call plug#begin('~/.vim/plugged')
endif

" Wiki and note-taking
Plug 'vimwiki/vimwiki'

" Alignment
Plug 'junegunn/vim-easy-align'

" Code formatting
Plug 'Chiel92/vim-autoformat'

" GitHub integration
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Debugging with vimspector
Plug 'puremourning/vimspector'

" File browsing
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Clojure support
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" YCM Generator
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Go support
Plug 'fatih/vim-go', { 'tag': '*' }

" Go code completion (older version)
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Spell checker
Plug 'kamykn/spelunker.vim'

" JavaScript plugins
Plug 'pangloss/vim-javascript'
Plug 'joegesualdo/jsdoc.vim'

" Linting
Plug 'w0rp/ale'

" Neovim compatibility for regular Vim
if !has('nvim')
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" Rust support
Plug 'rust-lang/rust.vim'

" Code completion
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}

call plug#end()
