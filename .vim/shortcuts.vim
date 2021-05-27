let mapleader=" "
inoremap jk <ESC>
inoremap kj <ESC>
inoremap <ESC> <NOP>
nmap Q <NOP>
nmap <left> <NOP>
nmap <right> <NOP>
nnoremap <leader>h <silent> :nohlsearch<CR>
nnoremap cp "+y
xnoremap cp "+y
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
nnoremap <C-O> <C-O>zz
nnoremap <C-I> <C-I>zz
nnoremap <C-W>\| <silent> :vsplit<CR>
nnoremap <C-W>_ <silent> :split<CR>

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
nnoremap <C-W>z :ZoomToggle<CR>

" navigate in completion box
cnoremap <up> <C-P>
cnoremap <down> <C-N>

" easyalign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" easymotion
nmap s <Plug>(easymotion-bd-f)
nmap <Leader>w <Plug>(easymotion-bd-w)

" coc
nmap [g <Plug>(coc-diagnostic-prev)
nmap ]g <Plug>(coc-diagnostic-next)
nmap <C-W>gd :vsp<CR><Plug>(coc-definition)
nmap gd <Plug>(coc-definition)
nmap gr <Plug>(coc-references)
nmap rn <Plug>(coc-rename)

" Use K to show documentation in preview window.
nmap K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" format
nnoremap <leader>l :Autoformat<CR>

" Netrw
noremap <leader>d :edit .<CR>

" Leaderf
nnoremap <leader>s :<C-U><C-R>=printf("Leaderf rg -F -e %s", expand("<cword>"))<CR><CR>
xnoremap <leader>s :<C-U><C-R>=printf("Leaderf rg -F -e %s", leaderf#Rg#visual())<CR><CR>
noremap <leader>p :Leaderf rg -F<CR>
noremap <leader>r :<C-U><C-R>=printf("Leaderf gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>R :<C-U><C-R>=printf("Leaderf gtags -s %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>c :<C-U><C-R>=printf("Leaderf gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>g :Leaderf gtags<CR>
noremap <leader>m :Leaderf mru<CR>
noremap <leader>f :Leaderf file<CR>

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
