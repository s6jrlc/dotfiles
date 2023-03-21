"
" .vim/backuprc.vim
"

" setting variables from the cache path

if has('mac')
	let s:cachedir=expand('~/Library/Caches')
elseif has('unix')
	" *n*x env like linux, beos, sun(os), even cygwin and mingw
	let s:cachedir=expand('~/.cache/')
elseif has('win32') || has('win64')
	let s:cachedir=expand('$HOME\AppData\Local\Temp')
endif

" actually setting the cache path

if !isdirectory(s:cachedir)
	call mkdir(s:cachedir, 'p')
endif
let &directory=s:cachedir

set nobackup
set noundofile
