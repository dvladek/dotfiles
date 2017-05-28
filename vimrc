call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-fugitive'

Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'

Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --gocode-completer' }
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'scrooloose/syntastic'

Plug 'morhetz/gruvbox'          			" color schema 
Plug 'chriskempson/base16-vim'  			" color schema

Plug 'octol/vim-cpp-enhanced-highlight'			" C++ specific

Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }	" Go specific 

Plug 'vim-scripts/indentpython.vim'			" Python specific
Plug 'nvie/vim-flake8'					" Python specific

Plug 'junegunn/goyo.vim'				" Markdown specific

"
" Pending to decide
"
" Plug 'tpope/vim-dispatch'
" Plug 'jeaye/color_coded'
" Plug 'fatih/molokai'
" autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
" autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
" autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
" autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

call plug#end()

"
" Plug settings
"
set nocompatible                " be iMproved, required
filetype off                    " required
filetype plugin indent on       " required

"
" Settings
"
set noerrorbells                " No beeps
set number                      " Show line numbers
set backspace=indent,eol,start  " Makes backspace key more powerful.
set showcmd                     " Show me what I'm typing
set showmode                    " Show current mode.

set noswapfile                  " Don't use swapfile
set nobackup            	" Don't create annoying backup files
set splitright                  " Split vertical windows right to the current windows
set splitbelow                  " Split horizontal windows below to the current windows
set encoding=utf-8              " Set default encoding to UTF-8
set autowrite                   " Automatically save before :next, :make etc.
set autoread                    " Automatically reread changed files without asking me anything
set laststatus=2
set hidden
set colorcolumn=80

set noshowmatch                 " Do not show matching brackets by flickering
set nocursorcolumn
set noshowmode                  " We show the mode with airlien or lightline
set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not when search pattern contains upper case characters
set ttyfast
set ttymouse=xterm2
set ttyscroll=3

set lazyredraw          		" Wait to redraw "

" speed up syntax highlighting
set nocursorcolumn
set nocursorline

syntax sync minlines=256
set synmaxcol=300
set re=1
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

if has("gui_macvim")
" No toolbars, menu or scrollbars in the GUI
  set guifont=Source\ Code\ Pro\ Light:h12
  set clipboard+=unnamed
  set vb t_vb=
  set guioptions-=m             " no menu
  set guioptions-=T             " no toolbar
  set guioptions-=l
  set guioptions-=L
  set guioptions-=r             "no scrollbar
  set guioptions-=R
endif
 
syntax enable

if $TERM_PROGRAM == "Apple_Terminal"
  set background=dark
  colorscheme gruvbox
  let g:gruvbox_contrast_dark = "hard"
else
  let base16colorspace=256
  colorscheme base16-tomorrow-night
endif


" ----------------------------------------- "
" Mappings			    					" 			    
" ----------------------------------------- "

let mapleader = ","
let g:mapleader = ","

" Replace the current buffer with the given new file. That means a new file
" will be open in a buffer while the old one will be deleted
com! -nargs=1 -complete=file Breplace edit <args>| bdelete #

function! DeleteInactiveBufs()
    "From tabpagebuflist() help, get a list of all buffers in all tabs
    let tablist = []
    for i in range(tabpagenr('$'))
        call extend(tablist, tabpagebuflist(i + 1))
    endfor

    "Below originally inspired by Hara Krishna Dara and Keith Roberts
    "http://tech.groups.yahoo.com/group/vim/message/56425
    let nWipeouts = 0
    for i in range(1, bufnr('$'))
        if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
        "bufno exists AND isn't modified AND isn't in the list of buffers open in windows and tabs
            silent exec 'bwipeout' i
            let nWipeouts = nWipeouts + 1
        endif
    endfor
    echomsg nWipeouts . ' buffer(s) wiped out'
endfunction

command! Ball :call DeleteInactiveBufs()


" ========== Steve Losh hacks ==========="
 
" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=10

" Better Completion
set complete=.,w,b,u,t
set completeopt=longest,menuone

" Diffoff
nnoremap <leader>D :diffoff!<cr>

" Resize splits when the window is resized
au VimResized * :wincmd =


" ----------------------------------------- "
" File Type settings 			    		"
" ----------------------------------------- "

au BufNewFile,BufRead *.cxx setlocal noet ts=4 sw=4 sts=4
au BufNewFile,BufRead *.cpp setlocal noet ts=4 sw=4 sts=4
au BufNewFile,BufRead *.hxx setlocal noet ts=4 sw=4 sts=4
au BufNewFile,BufRead *.hpp setlocal noet ts=4 sw=4 sts=4

au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4
au BufNewFile,BufRead *.ino setlocal noet ts=4 sw=4 sts=4

au BufNewFile,BufRead *.py setlocal noet ts=4 sw=4 sts=4

au BufNewFile,BufRead *.vim setlocal expandtab ts=4 sw=4
au BufNewFile,BufRead *.txt setlocal noet ts=4 sw=4
au BufNewFile,BufRead *.md setlocal noet ts=4 sw=4

autocmd FileType json setlocal expandtab ts=2 sw=2
autocmd FileType ruby setlocal expandtab ts=2 sw=2

augroup filetypedetect
  au BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
  au BufNewFile,BufRead .nginx.conf*,nginx.conf* setf nginx
augroup END

" Wildmenu completion {{{
set wildmenu
" set wildmode=list:longest
set wildmode=list:full

set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.luac                           " Lua byte code
set wildignore+=migrations                       " Django migrations
set wildignore+=go/pkg                       	 " Go static files
set wildignore+=go/bin                       	 " Go bin files
set wildignore+=go/bin-vagrant               	 " Go bin-vagrant files
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.orig                           " Merge resolution files


" ----------------------------------------- "
" Plugin configs			    			" 			    
" ----------------------------------------- "

" ==================== NerdTree ====================
" Open nerdtree in current dir, write our own custom function because
" NerdTreeToggle just sucks and doesn't work for buffers
noremap <Leader>n :NERDTreeToggle<cr>
noremap <Leader>f :NERDTreeFind<cr>

let NERDTreeShowHidden = 1


" ==================== Tagbar ====================
nmap <F8> :TagbarToggle<CR>


" ==================== Fugitive ====================
vnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gb :Gblame<CR>


" ==================== delimitMate ====================
let g:delimitMate_expand_cr = 1		
let g:delimitMate_expand_space = 1		
let g:delimitMate_smart_quotes = 1		
let g:delimitMate_expand_inside_quotes = 0		
let g:delimitMate_smart_matchpairs = '^\%(\w\|\$\)'		

imap <expr> <CR> pumvisible() ? "\<c-y>" : "<Plug>delimitMateCR"


" ==================== YouCompleteMe ====================
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_of_chars_for_completion = 1

let g:ycm_python_binary_path = '/usr/local/bin/python3'
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'


" ==================== Syntastic ====================
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


" ============ Vim-cpp-enhanced-highlight ============
let g:cpp_concepts_highlight = 1
let g:cpp_class_scope_highlight = 1


" ==================== Vim-go ====================
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_auto_type_info = 1

let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0

let g:go_highlight_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_format_strings = 1

au FileType go nmap <Leader>s <Plug>(go-def-split)
au FileType go nmap <Leader>v <Plug>(go-def-vertical)
au FileType go nmap <Leader>in <Plug>(go-info)
au FileType go nmap <Leader>ii <Plug>(go-implements)

au FileType go nmap <Leader>r  <Plug>(go-run)
au FileType go nmap <Leader>b  <Plug>(go-build)
au FileType go nmap <Leader>g  <Plug>(go-gbbuild)
au FileType go nmap <Leader>t  <Plug>(go-test-compile)
au FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
au FileType go nmap <Leader>d <Plug>(go-doc)
au FileType go nmap <Leader>f :GoImports<CR>
au FileType go nmap <Leader>l :GoLint<CR>


" ==================== Vim-flake8 ====================
autocmd BufRead,BufNewFile *.py let python_highlight_all=1
autocmd BufRead,BufNewFile *.py let python_highlight_space_errors=0

" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
