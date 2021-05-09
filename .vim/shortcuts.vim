let mapleader=" "
inoremap jk <ESC>
inoremap kj <ESC>
inoremap <ESC> <NOP>
nnoremap <leader>h :nohlsearch<CR>
nnoremap cp "+y
xnoremap cp "+y
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" navigate in completion box
cnoremap <up> <C-P>
cnoremap <down> <C-N>

" easyalign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" easymotion 
nmap s <Plug>(easymotion-overwin-f)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>w <Plug>(easymotion-bd-w)

" coc
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> <C-W>gd :vsp<CR><Plug>(coc-definition)
nmap <silent> gd <Plug>(coc-definition) 
nmap <silent> gr <Plug>(coc-references)
nmap <silent> rn <Plug>(coc-rename)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" tagbar
noremap <leader>t :TagbarToggle<CR>

" NERDTree
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

