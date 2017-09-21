set nocompatible

filetype off

syntax on                       "syntax highlighting

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
" Plugins
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'dracula/vim'
Plugin 'isRuslan/vim-es6'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'kien/ctrlp.vim'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'mattn/emmet-vim'
Plugin 'mileszs/ack.vim'
Plugin 'mxw/vim-jsx'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-syntastic/syntastic'
Plugin 'wavded/vim-stylus'
Plugin 'trevordmiller/nova-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'othree/html5.vim'
Plugin 'lepture/vim-jinja'    "nunjucks template engine highlighting
call vundle#end()

filetype plugin indent on     "filetype detection

set background=dark
set backspace=indent,eol,start
set colorcolumn=120
set cursorline
set expandtab
set hlsearch
set incsearch
set laststatus=2
set noswapfile
set nowrap
set number
set path+=**
set ruler
set showcmd
set showmatch
set showmode
set smarttab
set statusline+=%F
set textwidth=120
set visualbell
set wildmenu
set t_Co=256
" set autochdir

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:solarized_termcolors=256
colorscheme dracula
hi Search cterm=NONE ctermfg=black ctermbg=blue
let g:airline_theme='dracula'
let g:airline#extensions#tabline#enabled = 1            " show buffer list on airline
let g:airline#extensions#tabline#buffer_nr_show = 1     " show buffer number on airline

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_aggregate_errors = 1                    " errors 2gether
let g:syntastic_check_on_open = 0                       " dont check on open
let g:syntastic_check_on_wq = 0                         " dont check on wq
let g:syntastic_check_on_w = 0                          " dont check on w
let g:syntastic_check_on_q = 0                          " dont check on q
let g:syntastic_echo_current_error = 1
" let g:syntastic_javascript_checkers = ['standard']
let g:syntastic_javascript_checkers = ['jshint']
" let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_html_checkers = ['']
" let g:syntastic_javascript_standard_generic = 1

" NERDCommenter
let g:NERDSpaceDelims=1       "add space after comments char
let JSHintUpdateWriteOnly=1

" keybinds
map <C-n> :NERDTreeToggle <CR>
map <C-m> :call RevealFileInNERDTree() <CR>
map <C-S-Left> :vertical resize -1 <CR>
map <C-S-Right> :vertical resize +1 <CR>
map <C-S-Down> :resize -1 <CR>
map <C-S-Up> :resize +1 <CR>

" ctrl spacebar remove trailing spaces
map <C-@> :call RemoveTrailingSpaces() <CR>

function RemoveTrailingSpaces()
        echo 'Removing trailing spaces'
        %s/\s\+$//e
endfunction

function RevealFileInNERDTree()
        echo @%
        :NERDTreeFind
endfunction
" position cursor inbetween brackets
imap {<Tab> {}<Esc>i
imap [<Tab> []<Esc>i
imap (<Tab> ()<Esc>i
imap '<Tab> ''<Esc>i

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap Q <nop>

autocmd BufNewFile,BufRead *.ts set filetype=typescript
autocmd BufNewFile,BufRead *.styl set filetype=css
autocmd FileType javascript noremap <buffer> <c-f> :call JsBeautify()<cr>
autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

" tabs
au FileType javascript setlocal tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
au FileType json setlocal tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
au FileType html setlocal tabstop=2 expandtab shiftwidth=4 softtabstop=4
au FileType css setlocal tabstop=2 expandtab shiftwidth=4 softtabstop=4
