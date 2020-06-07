" plugins specific configs

" ---------------------------------------------------------------------------------
" vim-plug
call plug#begin('~/.vim/plugged')
" utils
Plug 'mattn/emmet-vim'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf', { 'do': { ->fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" async linter checker (syntastic replace)
Plug 'dense-analysis/ale'

" git stuff
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" syntax higlighters
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" colorscheme
Plug 'liuchengxu/space-vim-theme'

call plug#end()
" ---------------------------------------------------------------------------------

colorscheme space_vim_theme

" ---------------------------------------------------------------------------------
" ALE settings
let g:ale_linters={
      \'javascript': ['prettier', 'eslint'],
      \'typescript': ['prettier', 'eslint']
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
" NERDTree settings
let g:NERDTreeDirArrowExpandable = '→'
let g:NERDTreeDirArrowCollapsible = '↳'
let g:NERDTreeWinSize = 55
let g:NERDTreeWinPos = 'right'

" open nerd tree on the current file location
function RevealFileInNERDTree()
  echo @%
  :NERDTreeFind
endfunction
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" NERDCommenter settings
let g:NERDSpaceDelims=1       " add space after comments char
" ---------------------------------------------------------------------------------
