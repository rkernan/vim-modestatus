function! modestatus#statusline(nr)
	let active = a:nr == winnr()
	let bufnum = winbufnr(a:nr)

	let filename = bufname(bufnum)
	if has_key(g:modestatus#filename_replace, filename)
		let filename = g:modestatus#filename_replace[filename]
	endif

	let buftype = getbufvar(bufnum, '&buftype')
	if buftype ==# 'help'
		let filename = 'help'
	endif

	function! Color(active, num, content)
		if a:active && a:num != 0
			return '%' . a:num . '*' . a:content . '%*'
		else
			return a:content
		endif
	endfunction

	function! LeftSectionWithSpacer(content, ...)
		let pad = a:0 == 1 ? a:1 : ' '
		if len(a:content)
			return a:content . pad
		else
			return ''
		endif
	endfunction

	function! RightSectionWithSpacer(content, ...)
		let pad = a:0 == 1 ? a:1 : ' '
		if len(a:content)
			return ' ' . a:content
		else
			return ''
		endif
	endfunction

	" TODO(2014-08-27) Customizable statusline.
	let statusline = ' '
	if active
		" line percent
		let statusline .= LeftSectionWithSpacer(modestatus#util#pad_before(
			\   '(' . string(float2nr(round((line('.') * 1.0) / (line('$') * 1.0) * 100.0))),
			\ 4) . '%%)')
		" line:column
		let statusline .= LeftSectionWithSpacer(modestatus#util#pad_before(line('.'), strlen(line('$'))) .
			\ ':' . modestatus#util#pad_after(virtcol('.'), 3))
		" mode
		let statusline .= Color(active, 2, LeftSectionWithSpacer('‹' . g:modestatus#mode_map[mode()] . '›'))
	endif
	" filename
	let statusline .= Color(active, 1, LeftSectionWithSpacer(filename))
	" modified
	let modified = getbufvar(bufnum, '&modified')
	let statusline .= Color(active, 3, LeftSectionWithSpacer(modified ? '+' : ''))
	" readonly
	let readonly = getbufvar(bufnum, '&readonly')
	let statusline .= Color(active, 3, LeftSectionWithSpacer(readonly ? '‼' : ''))
	" paste
	if active && &paste
		let statusline .= Color(active, 3, LeftSectionWithSpacer(active, 3, 'P'))
	endif
	" filetype and encoding
	let filetype = getbufvar(bufnum, '&filetype')
	let statusline .= LeftSectionWithSpacer(len(filetype) ? '[' . filetype . ']' : '')
	let encoding = getbufvar(bufnum, '&encoding')
	let encoding = len(encoding) ? encoding . ':' : ''
	let fileformat = getbufvar(bufnum, '&fileformat')
	let statusline .= LeftSectionWithSpacer(len(encoding) || len(fileformat) ? '[' . encoding . fileformat . ']' : '')
	" errors
	let statusline .= LeftSectionWithSpacer(Color(active, 8, modestatus#loclist#errors(a:nr)), '')
	let statusline .= LeftSectionWithSpacer(Color(active, 9, modestatus#loclist#warnings(a:nr)), '')
	let statusline .= '%='
	let statusline .= ' '
	return statusline
endfunction

function! modestatus#update()
	for nr in range(1, winnr('$'))
		call setwinvar(nr, '&statusline', '%!modestatus#statusline(' . nr . ')')
	endfor
endfunction
