cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Q! q!
cnoreabbrev Bd bd
cnoreabbrev Wq wq
cnoreabbrev Wq! wq!
cnoreabbrev Wqa! wqa!
cnoreabbrev Tabclose tabclose
cnoreabbrev Tabnew tabopen

map <C-n> :Explore <CR>
map <C-p> :GFiles <CR>
map <C-g> :execute "!" "$HOME/dotfiles/open_in_github.sh" bufname("%") line(".") <CR>
map <leader>dd <Plug>(coc-definition)
map <leader>rr <Plug>(coc-references)
map <leader>tt :tabnew <CR>
map <leader>tc :tabclose <CR>
map <leader>ff :ALEFix <CR>

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
