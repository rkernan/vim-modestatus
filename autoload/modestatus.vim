function! modestatus#statusline(nr)

	function! Section(nr, key, side)
		if modestatus#parts#has(a:key)
			let content = {modestatus#parts#get(a:key)}(a:nr)
			let separator = g:modestatus#default_separator

			" apply options
			if modestatus#options#has(a:key) && len(content)
				let options = modestatus#options#get(a:key)
				let options = extend(options['common'], options[a:nr == winnr() ? 'active' : 'inactive'], 'force')

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
			if a:side ==# 'left'
				let content = modestatus#util#suffix(content, separator)
			else
				let content = modestatus#util#prefix(content, separator)
			endif

			return content
		else
			return ''
		endtry
	endfunction

	function! LeftSection(nr, key)
		return Section(a:nr, a:key, 'left')
	endfunction

	function! RightSection(nr, key)
		return Section(a:nr, a:key, 'right')
	endfunction

	let statusline  = ''
	for part in g:modestatus#statusline[a:nr == winnr() ? 'active' : 'inactive'].left
		let statusline .= LeftSection(a:nr, part)
	endfor

	let statusline .= '%='
	for part in g:modestatus#statusline[a:nr == winnr() ? 'active' : 'inactive'].right
		let statusline .= RightSection(a:nr, part)
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
