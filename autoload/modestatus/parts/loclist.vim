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
	return num_types
endfunction

function! modestatus#parts#loclist#errors(nr)
	let num_errors = s:get_loclist_types(a:nr, 'E')
	return num_errors > 0 ? num_errors : ''
endfunction

function! modestatus#parts#loclist#warnings(nr)
	let num_warnings = s:get_loclist_types(a:nr, 'E')
	return num_warnings > 0 ? num_warnings : ''
endfunction
