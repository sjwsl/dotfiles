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
nnoremap <C-O> <C-O>zz
nnoremap <C-I> <C-I>zz
nnoremap <C-W>\| :vsplit<CR>
nnoremap <C-W>_ :split<CR>

nnoremap <tab> @=(foldlevel('.')?'za':"\<tab>")<CR>

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
xnoremap ga <Plug>(EasyAlign)
nnoremap ga <Plug>(EasyAlign)

" easymotion
nnoremap s <Plug>(easymotion-bd-f)
nnoremap <Leader>w <Plug>(easymotion-bd-w)

" coc
nnoremap [g <Plug>(coc-diagnostic-prev)
nnoremap ]g <Plug>(coc-diagnostic-next)
nnoremap <C-W>gd :vsp<CR><Plug>(coc-definition)
nnoremap gd <Plug>(coc-definition)
nnoremap gr <Plug>(coc-references)
nnoremap rn <Plug>(coc-rename)

" Use K to show documentation in preview window.
nnoremap K :call <SID>show_documentation()<CR>
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
