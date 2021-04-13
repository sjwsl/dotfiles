let mapleader=" "
noremap , <C-W>
inoremap jk <ESC>
nnoremap <leader>h :nohlsearch<CR>

" navigate in completion box
cnoremap <up> <C-P>
cnoremap <down> <C-N>

" coc
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> ,gd :vsp<CR><Plug>(coc-definition)
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
noremap tt :TagbarToggle<CR>

" NERDTree
noremap td :NERDTreeToggle<CR>

" Leaderf
nnoremap <leader>s :<C-U><C-R>=printf("Leaderf rg -F -e %s", expand("<cword>"))<CR><CR>
xnoremap <leader>s :<C-U><C-R>=printf("Leaderf rg -F -e %s", leaderf#Rg#visual())<CR><CR>
noremap <leader>p :Leaderf rg -F<CR>
noremap <leader>r :<C-U><C-R>=printf("Leaderf gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>R :<C-U><C-R>=printf("Leaderf gtags -s %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>d :<C-U><C-R>=printf("Leaderf gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>g :Leaderf gtags<CR>
noremap <leader>m :Leaderf mru<CR>

" movement
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
