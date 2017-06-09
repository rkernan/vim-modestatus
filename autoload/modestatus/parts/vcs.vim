function! modestatus#parts#vcs#init()
	call modestatus#parts#add('hunks_added', 'modestatus#parts#vcs#added')
	call modestatus#parts#add('hunks_modified', 'modestatus#parts#vcs#modified')
	call modestatus#parts#add('hunks_removed', 'modestatus#parts#vcs#removed')
	call modestatus#parts#add('git_branch', 'fugitive#head')
	
	call modestatus#options#add('hunks_added', 'format', '+%s', v:false)
	call modestatus#options#add('hunks_modified', 'format', '~%s', v:false)
	call modestatus#options#add('hunks_removed', 'format', '-%s', v:false)
endfunction

function! s:get_sy_stats(active_win)
	if winnr() == a:active_win
		let b:modestatus_hunks_cache = sy#repo#get_stats()
	endif
	if exists('b:modestatus_hunks_cache')
		return b:modestatus_hunks_cache
	else
		return [-1, -1, -1]
	endif
endfunction

function! modestatus#parts#vcs#added(active_win)
	let stats = s:get_sy_stats(a:active_win)
	if stats[0] > 0
		return stats[0]
	else
		return ''
	endif
endfunction

function! modestatus#parts#vcs#modified(active_win)
	let stats = s:get_sy_stats(a:active_win)
	if stats[1] > 0
		return stats[1]
	else
		return ''
	endif
endfunction

function! modestatus#parts#vcs#removed(active_win)
	let stats = s:get_sy_stats(a:active_win)
	if stats[2] > 0
		return stats[2]
	else
		return ''
	endif
endfunction

function! modestatus#parts#vcs#git_branch(...)
	return fugitive#head()
endfunction
