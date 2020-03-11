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

" colorscheme
Plug 'morhetz/gruvbox'
Plug 'cormacrelf/vim-colors-github'

" syntax higlighters
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'HerringtonDarkholme/yats.vim'

call plug#end()

set termguicolors

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

function! GetBranchName()
  let branchname = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
  return strlen(l:branchname) > 0 ? '  '.l:branchname.' ' : ''
endfunction

set statusline+=%#PmenuSel#
set statusline+=%{GetBranchName()}
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
colorscheme gruvbox
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

" ---------------------------------------------------------------------------------
" CtrlP settings
let g:ctrlp_max_files = 20000
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|dist\|ios\|android\|coverage'
let g:ctrlp_show_hidden = 1
" ---------------------------------------------------------------------------------

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
" Ack.vim settings
" use ag instead of ack
let g:ackprg = 'ag --vimgrep --ignore package-lock.json --ignore-dir={ios,android,node_modules,coverage}'

" avoid jump to the first match automatically
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>
" ---------------------------------------------------------------------------------

hi Search cterm=NONE ctermfg=black ctermbg=blue
let g:solarized_termcolors=256

let JSHintUpdateWriteOnly=1

" ---------------------------------------------------------------------------------
" keybinds
map <C-n> :NERDTreeToggle <CR>
map <C-p> :GFiles <CR>
map <C-S-p> :Files <CR>
map <C-k> :call RevealFileInNERDTree() <CR>

map <C-S-d> :YcmCompleter GoTo <CR>
map <C-S-e> :TSGetDiagnostics <CR>

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
" start session on specific dir
command! ObsessionStart :Obsession ~/.vim/Session.vim
" read saved sesh
command! ObsessionRead :source ~/.vim/Session.vim
" remove trailing spaces on pre write
autocmd BufWritePre * %s/\s\+$//e
" keep tsx here to start ts server when opening tsx files
autocmd BufNewFile,BufRead *.tsx,*.ts set filetype=typescript
autocmd BufNewFile,BufRead *.js set filetype=javascript
autocmd BufNewFile,BufRead *.styl,*.scss set filetype=css
autocmd BufNewFile,BufRead *.html.erb set filetype=html
autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
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
