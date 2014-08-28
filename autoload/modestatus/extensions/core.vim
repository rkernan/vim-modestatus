if exists('g:modestatus#extensions#core#loaded')
	finish
endif

call modestatus#util#check_defined('g:modestatus#extensions#core#filename_replace', {})
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

" TODO(2014-08-27)

let modestatus#extensions#core#loaded = 1

function! modestatus#extensions#core#filename(nr)
	let filename = bufname(winbufnr(a:nr))
	if has_key(g:modestatus#extensions#core#filename_replace, filename)
		return g:modestatus#extensions#core#filename_replace[filename]
	else
		return '%f'
	endif
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

function! modestatus#extensions#core#encoding_and_format(nr)
	let encoding = getbufvar(winbufnr(a:nr), '&encoding')
	let format = getbufvar(winbufnr(a:nr), '&fileformat')
	return modestatus#util#postfix(encoding, ',') . format
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
		" TODO(2014-08-28) performance
		let max_colnum = max(map(range(1, line('$')), "virtcol([v:val, '$'])"))
		return modestatus#util#pad_before(linenum, strlen(line('$'))) . ',' . modestatus#util#pad_after(colnum, len(max_colnum))
	else
		return ''
	endif
endfunction

function! modestatus#extensions#core#modified(nr)
	return getbufvar(winbufnr(a:nr), '&modified') ? g:modestatus#extensions#core#symbols.modified : ''
endfunction

function! modestatus#extensions#core#readonly(nr)
	return getbufvar(winbufnr(a:nr), '&readonly') ? g:modestatus#extensions#core#symbols.readonly : ''
endfunction

function! modestatus#extensions#core#paste(nr)
	if a:nr == winnr() && &paste
		return g:modestatus#extensions#core#symbols.paste
	else
		return ''
	endif
endfunction

function! modestatus#extensions#core#mode(nr)
	if a:nr == winnr()
		return g:modestatus#extensions#core#symbols.modes[mode()]
	else
		return ''
	endif
endfunction
