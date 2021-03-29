" coc
nmap <silent> g[ <Plug>(coc-diagnostic-prev)
nmap <silent> g] <Plug>(coc-diagnostic-next)
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

" toggle
noremap tt :TagbarToggle<CR>
noremap td :NERDTreeToggle<CR>

" Leaderf
nnoremap <leader>s :<C-U><C-R>=printf("Leaderf rg -F -e %s", expand("<cword>"))<CR><CR>
xnoremap <leader>s :<C-U><C-R>=printf("Leaderf rg -F -e %s", leaderf#Rg#visual())<CR><CR>
noremap <leader>p :Leaderf rg -F<CR>
noremap <leader>r :<C-U><C-R>=printf("Leaderf gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>d :<C-U><C-R>=printf("Leaderf gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
