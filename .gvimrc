" =============================================
" Reclaim some real estate
" =============================================
" Remove menubar from gvim
set guioptions-=m

" Remove toolbar from gvim
set guioptions-=T

" Rather than add the ctags folder to my path (used by tagbar) just let vim know
" where to find the files it needs
let g:tagbar_ctags_bin = "C:/Users/Justin/vimfiles/extra/tags/ctags58/ctags.exe"
let g:tagbar_phpctags_bin = "C:/Users/Justin/vimfiles/extra/tags/tagbar-phpctags/plugin/tagbar-phpctags.vim"
let g:tagbar_type_javascript = {"ctagsbin": "C:/Users/Justin/vimfiles/extra/tags/jsctags.cmd"}

" Who wants to start in system32?
if getcwd() == "C:\\Windows\\system32"
	:cd $HOME
endif
