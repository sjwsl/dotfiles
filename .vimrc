call plug#begin('~/.vim/plugged')
Plug 'Chiel92/vim-autoformat'
Plug 'Yggdroot/LeaderF'
Plug 'easymotion/vim-easymotion'
Plug 'honza/vim-snippets'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'junegunn/vim-easy-align'
Plug 'lervag/vimtex'
Plug 'mhinz/vim-signify'
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdcommenter'
Plug 'takac/vim-hardtime'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'wakatime/vim-wakatime'
let g:coc_global_extensions = ['coc-vimtex', 'coc-cmake', 'coc-tabnine', 'coc-snippets', 'coc-json', 'coc-clang-format-style-options', 'coc-python']
call plug#end()

" theme
set background=dark
colorscheme gruvbox
set termguicolors
hi Normal guibg=none
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

" cursor shapes
let &t_EI = "\<esc>[2 q"
let &t_SI = "\<esc>[6 q"
let &t_SR = "\<esc>[6 q"

" common
language en_US.UTF-8
filetype plugin indent on
autocmd FileType latex,tex,md,markdown setlocal spell | setlocal spelllang=en_us,cjk
set cmdheight=2
set cursorline
set encoding=utf-8
set hidden
set laststatus=2
set lazyredraw
set maxmempattern=2000000
set mouse=a
set nobackup
set noerrorbells
set noswapfile 
set nowritebackup
set number
set pumheight=10
set relativenumber
set shortmess+=c
set showmatch
set signcolumn=number
set splitright
set timeoutlen=1000
set ttimeoutlen=5
set updatetime=100
set wildmenu

" fold
augroup fold
au!
au BufReadPre * setlocal foldmethod=indent
au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview
augroup end

" indent
set autoindent
set backspace=2
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" search
set hlsearch
set ignorecase
set incsearch
set smartcase

" plugin configuration
for f in split(glob('~/.vim/*.vim'), '\n')
    exe 'source' f
endfor
