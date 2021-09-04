" plugins specific configs

" ---------------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')
" utils
Plug 'mattn/emmet-vim', { 'for': ['html', 'jsx', 'javascript.jsx', 'tsx', 'typescript.tsx']}
Plug 'scrooloose/nerdcommenter'
" Plug 'junegunn/fzf', { 'do': { ->fzf#install() } }
" changed the post install hook bc it suddenly stopped working
" https://github.com/junegunn/fzf.vim/issues/1008
Plug 'junegunn/fzf', { 'dir': '~/.vim/plugged/fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'nicolasacquaviva/vim-snipper'
Plug 'nicolasacquaviva/vim-open-repo'

" git stuff
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" syntax higlighters
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'peitalin/vim-jsx-typescript', { 'for': ['typescript.tsx', 'javascript.jsx'] }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript.jsx' }
Plug 'styled-components/vim-styled-components', { 'for': ['javascript.jsx', 'typescript.tsx'], 'branch': 'main' }

" colorscheme
Plug 'nicolasacquaviva/better-default'

call plug#end()
" ---------------------------------------------------------------------------------

colorscheme betterdefault

" ---------------------------------------------------------------------------------
" Coc settings (https://github.com/neoclide/coc.nvim#example-vim-configuration)
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

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" if the definition is in the same file jump to it
" if it is in a different file, open it in a split
" a:000 all args as a list
" a:0 number of extra args
" a:1 filename
function! SplitIfNotOpen(...)
  let fname = a:1
  let bufnum=bufnr(expand(fname))
  let winnum=bufwinnr(bufnum)
  let isvert=winwidth(0) < winheight(0)

  if winnum != -1
    " Jump to existing split
    exe winnum . "wincmd w"
  else
    " Make new split as usual
    if isvert
      exe "split " . fname
    else
      exe "vsplit " . fname
    endif
  endif
endfunction

command! -nargs=+ CocSplitIfNotOpen :call SplitIfNotOpen(<f-args>)

let g:coc_disable_startup_warning = 1
" ---------------------------------------------------------------------------------
" fzf settings
let g:fzf_layout = { 'down': '~30%' }
let g:fzf_preview_window = 'right:60%'
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" NERDCommenter settings
let g:NERDSpaceDelims=1       " add space after comments char
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" gitgutter
let g:gitgutter_async=1
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" vim-go
let g:go_gopls_enabled = 0
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3

function RevealInNetrw()
  let current_filename = expand("%:t")
  " set the 'last search' register to the current file name
  let @/ = current_filename
  let current_dir = expand("%:h")
  execute 'Explore' current_dir
  " go to the 'searched' term
  normal n
endfunction
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" vim-snipper
let g:snippets_file = $HOME . "/dotfiles/vim/snippets.json"
" ---------------------------------------------------------------------------------
