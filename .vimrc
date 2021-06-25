" common
language en_US.UTF-8
filetype plugin indent on
autocmd FileType latex,tex,md,markdown setlocal spell | setlocal spelllang=en_us,cjk
let mapleader=" "
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
set splitright
set timeoutlen=1000
set ttimeoutlen=5
set updatetime=100
set wildmenu

call plug#begin('~/.vim/plugged')

Plug 'Chiel92/vim-autoformat'
nnoremap <silent> <leader>l :Autoformat<CR>

Plug 'Yggdroot/LeaderF'
nnoremap <silent> <leader>s :<C-U><C-R>=printf("Leaderf rg -F -e %s", expand("<cword>"))<CR><CR>
xnoremap <silent> <leader>s :<C-U><C-R>=printf("Leaderf rg -F -e %s", leaderf#Rg#visual())<CR><CR>
noremap <silent> <leader>p :Leaderf rg -F<CR>
noremap <silent> <leader>r :<C-U><C-R>=printf("Leaderf gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <silent> <leader>R :<C-U><C-R>=printf("Leaderf gtags -s %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <silent> <leader>d :<C-U><C-R>=printf("Leaderf gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <silent> <leader>g :Leaderf gtags<CR>
noremap <silent> <leader>m :Leaderf mru<CR>
noremap <silent> <leader>f :Leaderf file<CR>
noremap <silent> <leader>b :Leaderf buffer<CR>

Plug 'easymotion/vim-easymotion'
nmap <silent> s <Plug>(easymotion-bd-f)
nmap <silent> <Leader>w <Plug>(easymotion-bd-w)
let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
let g:EasyMotion_do_mapping = 0

Plug 'jackguo380/vim-lsp-cxx-highlight'
let g:lsp_cxx_hl_use_text_props = 1

" for gruvbox
hi! link Comment GruvboxGray
hi! link Function GruvboxBlue
hi! link Macro GruvboxOrange
hi! link Constant GruvboxPurple
hi! link Number Constant
hi! link Boolean Constant
hi! link String Constant

hi! link LspCxxHlGroupNamespace GruvboxOrange
hi! link LspCxxHlGroupEnumConstant Constant
hi! link LspCxxHlGroupMemberVariable GruvboxFg4

Plug 'junegunn/vim-easy-align'
xmap <silent> <leader>a <Plug>(EasyAlign)
nmap <silent> <leader>a <Plug>(EasyAlign)

Plug 'lervag/vimtex'
let g:tex_flavor='latex'
let g:vimtex_texcount_custom_arg=' -ch -total'
let g:vimtex_quickfix_open_on_warning=0

Plug 'mhinz/vim-signify'
let g:signify_sign_show_count = 1

Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = ['coc-clangd', 'coc-vimtex', 'coc-cmake', 'coc-tabnine', 'coc-snippets', 'coc-json', 'coc-clang-format-style-options', 'coc-python']
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> <C-W>gd :vsp<CR><Plug>(coc-definition)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> rn <Plug>(coc-rename)

" Use K to show documentation in preview window.
nmap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

Plug 'scrooloose/nerdcommenter'
" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

Plug 'vim-airline/vim-airline'
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#scrollbar#enabled = 0

Plug 'octol/vim-cpp-enhanced-highlight'
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'morhetz/gruvbox'
Plug 'honza/vim-snippets'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'wakatime/vim-wakatime'

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
set backspace=indent,eol,start
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" search
set hlsearch
set ignorecase
set incsearch
set smartcase
nnoremap <silent><expr> <Leader>h (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"

" netrw
noremap <silent> <leader>e :edit .<CR>
let g:netrw_banner = 0
let g:netrw_liststyle = 3

" imap
inoremap <ESC> <NOP>
inoremap <down> <NOP>
inoremap <left> <NOP>
inoremap <right> <NOP>
inoremap <up> <NOP>
inoremap jk <ESC>
inoremap kj <ESC>
inoremap {; {<CR>};<ESC>O
inoremap {, {<CR>},<ESC>O
inoremap {{ {<CR>}<ESC>O

" nmap
nnoremap <down> <NOP>
nnoremap <left> <NOP>
nnoremap <right> <NOP>
nnoremap <up> <NOP>
nnoremap Q <NOP>
nnoremap # #zz
nnoremap * *zz
nnoremap <C-I> <C-I>zz
nnoremap <C-O> <C-O>zz
nnoremap <silent> <C-W>\| :vsplit<CR>
nnoremap <silent> <C-W>_ :split<CR>
nnoremap cp "+y
nnoremap g# g#zz
nnoremap g* g*zz
nnoremap n nzz
nnoremap N Nzz

" Zoom / Restore window.
function! s:ZoomToggle() abort
  if exists('t:zoomed') && t:zoomed
    execute t:zoom_winrestcmd
    let t:zoomed = 0
  else
    let t:zoom_winrestcmd = winrestcmd()
    resize
    vertical resize
    let t:zoomed = 1
  endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <C-W>z :ZoomToggle<CR>

" xmap
xnoremap cp "+y
