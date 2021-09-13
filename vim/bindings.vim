cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qa qa
cnoreabbrev Qa! qa!
cnoreabbrev Q! q!
cnoreabbrev Bd bd
cnoreabbrev Wq wq
cnoreabbrev Wq! wq!
cnoreabbrev Wqa wqa
cnoreabbrev Wqa! wqa!
cnoreabbrev Tabclose tabclose
cnoreabbrev Tabnew tabopen
cnoreabbrev Sb sb
cnoreabbrev ag Ag
" dont like the new mappings :@
cnoreabbrev Gblame Git blame
cnoreabbrev Gst Git

map <C-n> :Explore <CR>
map <C-k> :call RevealInNetrw() <CR>
map <C-p> :GFiles <CR>
map <C-g> :OpenRepo <CR>
map <leader>dd <Plug>(coc-definition)
map <leader>rr <Plug>(coc-references)
map <leader>tt :tabnew <CR>
map <leader>tc :tabclose <CR>
map <leader>ff :CocFix <CR>
map <leader>ss :sort <CR>

" position cursor inbetween brackets
imap {<Tab> {}<Esc>i<Enter><Esc>O
imap [<Tab> []<Esc>i
imap (<Tab> ()<Esc>i
imap '<Tab> ''<Esc>i
imap `<Tab> ``<Esc>i
imap "<Tab> ""<Esc>i

" no arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap Q <nop>
" show the number of occurrences for the word under the cursor
nnoremap * *<C-O>:%s///gn<CR>
" clear search
nnoremap <C-L> :nohlsearch<CR><C-L>
