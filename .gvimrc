" =============================================
" Reclaim some real estate
" =============================================
" Remove menubar from gvim
set guioptions-=m

" Remove toolbar from gvim
set guioptions-=T

" Use a nicer font
set guifont=dejavu\ sans\ mono

" Who wants to start in system32?
if getcwd() == "C:\\Program Files (x86)\\Vim\\vim74"
	:cd $HOME
endif
