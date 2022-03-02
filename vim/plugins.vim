" plugins specific configs

" ---------------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')
" utils
Plug 'mattn/emmet-vim', { 'for': ['html', 'jsx', 'javascript.jsx', 'tsx', 'typescript.tsx', 'typescriptreact']}
Plug 'scrooloose/nerdcommenter'
" Plug 'junegunn/fzf', { 'do': { ->fzf#install() } }
" changed the post install hook bc it suddenly stopped working
" https://github.com/junegunn/fzf.vim/issues/1008
Plug 'junegunn/fzf', { 'dir': '~/.vim/plugged/fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
" Plug 'fatih/vim-go', { 'for': 'go' }
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

" lsp
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'

call plug#end()
" ---------------------------------------------------------------------------------

colorscheme betterdefault

function JsonBeautify()
  %!jq .
endfunction

command JsonBeautify :call JsonBeautify()

" ---------------------------------------------------------------------------------
" fzf settings
let g:fzf_layout = { 'down': '~50%' }
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
