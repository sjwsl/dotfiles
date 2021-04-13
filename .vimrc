call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'Krasjet/auto.pairs'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'majutsushi/tagbar'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'junegunn/gv.vim'
Plug 'morhetz/gruvbox'
Plug 'christoomey/vim-system-copy'
call plug#end()

" theme
set background=dark
colorscheme gruvbox
set termguicolors
hi Normal guibg=none
" let g:palenight_terminal_italics=1
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

let mapleader=" "
noremap , <C-W>
inoremap jk <ESC>

" for navigate in completion box
cnoremap <up> <C-P>
cnoremap <down> <C-N>

" change cursor shape in diffrent modes
let &t_SI = "\<esc>[6 q"
let &t_SR = "\<esc>[6 q"
let &t_EI = "\<esc>[2 q"

" common
set updatetime=100
set mouse=a
set noerrorbells
set number
set relativenumber
set cursorline
set wildmenu
set showmatch
set splitright
set lazyredraw
set timeoutlen=1000
set ttimeoutlen=5
set pumheight=10
set laststatus=2
set maxmempattern=2000000
" set clipboard^=unnamed,unnamedplus
set foldmethod=syntax
set foldlevel=9999
filetype plugin indent on

" indent
set autoindent
set shiftwidth=2
set tabstop=2
set softtabstop=2
set backspace=2

" search
set incsearch
set ignorecase
set smartcase
set hlsearch

for f in split(glob('~/.dotfiles/.vim/*.vim'), '\n')
    exe 'source' f
endfor
