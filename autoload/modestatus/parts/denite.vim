function! modestatus#parts#denite#init()
	call modestatus#parts#add('denite_line', 'modestatus#parts#denite#line')
	call modestatus#parts#add('denite_line_max', 'modestatus#parts#denite#line_max')
	call modestatus#parts#add('denite_line_percent', 'modestatus#parts#denite#line_percent')
	call modestatus#parts#add('denite_mode', 'modestatus#parts#denite#mode')
	call modestatus#parts#add('denite_path', 'modestatus#parts#denite#path')
	call modestatus#parts#add('denite_sources', 'modestatus#parts#denite#sources')

	if !exists('g:modestatus#parts#denite#mode_symbols')
		let g:modestatus#parts#denite#mode_symbols = {'-- INSERT -- ': 'I', '-- NORMAL -- ': 'N'}
	endif
endfunction

function! s:get_denite_linenr()
	let linenr = split(denite#get_status_linenr(), '/')
	return [str2nr(linenr[0]), str2nr(linenr[1])]
endfunction

function! modestatus#parts#denite#line(...)
	return s:get_denite_linenr()[0]
endfunction

function! modestatus#parts#denite#line_max(...)
	return s:get_denite_linenr()[1]
endfunction

function! modestatus#parts#denite#line_percent(...)
	let linenr = s:get_denite_linenr()
	let percent = (linenr[0] * 1.0) / (linenr[1] * 1.0) * 100.0
	if percent > 100.0
		let percent = 100.0
	endif
	return float2nr(round(percent)) . '%'
endfunction

function! modestatus#parts#denite#path(...)
	return denite#get_status_path()[1:-2]
endfunction

function! modestatus#parts#denite#mode(...)
	return g:modestatus#parts#denite#mode_symbols[denite#get_status_mode()]
endfunction

function! modestatus#parts#denite#sources(...)
	return denite#get_status_sources()[0:-2]
endfunction
