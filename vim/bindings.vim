cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qa qa
cnoreabbrev Qa! qa!
cnoreabbrev Q! q!
cnoreabbrev B b
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
map <C-f> :Files <CR>
map <C-g> :OpenRepo <CR>
map <leader>tt :tabnew <CR>
map <leader>tc :tabclose <CR>
map <leader>ss :sort <CR>
map <leader>ll :call AddLog() <CR>

" This is only availale in the quickfix window, owing to the filetype
" restriction on the autocmd (see below).
function! <SID>OpenQuickfix(new_split_cmd)
  " 1. the current line is the result idx as we are in the quickfix
  let l:qf_idx = line('.')
  " 2. jump to the previous window
  wincmd p
  " 3. switch to a new split (the new_split_cmd will be 'vnew' or 'split')
  execute a:new_split_cmd
  " 4. open the 'current' item of the quickfix list in the newly created buffer
  "    (the current means, the one focused before switching to the new buffer)
  execute l:qf_idx . 'cc'
endfunction

autocmd FileType qf nnoremap <buffer> <C-v> :call <SID>OpenQuickfix("vnew")<CR>
autocmd FileType qf nnoremap <buffer> <C-x> :call <SID>OpenQuickfix("split")<CR>

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
