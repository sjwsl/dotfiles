let mapleader=" "
inoremap jk <ESC>
inoremap kj <ESC>
inoremap <ESC> <NOP>
nmap Q <NOP>
nnoremap <left> <NOP>
nnoremap <right> <NOP>
nnoremap <up> <NOP>
nnoremap <down> <NOP>
inoremap <left> <NOP>
inoremap <right> <NOP>
inoremap <up> <NOP>
inoremap <down> <NOP>
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
nnoremap <silent> <C-W>\| :vsplit<CR>
nnoremap <silent> <C-W>_ :split<CR>

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

" easyalign
xmap <silent> <leader>a <Plug>(EasyAlign)
nmap <silent> <leader>a <Plug>(EasyAlign)

" easymotion
nmap <silent> s <Plug>(easymotion-bd-f)
nmap <silent> <Leader>w <Plug>(easymotion-bd-w)

" coc
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

nnoremap <silent> <leader>l :Autoformat<CR>
noremap <silent> <leader>e :edit .<CR>
nnoremap <silent> <leader>h :nohlsearch<CR>

" Leaderf
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

inoremap {; {<CR>};<ESC>O
inoremap {, {<CR>},<ESC>O
inoremap {{ {<CR>}<ESC>O
