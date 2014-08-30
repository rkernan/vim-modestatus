let s:initialized = 0

function! modestatus#extensions#core#init()
	if s:initialized
		return
	endif
	let s:initialized = 1

	call modestatus#util#check_defined('g:modestatus#extensions#core#filename_override', {})
	call modestatus#util#check_defined('g:modestatus#extensions#core#symbols', {})
	call extend(g:modestatus#extensions#core#symbols, {'modes': {}}, 'keep')
	call extend(g:modestatus#extensions#core#symbols.modes, {
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
	call extend(g:modestatus#extensions#core#symbols, {'modified': '+'}, 'keep')
	call extend(g:modestatus#extensions#core#symbols, {'readonly': '‼'}, 'keep')
	call extend(g:modestatus#extensions#core#symbols, {'paste': 'P'}, 'keep')

	call modestatus#parts#add('line_percent', 'modestatus#extensions#core#line_percent')
	call modestatus#parts#add('position', 'modestatus#extensions#core#position')
	call modestatus#parts#add('filename', 'modestatus#extensions#core#filename')
	call modestatus#parts#add('filetype', 'modestatus#extensions#core#filetype')
	call modestatus#parts#add('encoding', 'modestatus#extensions#core#encoding')
	call modestatus#parts#add('fileformat', 'modestatus#extensions#core#fileformat')
	call modestatus#parts#add('modified', 'modestatus#extensions#core#modified')
	call modestatus#parts#add('readonly', 'modestatus#extensions#core#readonly')
	call modestatus#parts#add('paste', 'modestatus#extensions#core#paste')
	call modestatus#parts#add('mode', 'modestatus#extensions#core#mode')
endfunction

function! modestatus#extensions#core#line_percent(nr)
	if a:nr == winnr()
		return modestatus#util#pad_before(string(float2nr(round((line('.') * 1.0) / (line('$') * 1.0) * 100.0))), 3) . '%%'
	else
		return ''
	endif
endfunction

function! modestatus#extensions#core#position(nr)
	if a:nr == winnr()
		let linenum = line('.')
		let colnum = virtcol('.')
		let max_colnum = max(map(range(1, line('$')), "virtcol([v:val, '$'])"))
		return modestatus#util#pad_before(linenum, strlen(line('$'))) . ',' . modestatus#util#pad_after(colnum, len(max_colnum))
	else
		return ''
	endif
endfunction

function! modestatus#extensions#core#filename(nr)
	let filename = bufname(winbufnr(a:nr))
	let filetype = getbufvar(winbufnr(a:nr), '&filetype')
	if has_key(g:modestatus#extensions#core#filename_override, filename)
		let filename = g:modestatus#extensions#core#filename_override[filename]
	elseif has_key(g:modestatus#extensions#core#filetype_override, filetype)
		let filename = g:modestatus#extensions#core#filetype_override[filetype]
	endif
	return filename
endfunction

function! modestatus#extensions#core#filetype(nr)
	return getbufvar(winbufnr(a:nr), '&filetype')
endfunction

function! modestatus#extensions#core#encoding(nr)
	return getbufvar(winbufnr(a:nr), '&encoding')
endfunction

function! modestatus#extensions#core#fileformat(nr)
	return getbufvar(winbufnr(a:nr), '&fileformat')
endfunction

function! modestatus#extensions#core#modified(nr)
	return getbufvar(winbufnr(a:nr), '&modified') ? g:modestatus#extensions#core#symbols.modified : ''
endfunction

function! modestatus#extensions#core#readonly(nr)
	return getbufvar(winbufnr(a:nr), '&readonly') ? g:modestatus#extensions#core#symbols.readonly : ''
endfunction

function! modestatus#extensions#core#paste(nr)
	if &paste
		return g:modestatus#extensions#core#symbols.paste
	else
		return ''
	endif
endfunction

function! modestatus#extensions#core#mode(nr)
	return g:modestatus#extensions#core#symbols.modes[mode()]
endfunction
