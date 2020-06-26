" vim specific configs
" set runtimepath+=~/.vim/

set termguicolors
set guicursor=

" mouse active in normal mode
set mouse=n

" ---------------------------------------------------------------------------------
set list
" show special characters for tabs and trailing spaces
set listchars=tab:▸\ ,trail:•

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
" statusline config
" show staus line on all windows
set laststatus=2

set statusline+=%#PmenuSel#
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %p%%
set statusline+=\ %l:%c
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
" ---------------------------------------------------------------------------------

set t_Co=256
set path+=**
" set autochdir
set nopaste
" ---------------------------------------------------------------------------------

hi Search cterm=NONE ctermfg=black ctermbg=blue
"
" remove trailing spaces on pre write
autocmd BufWritePre * %s/\s\+$//e
" keep tsx here to start ts server when opening tsx files
autocmd BufNewFile,BufRead *.ts set filetype=typescript
autocmd BufNewFile,BufRead *.js set filetype=javascript
autocmd BufNewFile,BufRead *.styl,*.scss set filetype=css
autocmd BufNewFile,BufRead *.html.erb set filetype=html
autocmd BufNewFile,BufRead *.jsx,*.tsx set filetype=typescript.jsx
autocmd BufNewFile,BufRead *.go set filetype=go
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" tabs
au FileType javascript
      \ setlocal tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
au FileType javascript.jsx
      \ setlocal tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
au FileType typescript
      \ setlocal tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
au FileType typescript.tsx
      \ setlocal tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
au FileType json setlocal tabstop=8 softtabstop=0 expandtab shiftwidth=2
au FileType html setlocal tabstop=2 expandtab shiftwidth=4 softtabstop=4
au FileType css setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=4
au FileType ruby setlocal shiftwidth=2 smarttab
au FileType python setlocal textwidth=79 colorcolumn=79
au FileType yaml setlocal shiftwidth=2 smarttab
au FileType sh setlocal shiftwidth=2 expandtab smarttab
au FileType vim setlocal shiftwidth=2 expandtab smarttab
au FileType c setlocal shiftwidth=4 tabstop=4 softtabstop=4 smartindent expandtab
" ---------------------------------------------------------------------------------
