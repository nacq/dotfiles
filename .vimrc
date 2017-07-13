set nocompatible

filetype off

syntax on                       "syntax highlighting

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
" Plugins
Plugin 'mileszs/ack.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'mattn/emmet-vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-syntastic/syntastic'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'mxw/vim-jsx'
Plugin 'isRuslan/vim-es6'
Plugin 'johngrib/vim-game-code-break'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'
call vundle#end()

filetype plugin indent on     "filetype detection

" set autochdir
set background=dark
set backspace=indent,eol,start
set colorcolumn=120
set cursorline
set expandtab
set hlsearch
set laststatus=2
set noswapfile
set path+=**
set ruler
set showcmd
set showmatch
set showmode
set smarttab
set statusline+=%F
" set t_Co=256
set textwidth=120
set visualbell
set wildmenu
set nowrap

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

colorscheme dracula

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1 
let g:syntastic_aggregate_errors = 1                    " errors 2gether
let g:syntastic_check_on_open = 0                       " dont check on open
let g:syntastic_check_on_wq = 0                         " dont check on wq
let g:syntastic_check_on_w = 0                          " dont check on w
let g:syntastic_check_on_q = 0                          " dont check on q
let g:syntastic_echo_current_error = 1
let g:syntastic_javascript_checkers = ['jshint']
" let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_html_checkers = ['']
" let g:syntastic_javascript_standard_generic = 1

let g:airline_theme='alduin'
      
" NERDCommenter
let g:NERDSpaceDelims=1       "add space after comments char
let JSHintUpdateWriteOnly=1

" keybinds
map <C-n> :NERDTreeToggle <CR>
map <C-S-Left> :vertical resize -1 <CR>
map <C-S-Right> :vertical resize +1 <CR>
map <C-S-Down> :resize -1 <CR>
map <C-S-Up> :resize +1 <CR>

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap Q <nop>

autocmd FileType javascript noremap <buffer> <c-f> :call JsBeautify()<cr>
autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

" tabs
au FileType javascript setlocal tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
au FileType json setlocal tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
au FileType html setlocal tabstop=2 expandtab shiftwidth=4 softtabstop=2
au FileType css setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2
