set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" plugin manager
Plugin 'VundleVim/Vundle.vim'
Plugin 'airblade/vim-gitgutter' " show icons for lines added, modified or deleted
Plugin 'pgdouyon/vim-yin-yang'
Plugin 'kien/ctrlp.vim'
Plugin 'mattn/emmet-vim'
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdcommenter' " easy comment/uncomment
Plugin 'scrooloose/nerdtree' " file tree
Plugin 'tpope/vim-fugitive' " git stuff inside vim
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-syntastic/syntastic'
Plugin 'leafgarland/typescript-vim' " ts syntax highlighting
Plugin 'Quramy/tsuquyomi' " ts stuff, completion, files navigation, errors
call vundle#end()

" ---------------------------------------------------------------------------------
" if double spaces, hightlight it
highlight link DoubleSpace Error
match DoubleSpace /　/
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
"  yeeee no more :Wq or :Q Not an editor command
cnoreabbrev W w
cnoreabbrev Q q
" ---------------------------------------------------------------------------------

set nocompatible
" ---------------------------------------------------------------------------------
" new splits positions
set splitbelow
set splitright
set equalalways
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" remember undo after quitting
set hidden
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
"
setlocal nobuflisted
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
colorscheme yin
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
let g:syntastic_javascript_checkers = ['standard']
" let g:syntastic_javascript_standard_exec = 'semistandard'
" let g:syntastic_javascript_checkers = ['jslint']
" let g:syntastic_javascript_checkers = ['jshint']
" let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_html_checkers = ['']
let g:syntastic_javascript_standard_generic = 1

" typescript stuff
 let g:tsuquyomi_disable_quickfix = 1
 let g:syntastic_typescript_checkers = ['tsuquyomi']
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
"  NERDTree settings
let g:NERDTreeWinPos = 'right'
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" CtrlP settings
let g:ctrlp_max_files = 20000
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|dist'
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" Airline settings
let g:airline_theme='dracula'
" show buffer list on airline
let g:airline#extensions#tabline#enabled = 1
" show buffer number on airline
let g:airline#extensions#tabline#buffer_nr_show = 1
" let g:airline_section_z=airline#section#create(['%{ObsessionStatus(''$'', '''')}'])
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" status line content
" set statusline+=%F
" set statusline =%1*\ %n\ %*            "buffer number
" set statusline +=%5*%{&ff}%*            "file format
" set statusline +=%3*%y%*                "file type
" set statusline +=%4*\ %<%F%*            "full path
" set statusline +=%2*%m%*                "modified flag
" set statusline +=%1*%=%5l%*             "current line
" set statusline +=%2*/%L%*               "total lines
" set statusline +=%1*%4v\ %*             "virtual column number
" set statusline +=%2*0x%04B\ %*          "character under cursor
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" NERDTree settings
let g:NERDTreeDirArrowExpandable = '→'
let g:NERDTreeDirArrowCollapsible = '↳'
let g:NERDTreeWinSize = 55
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" NERDCommenter settings
let g:NERDSpaceDelims=1       " add space after comments char
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
"  Ack.vim settings
 let g:ackprg = 'ag --vimgrep'             " use ag instead of ack
" ---------------------------------------------------------------------------------

hi Search cterm=NONE ctermfg=black ctermbg=blue
let g:solarized_termcolors=256

let JSHintUpdateWriteOnly=1

" ---------------------------------------------------------------------------------
" keybinds
map <C-n> :NERDTreeToggle <CR>
" map <C-n> :call OpenNerdTree() <CR>
map <C-k> :call RevealFileInNERDTree() <CR>
map <C-S-Left> :vertical resize -1 <CR>
map <C-S-Right> :vertical resize +1 <CR>
map <C-S-Down> :resize -1 <CR>
map <C-S-Up> :resize +1 <CR>

" position cursor inbetween brackets
imap {<Tab> {}<Esc>i
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
" ---------------------------------------------------------------------------------

" open nerd tree on the current file location
function RevealFileInNERDTree()
        echo @%
        :NERDTreeFind
endfunction

function DeleteAllBuffers()
        bufdo bd
        call OpenNerdTree()
endfunction

function OpenNerdTree()
        :NERDTreeToggle
        vertical resize -9999
        vertical resize +35
        " call SetAllSplitsSameWidth()
endfunction

function SetAllSplitsSameWidth()
        let i = 1
        let window_size = 0
        let windows_quantity = winnr('$')
        let windows_to_resize = []

        " get screen size
        while i <= windows_quantity
                let window_size += winwidth(i)
                call add(windows_to_resize, i)
                let i += 1
        endwhile

        if IsNerdTreeOpen()
                let window_size -= 35
                let windows_quantity -= 1
                let windows_to_resize = windows_to_resize[1:len(windows_to_resize)]
        endif

        let size_per_split = window_size / windows_quantity
        let windows_to_resize = join(windows_to_resize, ',')

        execute ''.windows_to_resize.'windo execute "set winwidth='.size_per_split.'"'
endfunction

function! IsNerdTreeOpen()
        return exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1
endfunction

" ---------------------------------------------------------------------------------
" commands
" start session on specific dir
command! ObsessionStart :Obsession ~/.vim/Session.vim
" read saved sesh
command! ObsessionRead :source ~/.vim/Session.vim
" delete all open buffers (things get messy sometimes)
command Bda :call DeleteAllBuffers()
" remove trailing spaces on pre write
autocmd BufWritePre * %s/\s\+$//e
autocmd BufNewFile,BufRead *.ts set filetype=typescript
autocmd BufNewFile,BufRead *.styl,*.scss set filetype=css
autocmd BufNewFile,BufRead *.html.erb set filetype=html

autocmd FileType javascript noremap <buffer> <c-f> :call JsBeautify()<cr>
autocmd FileType typescript noremap <buffer> <c-f> :call JsBeautify()<cr>
autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" tabs
au FileType javascript
        \ setlocal tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
au FileType typescript
        \ setlocal tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
au FileType json setlocal tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
au FileType html setlocal tabstop=2 expandtab shiftwidth=4 softtabstop=4
au FileType css setlocal tabstop=2 expandtab shiftwidth=4 softtabstop=4
au FileType ruby setlocal shiftwidth=2 smarttab
au FileType python setlocal textwidth=79 colorcolumn=79
au FileType yaml setlocal shiftwidth=2 smarttab
au FileType sh setlocal shiftwidth=2 expandtab smarttab
" ---------------------------------------------------------------------------------

