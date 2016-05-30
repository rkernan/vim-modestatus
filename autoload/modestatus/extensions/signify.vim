let s:initialized = 0

function! modestatus#extensions#signify#init()
	if s:initialized
		return
	endif
	let s:initialized = 1

	call modestatus#util#check_defined('g:modestatus#extensions#signify#symbols', {})
	call extend(g:modestatus#extensions#signify#symbols, {'added': '+', 'removed': '-', 'modified': '~'}, 'keep')

	call modestatus#parts#add('signify_hunks', 'modestatus#extensions#signify#hunks')
endfunction

function! modestatus#extensions#signify#hunks(nr) abort
	let symbols = [
		\     g:modestatus#extensions#signify#symbols.added,
		\     g:modestatus#extensions#signify#symbols.modified,
		\     g:modestatus#extensions#signify#symbols.removed
		\ ]

	let stats = getbufvar(winbufnr(a:nr), 'sy', {'stats': [-1, -1, -1]}).stats
	let hunkline = ''
	
	for i in range(3)
		if stats[i] > 0
			if len(hunkline) > 0
				let hunkline .= ' '
			endif
			let hunkline .= printf('%s%s', symbols[i], stats[i])
		endif
	endfor

	return hunkline
endfunction
