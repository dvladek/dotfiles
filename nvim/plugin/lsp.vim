" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" Remaps
nnoremap <leader>cd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>ci :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>csh :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>cr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>crn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>ch :lua vim.lsp.buf.hover()<CR>

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
