filetype plugin indent on
syntax on
set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


autocmd FileType * set formatoptions-=cro
set number
set hidden
set backspace=indent,eol,start
set autoindent
set encoding=utf8
set history=500
set hlsearch
set incsearch
set noerrorbells
set noswapfile
set nowritebackup
set paste
set ruler
set scrolloff=8
set showcmd
set smartindent
set ttyfast
set updatetime=500
set wildmenu
set shiftwidth=2
set tw=2
set showtabline=0
set softtabstop=2
set tabstop=2
set textwidth=100
set expandtab
set shiftround

let mapleader = " "

nnoremap <leader>fs :w<cr>
nnoremap <C-n> :NERDTreeToggle<cr>
nnoremap <leader>q :q!<cr>
nnoremap <leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>
nnoremap <leader>o :q<cr>
nnoremap <leader>n :split<cr>
nnoremap <leader>m :vsplit<cr>
vnoremap J :m >+1<CR>gv=gv<cr>
vnoremap K :m <-2<CR>gv=gv<cr>

vnoremap < <gv
vnoremap > >gv

vnoremap <leader>y [["+y]]
nnoremap <leader>y [["+Y]]

nnoremap <esc> :noh<cr><esc>
inoremap <esc> :noh<cr><esc>

let g:loaded_matchparen=1
