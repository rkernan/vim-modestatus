function! modestatus#loclist#num_types(nr, type)
	let loclist = getloclist(a:nr)
	let num_types = 0
	for i in loclist
		if i.type == a:type
			let num_types += 1
		endif
	endfor
	return num_types
endfunction

function! modestatus#loclist#errors(nr)
	let num_errors = modestatus#loclist#num_types(a:nr, 'E')
	let error_str = ''
	if num_errors > 0
		let error_str .= ' E: ' . num_errors . ' '
	endif
	return error_str
endfunction

function! modestatus#loclist#warnings(nr)
	let num_warnings = modestatus#loclist#num_types(a:nr, 'W')
	let warning_str = ''
	if num_warnings > 0
		let warning_str .= ' W: ' . num_warnings . ' '
	endif
	return warning_str
endfunction
