let s:initialized = 0

function! modestatus#extensions#loclist#init()
	if s:initialized
		return
	endif
	let s:initialized = 1

	" TODO default format
	call modestatus#parts#add('loclist_errors', 'modestatus#extensions#loclist#errors')
	call modestatus#parts#add('loclist_warnings', 'modestatus#extensions#loclist#warnings')
endfunction

function! s:loclist_types(nr, type) abort
	let loclist = getloclist(a:nr)
	let num_types = 0
	for i in loclist
		if i.type == a:type
			let num_types += 1
		endif
	endfor
	if num_types > 0
		return num_types
	else
		return ''
	endif
endfunction

function! modestatus#extensions#loclist#errors(nr) abort
	return s:loclist_types(a:nr, 'E')
endfunction

function! modestatus#extensions#loclist#warnings(nr) abort
	return s:loclist_types(a:nr, 'W')
endfunction
