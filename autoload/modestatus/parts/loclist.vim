function! modestatus#parts#loclist#init()
	call modestatus#parts#add('loclist_errors', 'modestatus#parts#loclist#errors')
	call modestatus#parts#add('loclist_warnings', 'modestatus#parts#loclist#warnings')
endfunction

function! s:get_loclist_types(nr, type)
	let loclist = getloclist(a:nr)
	let num_types = 0
	for i in loclist
		if i.type ==# a:type
			let num_types += 1
		endif
	endfor
	if num_types > 0
		return num_types
	else
		return ''
	endif
endfunction

function! modestatus#parts#loclist#errors(nr)
	return s:get_loclist_types(a:nr, 'E')
endfunction

function! modestatus#parts#loclist#warnings(nr)
	return s:get_loclist_types(a:nr, 'W')
endfunction
