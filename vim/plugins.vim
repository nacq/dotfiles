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
Plug 'nicolasacquaviva/vim-yin-yang'

" lsp
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'

call plug#end()
" ---------------------------------------------------------------------------------

colorscheme yin

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
function AddLog()
  let lang_log = {
    \ 'go': 'fmt.Println',
    \ 'typescript': 'console.log',
    \ 'typescriptreact': 'console.log',
    \ 'javascript': 'console.log',
    \ 'javascriptreact': 'console.log',
  \ }

  if !has_key(lang_log, &filetype)
    echo "Error: No log function defined for filetype " . &filetype
    return
  endif

  let lang_quote = {
    \ 'go': '"',
    \ 'typescript': "'",
    \ 'typescriptreact': "'",
    \ 'javascript': "'",
    \ 'javascriptreact': "'",
  \ }
  let log_prefix = '>>>'
  let quote_char = "'"

  if has_key(lang_quote, &filetype)
    let quote_char = lang_quote[&filetype]
  endif

  " put visual selection into the register 'x'
  '<,'>normal! gv"xy
  " read register 'x'
  let selection = getreg("x")
  let cursor_pos = getpos(".")[1]

  call appendbufline(
    \ bufname(),
    \ cursor_pos,
    \ lang_log[&filetype] . "(" . quote_char . log_prefix . " " . selection . quote_char . ", " . selection . ")"
  \ )

  normal j
  normal ==
endfunction
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" vim-snipper
let g:snippets_file = $HOME . "/dotfiles/vim/snippets.json"
" ---------------------------------------------------------------------------------
