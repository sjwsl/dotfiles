call plug#begin('~/.vim/plugged')
Plug 'easymotion/vim-easymotion'
Plug 'honza/vim-snippets'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'junegunn/gv.vim'
Plug 'junegunn/vim-easy-align'
Plug 'mhinz/vim-signify'
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdcommenter'
Plug 'takac/vim-hardtime'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'wakatime/vim-wakatime'
Plug 'Yggdroot/LeaderF'
let g:coc_global_extensions = ['coc-tabnine', 'coc-snippets', 'coc-json', 'coc-clang-format-style-options', 'coc-python']
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
let &t_SI = "\<esc>[6 q"
let &t_SR = "\<esc>[6 q"
let &t_EI = "\<esc>[2 q"

" common
language en_US.UTF-8
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
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set backspace=2

" search
set incsearch
set ignorecase
set smartcase
set hlsearch

" plugin configuration
for f in split(glob('~/.vim/*.vim'), '\n')
    exe 'source' f
endfor
