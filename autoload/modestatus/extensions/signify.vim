let s:initialized = 0

function! modestatus#extensions#signify#init()
	if s:initialized
		return
	endif
	let s:initialized = 1

	call modestatus#parts#add('signify_hunk_added', 'modestatus#extensions#signify#hunk_added')
	call modestatus#parts#add('signify_hunk_modified', 'modestatus#extensions#signify#hunk_modified')
	call modestatus#parts#add('signify_hunk_removed', 'modestatus#extensions#signify#hunk_removed')

	call modestatus#options#add('signify_hunk_added', {'common': {'format': '+%s'}}, 'keep')
	call modestatus#options#add('signify_hunk_modified', {'common': {'format': '~%s'}}, 'keep')
	call modestatus#options#add('signify_hunk_removed', {'common': {'format': '-%s'}}, 'keep')
endfunction

function! s:get_sy_stats(nr) abort 
	let stats_arr = getbufvar(winbufnr(a:nr), 'sy', {'stats': [-1, -1, -1]}).stats
	return {'added': stats_arr[0], 'modified': stats_arr[1], 'removed': stats_arr[2]}
endfunction

function! modestatus#extensions#signify#hunk_added(nr) abort
	let stats = s:get_sy_stats(a:nr)
	if stats.added > 0
		return string(stats.added)
	else
		return ''
	endif
endfunction

function! modestatus#extensions#signify#hunk_modified(nr) abort
	let stats = s:get_sy_stats(a:nr)
	if stats.modified > 0
		return string(stats.modified)
	else
		return ''
	endif
endfunction

function! modestatus#extensions#signify#hunk_removed(nr) abort
	let stats = s:get_sy_stats(a:nr)
	if stats.removed > 0
		return string(stats.removed)
	else
		return ''
	endif
endfunction
