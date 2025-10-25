" ============================================================================
" Main Vim Configuration
" Modular setup - see ~/.vim/README.md for details
" ============================================================================

" Load all core configuration files
" These files are loaded in a specific order for proper initialization

" 1. Plugin management (must be first)
source ~/.vim/core/plugins.vim

" 2. General settings
source ~/.vim/core/settings.vim

" 3. Key mappings
source ~/.vim/core/mappings.vim

" 4. Plugin-specific configurations
source ~/.vim/core/ale.vim
source ~/.vim/core/spelunker.vim
source ~/.vim/core/vimspector.vim

" 5. Profile/workspace management
source ~/.vim/core/profiles.vim

" ============================================================================
" Project-Local Configuration
" ============================================================================
" Note: 'set exrc' and 'set secure' are enabled in settings.vim
" This allows project-specific .vimrc files in project directories
" For security, only safe commands are allowed in local .vimrc files

" ============================================================================
" Language-Specific Configuration
" ============================================================================
" Language configs in ~/.vim/lang/ are loaded automatically via:
" - ftplugin files in ~/.vim/ftplugin/ (auto-loaded by filetype)
" - Manual profile switching with :Profile <language>
"
" Available profiles:
"   :Profile go
"   :Profile javascript
"   :Profile python
"   :Profile rust

" ============================================================================
" Custom Project Settings
" ============================================================================
" Add any personal customizations below this line
" These will override the modular configurations above
