function! modestatus#parts#core#init()
	call modestatus#parts#add('bomb', 'modestatus#parts#core#bomb')
	call modestatus#parts#add('bufnr', 'modestatus#parts#core#bufnr')
	call modestatus#parts#add('buftype', 'modestatus#parts#core#buftype')
	call modestatus#parts#add('column', 'modestatus#parts#core#column')
	call modestatus#parts#add('column_max', 'modestatus#parts#core#column_max')
	call modestatus#parts#add('encoding', 'modestatus#parts#core#encoding')
	call modestatus#parts#add('fileformat', 'modestatus#parts#core#fileformat')
	call modestatus#parts#add('filename', 'modestatus#parts#core#filename')
	call modestatus#parts#add('filesize', 'modestatus#parts#core#filesize')
	call modestatus#parts#add('filetype', 'modestatus#parts#core#filetype')
	call modestatus#parts#add('line', 'modestatus#parts#core#line')
	call modestatus#parts#add('line_max', 'modestatus#parts#core#line_max')
	call modestatus#parts#add('line_percent', 'modestatus#parts#core#line_percent')
	call modestatus#parts#add('mode', 'modestatus#parts#core#mode')
	call modestatus#parts#add('modified', 'modestatus#parts#core#modified')
	call modestatus#parts#add('paste', 'modestatus#parts#core#paste')
	call modestatus#parts#add('readonly', 'modestatus#parts#core#readonly')
	call modestatus#parts#add('virtcol', 'modestatus#parts#core#virtcol')
	call modestatus#parts#add('virtcol_max', 'modestatus#parts#core#virtcol_max')

	call modestatus#options#add('fileformat', 'format', '[%s]', v:false)
	call modestatus#options#add('filetype', 'format', '[%s]', v:false)
	call modestatus#options#add('encoding', 'format', '[%s]', v:false)
	
	if !exists('g:modestatus#parts#core#modified_symbol')
		let g:modestatus#parts#core#modified_symbol = '+'
	endif

	if !exists('g:modestatus#parts#core#mode_symbols')
		let g:modestatus#parts#core#mode_symbols = {
			\ 'n': 'N',
			\ 'i': 'I',
			\ 'R': 'R',
			\ 'v': 'V', 
			\ 'V': 'V',
			\ "\<c-v>": 'V',
			\ 'c': 'C',
			\ 's': 'S',
			\ 'S': 'S',
			\ "\<c-s>": 'S'}
	endif

	if !exists('g:modestatus#parts#core#paste_symbol')
		let g:modestatus#parts#core#paste_symbol = 'P'
	endif

	if !exists('g:modestatus#parts#core#readonly_symbol')
		let g:modestatus#parts#core#readonly_symbol = 'RO'
	endif
endfunction

function! modestatus#parts#core#bomb(nr)
	return &bomb ? 'bomb' : ''
endfunction

function! modestatus#parts#core#bufnr(nr)
	return bufnr('%')
endfunction

function! modestatus#parts#core#buftype(nr)
	return &buftype
endfunction

function! modestatus#parts#core#column(nr)
	if winnr() != a:nr
		return ''
	endif
	return col('.')
endfunction

function! modestatus#parts#core#column_max(nr)
	if winnr() != a:nr
		return ''
	endif
	return max(map(range(1, line('$')), "col([v:val, '$'])"))
endfunction

function! modestatus#parts#core#encoding(nr)
	return &encoding
endfunction

function! modestatus#parts#core#fileformat(nr)
	return &fileformat
endfunction

function! modestatus#parts#core#filename(nr)
	return bufname('%')
endfunction

function! modestatus#parts#core#filesize(nr)
	let size = getfsize(expand(@%))
	if size == 0 || size == -1 || size == -1
		return ''
	elseif size < 1024
		return size . 'B'
	elseif size < 1024 * 1024
		return printf('%.1f', size / 1024.0) . 'KB'
	elseif size < 1024 * 1024 * 1024
		return printf('%.1f', size / 1024.0 / 1024.0) . 'MB'
	else
		return printf('%.1f', size / 1024.0 / 1024.0 / 1024.0) . 'GB'
	endif
endfunction

function! modestatus#parts#core#filetype(nr)
	return &filetype
endfunction

function! modestatus#parts#core#line(nr)
	if winnr() != a:nr
		return ''
	endif
	return line('.')
endfunction

function! modestatus#parts#core#line_max(nr)
	if winnr() != a:nr
		return ''
	endif
	return line('$')
endfunction

function! modestatus#parts#core#line_percent(nr)
	if winnr() != a:nr
		return ''
	endif
	return float2nr(round((line('.') * 1.0) / (line('$') * 1.0) * 100.0)) . '%'
endfunction

function! modestatus#parts#core#mode(nr)
	if winnr() != a:nr
		return ''
	endif
	return g:modestatus#parts#core#mode_symbols[mode()]
endfunction

function! modestatus#parts#core#modified(nr)
	return &modified ? g:modestatus#parts#core#modified_symbol : ''
endfunction

function! modestatus#parts#core#paste(nr)
	return &paste ? g:modestatus#parts#core#paste_symbol : ''
endfunction

function! modestatus#parts#core#readonly(nr)
	return &readonly ? g:modestatus#parts#core#readonly_symbol : ''
endfunction

function! modestatus#parts#core#virtcol(nr)
	if winnr() != a:nr
		return ''
	endif
	return virtcol('.')
endfunction

function! modestatus#parts#core#virtcol_max(nr)
	if winnr() != a:nr
		return ''
	endif
	return max(map(range(1, line('$')), "virtcol([v:val, '$'])"))
endfunction
