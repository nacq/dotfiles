set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'dracula/vim'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'isRuslan/vim-es6'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'kien/ctrlp.vim'
" nunjucks template engine highlighting
Plugin 'lepture/vim-jinja'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'mattn/emmet-vim'
Plugin 'mileszs/ack.vim'
Plugin 'mxw/vim-jsx'
Plugin 'othree/html5.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
" git shiet
Plugin 'tpope/vim-fugitive'
" session management inside vim
Plugin 'tpope/vim-obsession'
Plugin 'trevordmiller/nova-vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-syntastic/syntastic'
Plugin 'wavded/vim-stylus'
Plugin 'elixir-editors/vim-elixir'
call vundle#end()

" ---------------------------------------------------------------------------------
" if double spaces, hightlight it
highlight link DoubleSpace Error
match DoubleSpace /　/
" ---------------------------------------------------------------------------------

set nocompatible
" ---------------------------------------------------------------------------------
" new splits positions
set splitbelow
set splitright
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" remember undo after quitting
set hidden
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" syntax highlighting
syntax on
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" filetype detection and applies indentation config
filetype plugin indent on
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" set max characters per line and draw the visual line
set colorcolumn=120
set textwidth=120
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" highlight entire line on cursor position
set cursorline
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" use number of spaces from config when hit tab and C-> C-<
set expandtab
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" searching stuff
set matchtime=1                 " 1/10 of a second
set hlsearch                    " highlight search matches
set incsearch                   " show matches while writting the term to search
set showmatch                   " idk
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" show staus line on all windows
set laststatus=2
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" don't break lines despite window size
set nowrap
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" show line number in front of each line and show position of cursor separated by a
" comma
set number relativenumber
set ruler
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" when hit tab it inserts blanks according 'shiftwidth'
set smarttab
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" use the visual bell instead of beeping
set visualbell
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" status line content
set statusline+=%F
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" command line
set wildmenu                        " show possible matches when hitting tab
set showcmd                         " idk
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" backspace behavior
set backspace=indent,eol,start
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" no comments needed =D
set showmode
set noswapfile
set background=dark
colorscheme dracula
" ---------------------------------------------------------------------------------

set t_Co=256
set path+=**
" set autochdir

" ---------------------------------------------------------------------------------
" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_aggregate_errors = 1                    " errors 2gether
let g:syntastic_check_on_open = 0                       " dont check on open
let g:syntastic_check_on_wq = 0                         " dont check on wq
let g:syntastic_check_on_w = 0                          " dont check on w
let g:syntastic_check_on_q = 0                          " dont check on q
let g:syntastic_echo_current_error = 1
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_html_checkers = ['']
" let g:syntastic_javascript_standard_generic = 1
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" CtrlP settings
let g:ctrlp_max_files = 20000
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" Airline settings
let g:airline_theme='dracula'
let g:airline#extensions#tabline#enabled = 1            " show buffer list on airline
let g:airline#extensions#tabline#buffer_nr_show = 1     " show buffer number on airline
let g:airline_section_z = airline#section#create(['%{ObsessionStatus(''$'', '''')}'])
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" NERDTree settings
let g:NERDTreeDirArrowExpandable = '→'
let g:NERDTreeDirArrowCollapsible = '↳'
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" NERDCommenter settings
let g:NERDSpaceDelims=1       "add space after comments char
" ---------------------------------------------------------------------------------

hi Search cterm=NONE ctermfg=black ctermbg=blue
let g:solarized_termcolors=256

let JSHintUpdateWriteOnly=1

" ---------------------------------------------------------------------------------
" keybinds
map <C-n> :call NERDTreeOpen() <CR>
" map <C-m> :call RevealFileInNERDTree() <CR>
map <C-S-Left> :vertical resize -1 <CR>
map <C-S-Right> :vertical resize +1 <CR>
map <C-S-Down> :resize -1 <CR>
map <C-S-Up> :resize +1 <CR>

" position cursor inbetween brackets
imap {<Tab> {}<Esc>i
imap [<Tab> []<Esc>i
imap (<Tab> ()<Esc>i
imap '<Tab> ''<Esc>i

" no arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

nnoremap Q <nop>

" clear search
nnoremap <C-L> :nohlsearch<CR><C-L>
" ---------------------------------------------------------------------------------

" ugly hack to avoid nerd tree to open filling the entire screen :S
function NERDTreeOpen()
        :NERDTreeToggle
        :vertical resize -9999
        :vertical resize +30
endfunction

" open nerd tree on the current file location
function RevealFileInNERDTree()
        echo @%
        :NERDTreeFind
endfunction

function DeleteAllBuffers()
        :bufdo bd
        :call NERDTreeOpen()
endfunction

" ---------------------------------------------------------------------------------
" commands
command! ObsessionStart :Obsession ~/.vim/Session.vim   " start session on specific dir
command! ObsessionRead :source ~/.vim/Session.vim       " read saved sesh
command Bda :call DeleteAllBuffers()                    " delete all open buffers (things get messy sometimes)

autocmd BufWritePre * %s/\s\+$//e                       " remove trailing spaces on pre write
autocmd BufNewFile,BufRead *.ts set filetype=typescript
autocmd BufNewFile,BufRead *.styl,*.scss set filetype=css
autocmd BufNewFile,BufRead *.html.erb set filetype=html

autocmd FileType javascript noremap <buffer> <c-f> :call JsBeautify()<cr>
autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" tabs
au FileType javascript setlocal tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
au FileType json setlocal tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
au FileType html setlocal tabstop=2 expandtab shiftwidth=4 softtabstop=4
au FileType css setlocal tabstop=2 expandtab shiftwidth=4 softtabstop=4
au FileType ruby setlocal shiftwidth=2 smarttab
" ---------------------------------------------------------------------------------

