set nocompatible
filetype plugin indent on
syntax on

runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

let mapleader=","
let g:user_email = "jus.russell@gmail.com"
let g:user_name = "Justin Russell"
let g:snips_author = g:user_name

set foldmethod=marker
set directory=$VIM_BACKUP_DIR
set fileformat=unix
set shiftwidth=2
set tabstop=2
set autoindent
set smartindent
set smarttab
set expandtab
set wildmode=longest,list
set scrolloff=10
set linebreak
set textwidth=80
set formatoptions=cq
set nowrap
set hlsearch
set incsearch
set ignorecase
set smartcase
set cursorcolumn
set cursorline
set showtabline=2
set showcmd
set number
set numberwidth=1
set ruler
set showmatch
set backspace=2
set completeopt=longest,menuone,preview
set diffexpr=

nnoremap ; :
nnoremap <leader>y "+y
nnoremap <leader>p "+gp
nnoremap <leader>P "+gP
nnoremap <leader>a ggVG
nnoremap <CR> :noh<CR><Esc>
nnoremap ,F :echo expand("%:p")<CR>
nnoremap <C-n> :next<CR>
nnoremap <C-p> :prev<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-l> <C-w>l
nnoremap \ i <esc>l
nnoremap <C-\> mzO<esc>`z:delm z<cr>
nnoremap <leader>ev :vsplit $MYVIMRC<CR>

inoremap jj <Esc>
inoremap <C-CR> <Esc>o
inoremap <C-BS> <Esc>vb"_da

" Use <C-Space> for hippie completion
" Note: Terminal vim interprets <C-Space> as <C-@>
inoremap <C-Space> <C-n>
imap <C-@> <C-Space>

" Make Ctrl+c actually work like Esc
inoremap <C-c> <Esc>
vnoremap <C-c> <Esc>
nnoremap <C-c> <Esc>

" Emmet Coding Stuff
imap <c-e> <c-y>,

" NERDTree Stuff
nnoremap <leader>d :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

" CtrlP Stuff
nnoremap <leader>T :CtrlPClearCache<CR>:CtrlP<CR>
nnoremap <leader>t :CtrlP<CR>
let g:ctrlp_custom_ignore = '\v[\/]\.?(git|hg|svn|node_modules|components|bower_components)$'

augroup custom_filetypes
  autocmd!

  " Deck List Object Notation
  au BufRead,BufNewFile *.dlon set syntax=javascript
  au BufRead,BufNewFile *.dlon set filetype=dlon

  " Associate active 4d file extensions with the "a4d" filetype
  au BufRead,BufNewFile *.a4l set syntax=a4l
  au BufRead,BufNewFile *.a4d set syntax=a4d
  au BufRead,BufNewFile *.a4p set syntax=a4d
augroup END

" Show an error for lines over 80 chars long Keeping lines short helps improve
" readability and lets us open files side by side withouth cutting off any text
augroup long_line_error
  autocmd!
  au! BufWinEnter * let w:m1=matchadd('ErrorMsg', '\%>80v.\+', -1)
augroup END

" Changes to .vimrc go into effect immediately
augroup live_vimrc_updates
  autocmd!
  au! BufWritePost .vimrc source %
augroup END

fun! g:MarkdownServer()
 :!start cmd %:p:h /c gfms -p 1234
 :!start cmd /c open "http://localhost:1234/%:p:t"
endfun

fun! g:FormatJson()
  %s:{\(\S\):{\r\1:ge
  %s:\[\(\S\):[\r\1:ge
  %s:,\(\S\):,\r\1:ge
  %s:\S\@<=[\]}]:\r&:ge
  normal gg=G
  noh
endfun
command! FormatJson :call g:FormatJson()

" Custom Commands
command! Trim :%s/\s\+$//g
command! -nargs=* Grunt :!grunt.cmd <f-args>
command! Markdown :call g:MarkdownServer()
command! -nargs=* Node :!node <f-args>
command! -nargs=* Npm :!npm <f-args>

if has("win32")
  runtime vimrc.win
endif

if has("unix")
  runtime vimrc.nix
endif

if has("gui_running")
  runtime vimrc.gui
endif
