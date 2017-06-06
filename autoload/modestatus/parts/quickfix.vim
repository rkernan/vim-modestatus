function! modestatus#parts#quickfix#init()
	call modestatus#parts#add('quickfix_errors', 'modestatus#parts#quickfix#errors')
	call modestatus#parts#add('quickfix_warnings', 'modestatus#parts#quickfix#warnings')
endfunction

function! s:get_quickfix_types(type)
	let quickfix = getqflist()
	let num_types = 0
	for i in quickfix
		if i.type ==# a:type
			let num_types += 1
		endif
	endfor
	return num_types
endfunction

function! modestatus#parts#quickfix#errors(nr)
	let num_errors = s:get_quickfix_types('E')
	return num_errors > 0 ? num_errors : ''
endfunction

function! modestatus#parts#quickfix#warnings(nr)
	let num_warnings = s:get_quickfix_types('W')
	return num_warnings > 0 ? num_warnings : ''
endfunction
