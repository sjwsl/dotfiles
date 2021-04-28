call plug#begin('~/.vim/plugged')
Plug 'honza/vim-snippets'
Plug 'takac/vim-hardtime'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'Krasjet/auto.pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'easymotion/vim-easymotion'
Plug 'lervag/vimtex'

" theme
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'

" git
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'junegunn/gv.vim'

" c++
Plug 'majutsushi/tagbar'
Plug 'jackguo380/vim-lsp-cxx-highlight'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = ['coc-tabnine', 'coc-snippets', 'coc-vimtex', 'coc-json', 'coc-cmake', 'coc-pyright', 'coc-clang-format-style-options']
call plug#end()


" theme
set background=dark
colorscheme gruvbox
set termguicolors
hi Normal guibg=none
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

" change cursor shape in different modes
let &t_SI = "\<esc>[6 q"
let &t_SR = "\<esc>[6 q"
let &t_EI = "\<esc>[2 q"

" common
filetype plugin indent on
autocmd FileType latex,tex,md,markdown setlocal spell | setlocal spelllang=en_us,cjk
set noswapfile 
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

" indent
set autoindent
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expantab
set backspace=2

" search
set incsearch
set ignorecase
set smartcase
set hlsearch

for f in split(glob('~/.dotfiles/.vim/*.vim'), '\n')
    exe 'source' f
endfor
