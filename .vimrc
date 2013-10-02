" ============================================
" Note that pathogen lives in bundle/ rather than autoload/ just make sure the
" runtime directive is in place before calling pathogen:infect().
" ============================================

" From the docs for `compatible`:
" This option has the effect of making Vim either more Vi-compatible, or make
" Vim behave in a more useful way.
set nocompatible

" Smart filetype detection
filetype plugin indent on

" Turn Syntax highlighting on
syntax on

" Enable Omni completion
set ofu=syntaxcomlete#Complete

" Plugin loading with Pathogen - Include this if you have pathogen. I prefet to
" keep pathogen itself in the bundle folder which requires it be added to our
" runtimepath
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

" Used by some of my scripts, macros, and methods
let g:user_email = "jus.russell@gmail.com"
let g:user_name = "Justin Russell"
let g:snips_author = g:user_name

" Sometimes we want to launch a browser
let g:browser = $BROWSER

" Custom mapleader option
let mapleader=","

" I don't like leaving backup files scattered everywhere - store them in a
" central location
set directory=$VIM_BACKUP_DIR

" Yeah those error bells are annoying
set noerrorbells

" For consistency sake
set fileformat=unix

" Background and colors
set background=light
colorscheme solarized

" Indentation
set shiftwidth=2 " Number of spaces to use for each step of (auto)indent.  Used for << and >>
set tabstop=2 " How many spaces a tab counts for
set autoindent " New lines take indent of above line
set smartindent " Smart c-like indents
set smarttab " Backspace deletes whole tab (shirftwidth worth of spaces) at start of line
set expandtab " Always expand tabs to spaces

" Behavior of tab when opening new files, show the longest common string of
" letters and list all possibilities.
set wildmode=longest,list

" Linebreaks and scrolling
set scrolloff=10 " Force n lines of context when scrolling
set linebreak " Break wrapping lines at word boundaries
set textwidth=80 " Set 80 cols for all text
set formatoptions=cq " No hard wraps on text
set nowrap " no line wrapping

" Search Configuration
set hlsearch " Highlight search
set incsearch " Search as you type
set ignorecase " Ignore cases for all-lower search
set smartcase " Case-sensitive if search is mixed case

" Cross hairs
set cursorcolumn " Turn on highlighting for cursor column
set cursorline " Turn on highlighting for cursor row

" Mostly I just don't like the viewport height changing
set showtabline=2 " Always show tabs regardless of num of buffers

set showcmd " Show partial commands in status line
set number " Show line numbers
set numberwidth=1 " Number of columns for line numbers

set ruler " Show bottom ruler
set showmatch "Show opening { or ( when typing in closing

"Allow backspacing over previously entered chars
set backspace=2

" Escapes to command mode
inoremap jj <Esc>

" Copy and Paste from 'global' clipboard
noremap <leader>y "+y
noremap <leader>p "+gp
noremap <leader>P "+gP

" Easy select all
nnoremap <leader>a ggVG

" lazy colon
noremap ; :

" <CR> clears the search highlighting
nnoremap <CR> :noh<CR><Esc>

" Show current file path
nnoremap ,F :echo expand("%:p")<CR>

" I often find I want to remove text without clobbering the default register. In
" visual mode this allows <ctrl+r> to get rid of text without messing with any
" used register (sends text to the black hole register). I'm also too lazy to
" bother messing with non-default registers most of the time.
"vnoremap <C-d> "_d
"vnoremap <C-r> "_dP

" =============================================
" Arg List Navigation
" =============================================
nnoremap <C-n> :next<CR>
nnoremap <C-p> :prev<CR>

" =============================================
" Plugin Mappings
" =============================================
"
" Expand sequence for Emmet Coding
imap <c-e> <c-y>,

" Folding
set foldmethod=marker

" Control + enter essentially regular enter but leaves the end of the current
" line intact
inoremap <C-CR> <Esc>o

" Let Control+Backspace delete entire words
inoremap <C-BS> <Esc>vb"_da

" Hippie Completion - I prefer control+spacebar
" Terminal vim interprets <C-Space> as <C-@> so the second line is a workaround
inoremap <C-Space> <C-n>
inoremap <C-@> <C-Space>

" Completion options
set completeopt=longest,menuone,preview

set diffexpr=

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

" Window Movement
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-l> <C-w>l
nnoremap <C-t> <C-w>t<C-w>31\|^<C-w>=

inoremap <C-h> <Esc><C-w>h
inoremap <C-k> <Esc><C-w>k
inoremap <C-j> <Esc><C-w>j
inoremap <C-l> <Esc><C-w>l

" Quickly jump to this file for edits
nnoremap <leader>ev :vsplit $MYVIMRC<CR>

" Make Ctrl+c actually work like Esc
inoremap <C-c> <Esc>
vnoremap <C-c> <Esc>
nnoremap <C-c> <Esc>

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
"command! Markdown :!start cmd %:p:h /c gfms -p 1234
command! Markdown :call g:MarkdownServer()
command! -nargs=* Node :!node <f-args>
command! -nargs=* Npm :!npm <f-args>
