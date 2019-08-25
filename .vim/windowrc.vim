"
" sakura: new-window.vim
"

function NewWindow(...)
	let dir = "belowright"
	let cmd = "new" 
	let spsize = -1
	let filename = ""
	if a:0 <= 3
		for arg in a:000
			if arg =~ '^L\(eft\)\?$'
				let dir = "topleft"
				let cmd = "vnew"
			elseif arg =~ '^R\(ight\)\?$'
				let dir = "botright"
				let cmd = "vnew"
			elseif arg =~ '^[Tt]\(op\)\?$'
				let dir = "topleft"
				let cmd = "new"
			elseif arg =~ '^B\(ottom\)\?$'
				let dir = "botright"
				let cmd = "new"
			elseif arg =~ '^l\(eft\)\?$'
				let dir = "aboveleft"
				let cmd = "vnew"
			elseif arg =~ '^r\(ight\)\?$'
				let dir = "belowright"
				let cmd = "vnew"
			elseif arg =~ '^[Aa]\(bove\)\?$'
				let dir = "aboveleft"
				let cmd = "new"
			elseif arg =~ '^b\(elow\)\?$'
				let dir = "belowright"
				let cmd = "new"
			elseif arg =~ '^\d\+$'
				let spsize = arg
			else
				let filename = arg
			end
		endfor
	endif
	if spsize == -1
		if cmd == "vnew"
			let spsize = winwidth(0) / 5
			echo spsize
		else
			let spsize = winheight(0) / 5
			echo spsize
		end
		if spsize < 1
			let spsize = 1
		endif
	endif
	exe dir . " " . spsize . cmd . " " . filename
endfunction

command! -nargs=* NW call NewWindow(<f-args>)
