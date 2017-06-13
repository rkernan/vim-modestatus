function! modestatus#parts#signify#init()
	call modestatus#parts#add('signify_added', 'modestatus#parts#signify#added')
	call modestatus#parts#add('signify_modified', 'modestatus#parts#signify#modified')
	call modestatus#parts#add('signify_removed', 'modestatus#parts#signify#removed')

	call modestatus#options#add('signify_added', 'format', '+%s', 0)
	call modestatus#options#add('signify_modified', 'format', '~%s', 0)
	call modestatus#options#add('signify_removed', 'format', '-%s', 0)
endfunction

function! modestatus#parts#signify#added()
	let c = sy#repo#get_stats()[0]
	return c > 0 ? c : ''
endfunction

function! modestatus#parts#signify#modified()
	let c = sy#repo#get_stats()[1]
	return c > 0 ? c : ''
endfunction

function! modestatus#parts#signify#removed()
	let c = sy#repo#get_stats()[2]
	return c > 0 ? c : ''
endfunction
