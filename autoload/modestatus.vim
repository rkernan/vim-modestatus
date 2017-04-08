function! modestatus#section(nr, part, side, is_active)
	if modestatus#parts#has(a:part)
		let content = {modestatus#parts#get(a:part)}(a:nr)
		let separator = g:modestatus#default_separator

		" apply options
		if modestatus#options#has(a:part) && len(content)
			let options = modestatus#options#get_concat(a:part, a:is_active)

			" check if the part should be truncated
			if has_key(options, 'min_winwidth')
				let winwidth = winwidth(a:nr)
				if winwidth < options['min_winwidth']
					return ''
				endif
			endif

			" format the part
			if has_key(options, 'format')
				let content = printf(options['format'], content)
			endif

			" get separator
			if has_key(options, 'separator')
				let separator = options['separator']
			endif

			" color the part
			if has_key(options, 'color')
				let content = '%#' . options['color'] . '#' . content . '%*'
			endif
		endif

		" add separator
		if a:side == 'left'
			let content = modestatus#util#suffix(content, separator)
		else
			let content = modestatus#util#prefix(content, separator)
		endif

		return content
	else
		return ''
	endif
endfunction

function! modestatus#statusline(nr)
	let statusline_parts = g:modestatus#statusline[a:nr == winnr() ? 'active' : 'inactive']
	if has_key(g:modestatus#statusline_override, getbufvar(winbufnr(a:nr), '&filetype'))
		let statusline_parts = g:modestatus#statusline_override[getbufvar(winbufnr(a:nr), '&filetype')][a:nr == winnr() ? 'active' : 'inactive']
	endif
	call extend(statusline_parts, {'left': []}, 'keep')
	call extend(statusline_parts, {'right': []}, 'keep')

	let statusline  = ''

	for part in statusline_parts['left']
		let statusline .= modestatus#section(a:nr, part, 'left', (a:nr == winnr()))
	endfor

	let statusline .= '%='

	for part in statusline_parts['right']
		let statusline .= modestatus#section(a:nr, part, 'right', (a:nr == winnr()))
	endfor

	return statusline
endfunction

function! modestatus#update()
	for nr in range(1, winnr('$'))
		if index(g:modestatus#disable_filetypes, getbufvar(winbufnr(nr), '&filetype')) < 0
			call setwinvar(nr, '&statusline', '%!modestatus#statusline(' . nr . ')')
		endif
	endfor
endfunction
