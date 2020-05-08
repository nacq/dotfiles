call plug#begin('~/.vim/plugged')
Plug 'VundleVim/Vundle.vim'

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

set termguicolors
set guicursor=

" ---------------------------------------------------------------------------------
set list
" show special characters for tabs and trailing spaces
set listchars=tab:▸\ ,trail:•
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
"  yeeee no more :Wq or :Q Not an editor command
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Q! q!
cnoreabbrev Bd bd
cnoreabbrev Wq wq
cnoreabbrev Wq! wq!
cnoreabbrev Wqa! wqa!
cnoreabbrev Tabclose tabclose
cnoreabbrev Tabopen tabopen
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
colorscheme space_vim_theme
" ---------------------------------------------------------------------------------

set t_Co=256
set path+=**
" set autochdir
set nopaste
" ---------------------------------------------------------------------------------

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
"  NERDTree settings
let g:NERDTreeWinPos = 'right'
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
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
" NERDCommenter settings
let g:NERDSpaceDelims=1       " add space after comments char
" ---------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------
hi Search cterm=NONE ctermfg=black ctermbg=blue
" ---------------------------------------------------------------------------------
" keybinds
map <C-n> :NERDTreeToggle <CR>
map <C-p> :GFiles <CR>
map <C-k> :call RevealFileInNERDTree() <CR>
map <C-g> :execute "!" "$HOME/dotfiles/open_in_github.sh" bufname("%") line(".") <CR>

map <leader>vd :vsplit \| YcmCompleter GoTo <CR>
map <leader>dd :YcmCompleter GoTo <CR>
map <leader>rr :YcmCompleter GoToReferences <CR>

" position cursor inbetween brackets
imap {<Tab> {}<Esc>i<Enter><Esc>O
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

" ---------------------------------------------------------------------------------

" commands
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
au FileType go setlocal shiftwidth=4 expandtab smarttab
" ---------------------------------------------------------------------------------
