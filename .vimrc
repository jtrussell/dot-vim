" ============================================
" This should be commented fairly well... Note that pathogen lives in bundle/
" rather than autoload/ just make sure the runtime directive is in place before
" calling pathogen:infect(). I work on a bunch of different systems, one of
" which being windows... so if you get strange errors about line endings...
" yeah.
" ============================================
"
" Necessary for lots of cool vim things
set nocompatible

filetype plugin indent on " Smart filetype detection

" ============================================
" Trying out omni completion
" ============================================
set ofu=syntaxcomlete#Complete

" ============================================
" Pathogen - Include this if you have pathogen
" ============================================
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

" ============================================
" Tagbar
" ============================================
nmap <F5> :TagbarToggle<CR>

" ============================================
" Used by some of my scripts, macros, and methods
" ============================================
let g:current_user_email = "jus.russell@gmail.com"
let g:current_user_name = "Justin Russell"
let g:snips_author = g:current_user_name

" ============================================
" I don't like leaving backup files scattered
" everywhere - let's just be good about saving
" and backing up ok?
" ============================================
set nobackup
set nowritebackup
set noswapfile

set noerrorbells
set fileformat=unix

" Turn Syntax highlighting on
syntax on

colorscheme tmnt

" Custom mapleader option
let mapleader=","

" =============================================
" Indentation
" =============================================
set shiftwidth=2 " Number of spaces to use for each step of (auto)indent.  Used for << and >>
set tabstop=2 " How many spaces a tab counts for
set autoindent " New lines take indent of above line
set smartindent " Smart c-like indents
"set cindent

" =============================================
" Behavior of tab when opening new files,
" show the longest common string of letters
" and list all possibilities.
" =============================================
set wildmode=longest,list

" =============================================
" Linebreaks and scrolling
" =============================================
set scrolloff=10 " Force n lines of context when scrolling
set linebreak " Break wrapping lines at word boundaries
set textwidth=80 " Set 80 cols for all text
set formatoptions=cq " No hard wraps on text
set nowrap " no line wrapping

" =============================================
" Search Configuration
" =============================================
set hlsearch " Highlight search
set incsearch " Search as you type
set ignorecase " Ignore cases for all-lower search
set smartcase " Case-sensitive if search is mixed case

set cursorcolumn " Turn on highlighting for cursor column
set cursorline " Turn on highlighting for cursor row


set showtabline=2 " Always show tabs regardless of num of buffers

set showcmd " Show partial commands in status line
set number " Show line numbers
set numberwidth=1 " Number of columns for line numbers


set ruler " Show bottom ruler
set showmatch "Show opening { or ( when typing in closing

set backspace=2 "Allow backspacing over previously entered chars

" =============================================
" Some useful remappings
" =============================================

" Escapes to command mode
imap jj <Esc>

" Copy and Paste from 'global' clipboard
map <leader>y "+y
map <leader>p "+gp
map <leader>P "+gP

" <Ctrl + a> to select all
map <C-a> ggVG

" lazy colon
map ; :

" <CR> clears the search highlighting
nnoremap <CR> :noh<CR><Esc>

" Map Ctrl-s to save the current buffer
nnoremap <C-s> :w<CR>
imap <C-s> <c-o>:w<CR>

" Show current file path
nnoremap ,F :echo expand("%:p")<CR>

" I often find I want to remove text without clobbering the default register. In
" visual mode this allows <ctrl+r> to get rid of text without messing with any
" used register (sends text to the black hole register). I'm also too lazy to
" bother messing with non-default registers most of the time.
vmap <C-d> "_d
vmap <C-r> <C-d>P

" =============================================
" Plugin Mappings
" =============================================
" Expand sequence for Zen Coding
imap <C-e> <C-y>,

" Folding
"set foldmethod=indent
"set foldnestmax=5
"set nofoldenable
"set foldlevel=1

" =============================================
" I find myself often going into insert mode only to insert a space char - this
" maps \ to do just that. Similarly, insert a new line above the current one
" with Control+\ - note this has a side effect of overwritting and deleting
" whatever mark was set to the z char
" =============================================
nnoremap \ i<Space><Esc>l
nnoremap <C-\> mzO<Esc>0D`z:delm<Space>z<CR>

" =============================================
" Control + enter essentially regular enter but leaves the end of the current
" line intact
" =============================================
imap <C-CR> <Esc>o

" Some sugar - opening a brace then hitting enter will automatically
" close the brace on a line below and put the cursor between them
"inoremap {<cr> {<cr>}<c-o>O
"inoremap [<cr> [<cr>]<c-o>O
"inoremap (<cr> (<cr>)<c-o>O

" Hippie Completion - I prefer control+spacebar
" Terminal vim interprets <C-Space> as <C-@> so the second line is a workaround
imap <C-Space> <C-n>
imap <C-@> <C-Space>

" Completion options
set completeopt=longest,menuone,preview

" =============================================
" Extra extension associations
" =============================================

" Deck List Object Notation
au BufRead,BufNewFile *.dlon set syntax=javascript
au BufRead,BufNewFile *.dlon set filetype=dlon

" Associate active 4d file extensions with the "a4d" filetype
au BufRead,BufNewFile *.a4l set syntax=a4l
au BufRead,BufNewFile *.a4d set syntax=a4d
au BufRead,BufNewFile *.a4p set syntax=a4d

" Show an error for lines over 80 chars long
" Keeping lines short helps improve readability
" and lets us open files side by side withouth
" cutting off any text
"au BufWinEnter * let w:m1=matchadd('ErrorMsg', '\%>80v.\+', -1)

" Window Movement
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-l> <C-w>l
nnoremap <C-t> <C-w>t
nnoremap <C-T> <C-w>t<C-w>31\|^<C-w>=

inoremap <C-h> <Esc><C-w>h
inoremap <C-k> <Esc><C-w>k
inoremap <C-j> <Esc><C-w>j
inoremap <C-l> <Esc><C-w>l
inoremap <C-t> <Esc><C-w>t
inoremap <C-T> <Esc><C-w>t<C-w>31\|^<C-w>=

" Changes to .vimrc go into effect immediately
au! BufWritePost .vimrc source %

" Custom Commands
command! Trim :%s/\s\+$//g
