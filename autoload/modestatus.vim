function! modestatus#refresh(nr)
	let active = a:nr == winnr()
	let bufnum = winbufnr(a:nr)

	let buftype = getbufvar(bufnum, '&buftype')
	let bufname = bufname(bufnum)
	" TODO(2014-08-26) Change buffer names based on dictionary values.

	function! Color(active, num, content)
		if a:active
			return '%' . a:num . '*' . a:content . '%*'
		else
			return a:content
		endif
	endfunction

	let statusline = ''
	" TODO(2014-08-26) Paste
	" TODO(2014-08-26) Spellcheck
	if active
		let statusline .= ' '
		let statusline .= '<' . g:modestatus#mode_map[mode()] . '>'
		let statusline .= ' '
		let statusline .= modestatus#util#pad_before(
			\   '(' . string(float2nr(round((line('.') * 1.0) / (line('$') * 1.0) * 100.0))),
			\ 4) . '%%)'
		let statusline .= ' '
		let statusline .= modestatus#util#pad_before(line('.'), strlen(line('$'))) .
			\ ':' . modestatus#util#pad_after(virtcol('.'), 3)
	endif
	let statusline .= ' '
	let statusline .= '%f' " filename
	let modified = getbufvar(bufnum, '&modified')
	let statusline .= Color(active, 1, modified ? ' +' : '')
	let readonly = getbufvar(bufnum, '&readonly')
	let statusline .= Color(active, 1, readonly ? ' ‼' : '')
	let statusline .= ' '
	let filetype = getbufvar(bufnum, '&filetype')
	let fileformat = getbufvar(bufnum, '&fileformat')
	let encoding = getbufvar(bufnum, '&encoding')
	let statusline .= '[' . filetype . ',' . fileformat . ',' . encoding . ']'
	let statusline .= '%='
	" let modestatus .= Color(active, 1, modestatus#loclist_errors(a:nr))
	" let modestatus .= Color(active, 2, modestatus#loclist_warnings(a:nr))
	return statusline
endfunction

function! modestatus#loclist_num_types(nr, type)
	let loclist = getloclist(a:nr)
	let num_types = 0
	for i in loclist
		if i.type == a:type
			let num_types += 1
		endif
	endfor
	return num_types
endfunction

function! modestatus#loclist_errors(nr)
	let num_errors = modestatus#loclist_num_types(a:nr, 'E')
	let error_str = ''
	if num_errors > 0
		let error_str .= ' E: ' . num_errors . ' '
	endif
	return error_str
endfunction

function! modestatus#loclist_warnings(nr)
	let num_warnings = modestatus#loclist_num_types(a:nr, 'W')
	let warning_str = ''
	if num_warnings > 0
		let warning_str .= ' W: ' . num_warnings . ' '
	endif
	return warning_str
endfunction

function! modestatus#update()
	for nr in range(1, winnr('$'))
		call setwinvar(nr, '&statusline', '%!modestatus#refresh(' . nr . ')')
	endfor
endfunction
