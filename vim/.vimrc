nnoremap <SPACE> <Nop>
let mapleader=" "
let g:os_current="Linux"

call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'rhysd/vim-clang-format'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'sainnhe/everforest'
Plug 'eihigh/vim-aomi-grayscale'

Plug 'SirVer/ultisnips'
Plug 'lervag/vimtex'

call plug#end()

if has('termguicolors')
      set termguicolors
    endif
set background=dark

"let g:everforest_background = 'hard'
"let g:everforest_better_performance = 1
"
"colorscheme everforest
"let g:lightline = {'colorscheme' : 'everforest'}

"colorscheme sunbather -- dark + red
colorscheme aomi-grayscale

syntax on
set number
set noswapfile
set mouse=a
set termguicolors
set tabstop=4
set shiftwidth=4
set expandtab
set signcolumn=yes

set hlsearch
set splitbelow
set splitright

filetype on
filetype plugin on
filetype indent on

command! -bang -range=% -complete=file -nargs=* W <line1>,<line2>write<bang> <args>
command! -bang Q quit<bang>

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

"mappings 
map <C-t> :NERDTreeToggle<CR>
map <leader>r :NERDTreeFind<cr>

nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <F4> :%s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/i

let NERDTreeShowHidden=1

"lsp global setup
set encoding=utf-8
set nobackup
set nowritebackup
set updatetime=300
"set signcolumn=yes

autocmd FileType cpp inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
autocmd FileType cpp inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

nmap <leader>rn <Plug>(coc-rename)
nmap <leader>qf  <Plug>(coc-fix-current)

let g:clang_format#detect_style_file=1
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val, "lnum": 1 }'))
  copen
  cc
endfunction

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true, 'yoffset': 1.0 } }
nnoremap <C-p> :Files<CR>

""" latex section 
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/snippets']
