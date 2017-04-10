let s:initialized = 0

function! modestatus#extensions#core#init()
	if s:initialized
		return
	endif
	let s:initialized = 1

	call modestatus#util#check_defined('g:modestatus#extensions#core#mode_symbols', {})
	call extend(g:modestatus#extensions#core#mode_symbols, {
		\   'n':      'N',
		\   'i':      'I',
		\   'R':      'R',
		\   'v':      'V',
		\   'V':      'V',
		\   "\<c-v>": 'V',
		\   'c':      'C',
		\   's':      'S',
		\   'S':      'S',
		\   "\<c-s>": 'S',
		\   '?':      '?'
		\ }, 'keep')

	call modestatus#parts#add('line_percent', 'modestatus#extensions#core#line_percent')
	call modestatus#parts#add('line', 'modestatus#extensions#core#line')
	call modestatus#parts#add('max_line', 'modestatus#extensions#core#max_line')
	call modestatus#parts#add('column', 'modestatus#extensions#core#column')
	call modestatus#parts#add('max_column', 'modestatus#extensions#core#max_column')
	call modestatus#parts#add('position', 'modestatus#extensions#core#position')
	call modestatus#parts#add('filename', 'modestatus#extensions#core#filename')
	call modestatus#parts#add('filetype', 'modestatus#extensions#core#filetype')
	call modestatus#parts#add('buftype', 'modestatus#extensions#core#buftype')
	call modestatus#parts#add('encoding', 'modestatus#extensions#core#encoding')
	call modestatus#parts#add('fileformat', 'modestatus#extensions#core#fileformat')
	call modestatus#parts#add('modified', 'modestatus#extensions#core#modified')
	call modestatus#parts#add('readonly', 'modestatus#extensions#core#readonly')
	call modestatus#parts#add('paste', 'modestatus#extensions#core#paste')
	call modestatus#parts#add('mode', 'modestatus#extensions#core#mode')
	
	call modestatus#options#add('modified', {'common': {'format': '+'}}, 'keep')
	call modestatus#options#add('paste', {'common': {'format': 'P'}}, 'keep')
	call modestatus#options#add('readonly', {'common': {'format': 'RO'}}, 'keep')
endfunction

function! modestatus#extensions#core#line_percent(nr) abort
	if a:nr == winnr()
		return modestatus#util#pad_before(string(float2nr(round((line('.') * 1.0) / (line('$') * 1.0) * 100.0))), 3) . '%%'
	else
		return ''
	endif
endfunction

function! modestatus#extensions#core#line(nr) abort
	if a:nr == winnr()
		return string(line('.'))
	else
		return ''
	endif
endfunction

function! modestatus#extensions#core#max_line(nr) abort
	if a:nr == winnr()
		return string(line('$'))
	else
		return ''
	endif
endfunction

function! modestatus#extensions#core#column(nr) abort
	if a:nr == winnr()
		return string(virtcol('.'))
	else
		return ''
	endif
endfunction

function! modestatus#extensions#core#max_column(nr) abort
	if a:nr == winnr()
		return max(map(range(1, line('$')), "virtcol([v:val, '$'])"))
	else
		return ''
	endif
endfunction

function! modestatus#extensions#core#position(nr) abort
	if a:nr == winnr()
		let linenum = line('.')
		let colnum = virtcol('.')
		let max_colnum = max(map(range(1, line('$')), "virtcol([v:val, '$'])"))
		return modestatus#util#pad_before(linenum, strlen(line('$'))) . ',' . modestatus#util#pad_after(colnum, len(max_colnum))
	else
		return ''
	endif
endfunction

function! modestatus#extensions#core#filename(nr) abort
	return bufname(winbufnr(a:nr))
endfunction

function! modestatus#extensions#core#filetype(nr) abort
	return getbufvar(winbufnr(a:nr), '&filetype')
endfunction

function! modestatus#extensions#core#buftype(nr) abort
	return getbufvar(winbufnr(a:nr), '&buftype')
endfunction

function! modestatus#extensions#core#encoding(nr) abort
	return getbufvar(winbufnr(a:nr), '&encoding')
endfunction

function! modestatus#extensions#core#fileformat(nr) abort
	return getbufvar(winbufnr(a:nr), '&fileformat')
endfunction

function! modestatus#extensions#core#modified(nr) abort
	return getbufvar(winbufnr(a:nr), '&modified') ? v:true : v:false
endfunction

function! modestatus#extensions#core#readonly(nr) abort
	return getbufvar(winbufnr(a:nr), '&readonly') ? v:true : v:false
endfunction

function! modestatus#extensions#core#paste(nr) abort
	return &paste ? v:true : v:false
endfunction

function! modestatus#extensions#core#mode(nr) abort
	return g:modestatus#extensions#core#mode_symbols[mode()]
endfunction
