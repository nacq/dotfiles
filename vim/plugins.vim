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

" async linter checker (syntastic replace)
Plug 'dense-analysis/ale'

" git stuff
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" syntax higlighters
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'peitalin/vim-jsx-typescript', { 'for': 'typescript' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'styled-components/vim-styled-components', { 'for': ['jsx', 'tsx'], 'branch': 'main' }

" colorscheme
Plug 'nicolasacquaviva/vim-yin-yang'

call plug#end()
" ---------------------------------------------------------------------------------

colorscheme yin

" ---------------------------------------------------------------------------------
" ALE settings
let g:ale_linters={
  \'javascript': ['prettier', 'eslint'],
  \'typescript': ['prettier', 'eslint']
\}
let g:ale_fixers = {
  \'javascript': ['prettier', 'eslint'],
  \'typescript': ['prettier', 'eslint'],
\}
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_set_highlights = 0 "Set this in your vimrc file to disabling highlighting
" ---------------------------------------------------------------------------------

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
" ---------------------------------------------------------------------------------

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
" https://superuser.com/questions/1531456/how-to-reveal-a-file-in-vim-netrw-treeview
command! ExploreFind let @/=expand("%:t") | execute 'Explore' expand("%:h") | normal n

let g:netrw_banner = 0
let g:netrw_liststyle = 3
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" vim-snipper
let g:snippets_file = $HOME . "/dotfiles/vim/snippets.json"
" ---------------------------------------------------------------------------------
