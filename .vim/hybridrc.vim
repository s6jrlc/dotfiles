"
" sakura: hybridrc.vim
"
"
if filereadable(expand('<sfile>:p:h') . '/colors/hybrid.vim')
	colorscheme hybrid
	let g:hybrid_custom_term_colors = 1
	let g:hybrid_reduced_contrast = 1
	hi linenr ctermbg=4 ctermfg=0
	hi CursorLineNr ctermbg=4 ctermfg=0
	hi clear CursorLine
	set cursorline
	set background=dark
	hi CursorLine ctermbg=darkgray
endif
