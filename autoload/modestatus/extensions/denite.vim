let s:initialized = 0

function! modestatus#extensions#denite#init()
	if s:initialized
		return
	endif
	let s:initialized = 1

	call modestatus#util#check_defined('g:modestatus#extensions#denite#symbols', {})
	call extend(g:modestatus#extensions#denite#symbols, {'modes': {}}, 'keep')
	call extend(g:modestatus#extensions#denite#symbols.modes, {'i': 'I', 'n': 'N', '?': '?'}, 'keep')

	call modestatus#parts#add('denite_line_percent', 'modestatus#extensions#denite#line_percent')
	call modestatus#parts#add('denite_line',         'modestatus#extensions#denite#line')
	call modestatus#parts#add('denite_max_line',     'modestatus#extensions#denite#max_line')
	call modestatus#parts#add('denite_mode',         'modestatus#extensions#denite#mode')
	call modestatus#parts#add('denite_sources',      'modestatus#extensions#denite#sources')
	call modestatus#parts#add('denite_path',         'modestatus#extensions#denite#path')
endfunction

function! modestatus#extensions#denite#mode(nr) abort
	let mode = getbufvar(winbufnr(a:nr), 'denite_statusline_mode')
	if mode =~ 'INSERT'
		let mode = 'i'
	elseif mode =~ 'NORMAL'
		let mode = 'n'
	else
		let mode = '?'
	endif
	return g:modestatus#extensions#denite#symbols.modes[mode]
endfunction

function! modestatus#extensions#denite#sources(nr) abort
	return getbufvar(winbufnr(a:nr), 'denite_statusline_sources')
endfunction

function! modestatus#extensions#denite#path(nr) abort
	return getbufvar(winbufnr(a:nr), 'denite_statusline_path')[1:-2]
endfunction

function! modestatus#extensions#denite#line(nr) abort
	return split(getbufvar(winbufnr(a:nr), 'denite_statusline_linenr'), '/')[0]
endfunction

function! modestatus#extensions#denite#max_line(nr) abort
	return split(getbufvar(winbufnr(a:nr), 'denite_statusline_linenr'), '/')[1]
endfunction

function! modestatus#extensions#denite#line_percent(nr) abort
	let linenr = split(getbufvar(winbufnr(a:nr), 'denite_statusline_linenr'), '/')
	let percent = str2float(linenr[0]) / str2float(linenr[1]) * 100.0
	if percent > 100.0
		let percent = 100.0
	endif
	return modestatus#util#pad_before(string(float2nr(round(percent))), 3) . '%%'
endfunction
