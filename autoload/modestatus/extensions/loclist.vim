if exists('g:modestatus#extensions#loclist#loaded')
	finish
endif

" TODO(2014-08-27)
call modestatus#util#check_defined('g:modestatus#extensions#loclist#message', {})
call extend(g:modestatus#extensions#loclist#message, {
	\   'error': 'E: %d',
	\   'warning': 'W: %d'
	\ }, 'keep')

let modestatus#extensions#loclist#loaded = 1

function! s:loclist_types(nr, type, fmt)
	let loclist = getloclist(a:nr)
	let num_types = 0
	for i in loclist
		if i.type == a:type
			let num_types += 1
		endif
	endfor
	if num_types > 0
		return printf(a:fmt, num_types)
	else
		return ''
	endif
endfunction

function! modestatus#extensions#loclist#errors(nr)
	return s:loclist_types(a:nr, 'E', g:modestatus#extensions#loclist#message.error)
endfunction

function! modestatus#extensions#loclist#warnings(nr)
	return s:loclist_types(a:nr, 'W', g:modestatus#extensions#loclist#message.warning)
endfunction
