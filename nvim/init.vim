" ----------------------------------------- "
" Plugins                                   "
" ----------------------------------------- "
call plug#begin('~/.vim/plugged')

Plug 'mhinz/vim-startify'                       " Start screen.

Plug 'scrooloose/nerdtree'                      " Navigation Tree.
Plug 'mbbill/undotree'                          " History Tree.
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'               " Color parsing Tree.

Plug 'nvim-lua/popup.nvim'                      " Telescope prerequisite.
Plug 'nvim-lua/plenary.nvim'                    " Telescope/express prerequisite.

Plug 'ryanoasis/vim-devicons'                   " Pretty icons.
Plug 'kyazdani42/nvim-web-devicons'             " File icons.
Plug 'kyazdani42/nvim-tree.lua'
Plug 'tjdevries/express_line.nvim'              " Statusline.

Plug 'chriskempson/base16-vim'                  " Color schema.
Plug 'gruvbox-community/gruvbox'                " Color schema.

" In preparation for implementing my own color schema.
Plug 'tjdevries/colorbuddy.vim'
Plug 'tjdevries/gruvbuddy.nvim'
Plug 'norcalli/nvim-colorizer.lua'              " (testing).
Plug 'norcalli/nvim-terminal.lua'               " (testing).

Plug 'tami5/sql.nvim'                           " Frecency prerequisite.
Plug 'nvim-telescope/telescope.nvim'            " Project file system.
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' } " Telescope plugin.
Plug 'nvim-telescope/telescope-fzf-writer.nvim' " Telescope plugin.
Plug 'nvim-telescope/telescope-frecency.nvim'   " Telescope plugin.
Plug 'nvim-telescope/telescope-github.nvim'     " Telescope plugin.
Plug 'nvim-telescope/telescope-symbols.nvim'    " Telescope plugin.

Plug 'ThePrimeagen/harpoon'                     " Vim global marks

Plug 'tpope/vim-fugitive'                       " Git file system.
Plug 'ThePrimeagen/git-worktree.nvim'           " Git worktree.

Plug 'neovim/nvim-lspconfig'                    " Language server protocol.
Plug 'anott03/nvim-lspinstall'                  " Tools for LSP.
Plug 'wbthomason/lsp-status.nvim'               " Tools for LSP.
Plug 'glepnir/lspsaga.nvim'                     " Better UI for LSP (testing).
Plug 'onsails/lspkind-nvim'                     " LSP icons.
Plug 'hrsh7th/cmp-nvim-lsp'                     " nvim-cmp source for nvim LSP.
Plug 'hrsh7th/cmp-buffer'                       " nvim-cmp source for buffer w.
Plug 'hrsh7th/cmp-path'                         " nvim-cmp source for paths.
Plug 'hrsh7th/cmp-cmdline'                      " nvim-cmp source for cmdline.
Plug 'hrsh7th/nvim-cmp'                         " Completion engine plugin LSP.


" Snippets
Plug 'L3MON4D3/LuaSnip'                         " Snippets
Plug 'rafamadriz/friendly-snippets'             " Snippets

" Plug 'octol/vim-cpp-enhanced-highlight'         " C++ specific.
" Plug 'rhysd/vim-clang-format'                   " C++ specific (testing).
" Plug 'mfussenegger/nvim-dap'                    " C++ debug specific (testing).
" Plug 'mfussenegger/nvim-dap-python'             " C++ debug specific (testing).
" Plug 'theHamsta/nvim-dap-virtual-text'          " C++ debug specific (testing).
" Plug 'nvim-telescope/telescope-dap.nvim'        " (testing).

Plug 'rust-lang/rust.vim'                         " Rust specific.
" Plug 'simrat39/rust-tools.nvim'                   " Rust specific.

Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' } " Go specific.

Plug 'junegunn/goyo.vim'                        " Markdown specific.

Plug 'ap/vim-css-color'                         " CSS specific.

Plug 'Raimondi/delimitMate'                     " Automatic () {} []
Plug 'tpope/vim-surround'                       " Better surroundings ''
Plug 'tweekmonster/spellrotate.vim'             " Text suggestions (testing).

Plug 'tjdevries/command_and_conquer.nvim'       " Run commands (testing).

Plug 'norcalli/snippets.nvim'                   " Snippets

call plug#end()

lua require'nvim-treesitter.configs'.setup { indent = { enable = true }, highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}


" ----------------------------------------- "
" Settings                                  "
" ----------------------------------------- "
set exrc                                        " Load other vrc files.
set noerrorbells                                " No beeps.
set guicursor=                                  " Do not change cursor type in INSERT mode.
set encoding=utf-8                              " Set default encoding to UTF-8
set termguicolors                               " Allow 24-bit colors in GUI.
set splitright                                  " Split vertical windows right to the current windows.
" set splitbelow                                  " Split horizontal windows below to the current windows.
set scrolloff=15                                " Keep scrolling to have at least 10 lines in the bottom.

set number relativenumber                       " Show line numbers.
set noshowmode                                  " We show the mode with airline or lightline.
set showcmd                                     " Show me what I'm typing.
set colorcolumn=80

set nohlsearch                                  " No highlight after searching.
set incsearch                                   " Shows the match while searching.
set ignorecase                                  " search cse insensitive...
set smartcase                                   " ...but not when search pattern contains upper case characters.

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent                                 " Improved indentation.
set nowrap                                      " No wrapping of lines.

set hidden                                      " Keep other buffers open in background.
set noswapfile                                  " Do not use swap files.
set nobackup                                    " Do not create anoying backup files.
set undodir=~/.vim/undodir                      " Directory to save undo files.
set undofile                                    " Create an undo file per buffer file.
set autowrite                                   " Automatically save before :next, :make, etc.
set autoread                                    " Automatically read changed files without asking.
set updatetime=50                               " Increase the updatetime for smoother experience.

set backspace=indent,eol,start                  " Makes backspace key more powerful.
set laststatus=2                                " Lightline configuration.


" ----------------------------------------- "
" File Type settings                        "
" ----------------------------------------- "

" Ignore compiled files
set wildignore+=*~,
set wildignore+=*.o,
set wildignore+=*.pyc,
set wildignore+=**__pycache__/*
set wildignore+=**/pycache/*,
set wildignore+=**/.cache/*,
set wildignore+=**/node_modules/*
set wildignore+=**/.git/*
set wildignore+=**/DS_Store/*

" Wrap tex files
augroup WrapLineInTeXFile
    autocmd!
    autocmd FileType tex setlocal wrap
augroup END

" ----------------------------------------- "
" Syntax                                    "
" ----------------------------------------- "
syntax enable
let base16colorspace=256
colorscheme base16-tomorrow-night
" colorscheme gruvbox
" lua require('colorbuddy').colorscheme('gruvbuddy')


" ----------------------------------------- "
" Mappings                                  "
" ----------------------------------------- "
let mapleader = ","


" Resize splits when the window is resized
autocmd VimResized * :wincmd =

" Fast saving
nnoremap <leader>w :w!<cr>
nnoremap <silent><leader>q :q!<CR>

" Fast moving between windows
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>t :TagbarToggle<CR>

" Git commands
nnoremap <leader>gc :GBranches<CR>
nnoremap <leader>ga :Git fetch --all<CR>
nnoremap <leader>grum :Git rebase upstream/master<CR>
nnoremap <leader>grom :Git rebase origin/master<CR>

nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>
nmap <leader>gs :G<CR>

" ----------------------------------------- "
" Commands                                  "
" ----------------------------------------- "
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup DVD_CONFIG
    autocmd!
    autocmd BufWritePre c,cc,cpp,cxx,h,hh,hpp,hxx,ipp Neoformat
    autocmd BufWritePre * :call TrimWhitespace()
augroup END

autocmd BufWritePost,FileWritePost *.tex :silent !pdflatex %


lua require('dvd.globals')
lua require('dvd.lsp')
lua require('dvd.telescope')
lua require('dvd.telescope.mappings')
