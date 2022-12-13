if has('win32')
	"
elseif has('mac')
	let s:cachedir=expand('~/Library/Caches')
	if !isdirectory(s:cachedir)
		call mkdir(s:cachedir, 'p')
	endif
	let &directory=s:cachedir
endif

set nobackup
set noundofile
