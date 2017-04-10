function! modestatus#section(nr, part, side, is_active)
	if modestatus#parts#has(a:part)
		let content = {modestatus#parts#get(a:part)}(a:nr)

		" apply options
		if modestatus#options#has(a:part)
			let separator = g:modestatus#default_separator
			let options = modestatus#options#get_concat(a:part, a:is_active)

			if content == v:false
				return ''
			elseif type(content) != v:t_bool && len(content) == 0
				return ''
			endif

			" check if the part should be truncated
			if has_key(options, 'min_winwidth')
				let winwidth = winwidth(a:nr)
				if winwidth < options['min_winwidth']
					return ''
				endif
			endif

			" format the part
			if has_key(options, 'format')
				if content == v:true
					let content = options['format']
				else
					let content = printf(options['format'], content)
				endif
			elseif type(content) == v:t_bool
				throw printf('On/off part %s must have format', a:part)
			endif

			" get separator
			if has_key(options, 'separator')
				let separator = options['separator']
			endif

			if type(content) != v:t_string
				" if the content isn't a string yet it never will be
				return ''
			endif

			" color the part
			if has_key(options, 'color')
				let content = '%#' . options['color'] . '#' . content . '%*'
			endif
		endif

		" add separator
		if a:side ==# 'left'
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
		call setwinvar(nr, '&statusline', '%!modestatus#statusline(' . nr . ')')
	endfor
endfunction
