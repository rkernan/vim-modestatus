function! modestatus#parts#hunks#init()
	call modestatus#parts#add('hunks_added', 'modestatus#parts#hunks#added')
	call modestatus#parts#add('hunks_modified', 'modestatus#parts#hunks#modified')
	call modestatus#parts#add('hunks_removed', 'modestatus#parts#hunks#removed')
	
	call modestatus#options#add('hunks_added', 'format', '+%s', v:false)
	call modestatus#options#add('hunks_modified', 'format', '~%s', v:false)
	call modestatus#options#add('hunks_removed', 'format', '-%s', v:false)
endfunction

function! s:get_sy_stats(nr)
	if winnr() == a:nr
		let b:modestatus_hunks_cache = sy#repo#get_stats()
	endif
	if exists('b:modestatus_hunks_cache')
		return b:modestatus_hunks_cache
	else
		return [-1, -1, -1]
	endif
endfunction

function! modestatus#parts#hunks#added(nr)
	let stats = s:get_sy_stats(a:nr)
	if stats[0] > 0
		return stats[0]
	else
		return ''
	endif
endfunction

function! modestatus#parts#hunks#modified(nr)
	let stats = s:get_sy_stats(a:nr)
	if stats[1] > 0
		return stats[1]
	else
		return ''
	endif
endfunction

function! modestatus#parts#hunks#removed(nr)
	let stats = s:get_sy_stats(a:nr)
	if stats[2] > 0
		return stats[2]
	else
		return ''
	endif
endfunction
