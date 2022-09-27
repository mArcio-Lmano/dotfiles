:set number
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set mouse=a
:set cursorcolumn 
hi CursorColumn ctermbg=darkgray

call plug#begin()
	Plug 'https://github.com/vim-airline/vim-airline'
	Plug 'https://github.com/preservim/nerdtree'
	Plug 'https://github.com/preservim/tagbar'       
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()


"NERD Tree
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"
nnoremap <C-t> :NERDTreeToggle<CR>

"TagBar
nmap <F8> :TagbarToggle<CR>

"Air Line
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

"Autocomp
inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"
