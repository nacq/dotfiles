" plugins specific configs

" ---------------------------------------------------------------------------------
" vim-plug
call plug#begin('~/.vim/plugged')
" utils
Plug 'mattn/emmet-vim'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdcommenter'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'ycm-core/YouCompleteMe'

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

" ---------------------------------------------------------------------------------A
" YCM settings
let g:ycm_autoclose_preview_window_after_completion = 1
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
