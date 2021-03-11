call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Krasjet/auto.pairs'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'skywind3000/asyncrun.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'ludovicchabant/vim-gutentags'
" Plug 'jackguo380/vim-lsp-cxx-highlight'
" Plug 'luochen1990/rainbow'
" Plug 'codota/tabnine-vim'
call plug#end()


" change cursor shape in diffrent modes
let &t_SI = "\<esc>[6 q"
let &t_SR = "\<esc>[6 q"
let &t_EI = "\<esc>[2 q"

" common
set nocompatible
set number
set relativenumber
set cursorline
set wildmenu
set showmatch
filetype on
filetype plugin on
set timeoutlen=1000
set ttimeoutlen=5
set pumheight=10
set laststatus=2
set clipboard^=unnamed,unnamedplus
let mapleader=" "
noremap , <C-W>
inoremap jk <esc>

" theme
set background=dark
colorscheme palenight
let g:airline_theme = "palenight"
let g:palenight_terminal_italics=1
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

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
nnoremap <leader>h :nohlsearch<CR>

" movement
noremap j gj
noremap k gk
noremap B ^
noremap E $
noremap $ <nop>
noremap ^ <nop>

" tab
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

for f in split(glob('/Users/xutianshu/.dotfiles/vim/*.vim'), '\n')
    exe 'source' f
endfor
