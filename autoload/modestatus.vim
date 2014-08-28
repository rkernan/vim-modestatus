function! modestatus#statusline(nr)
	let active = a:nr == winnr()
	let bufnum = winbufnr(a:nr)

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
	let statusline .= LeftSectionWithSpacer(modestatus#extensions#core#line_percent(a:nr))
	let statusline .= LeftSectionWithSpacer(modestatus#extensions#core#position(a:nr))
	let statusline .= Color(active, 2, LeftSectionWithSpacer(modestatus#util#surround(modestatus#extensions#core#mode(a:nr), '‹', '›')))
	let statusline .= Color(active, 1, LeftSectionWithSpacer(modestatus#extensions#core#filename(a:nr)))
	let statusline .= Color(active, 3, LeftSectionWithSpacer(modestatus#extensions#core#modified(a:nr)))
	let statusline .= Color(active, 3, LeftSectionWithSpacer(modestatus#extensions#core#readonly(a:nr)))
	let statusline .= Color(active, 3, LeftSectionWithSpacer(modestatus#extensions#core#paste(a:nr)))
	let statusline .= LeftSectionWithSpacer(modestatus#util#surround(modestatus#extensions#core#filetype(a:nr), '[', ']'))
	let statusline .= LeftSectionWithSpacer(modestatus#util#surround(modestatus#extensions#core#encoding_and_format(a:nr), '[', ']'))
	let statusline .= LeftSectionWithSpacer(Color(active, 8, modestatus#util#surround(modestatus#extensions#loclist#errors(a:nr), ' ')), '')
	let statusline .= LeftSectionWithSpacer(Color(active, 9, modestatus#util#surround(modestatus#extensions#loclist#warnings(a:nr), ' ')), '')
	let statusline .= '%='
	let statusline .= ' '
	return statusline
endfunction

function! modestatus#update()
	for nr in range(1, winnr('$'))
		call setwinvar(nr, '&statusline', '%!modestatus#statusline(' . nr . ')')
	endfor
endfunction
