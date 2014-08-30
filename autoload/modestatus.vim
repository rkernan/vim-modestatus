function! modestatus#statusline(nr)

	function! Section(nr, key)
		try
			let func = modestatus#parts#get(a:key)
			let content = {modestatus#parts#get(a:key)}(a:nr)
			return content
		catch
			return ''
		endtry
	endfunction

	function! LeftSection(nr, key)
		return modestatus#util#postfix(Section(a:nr, a:key), ' ')
	endfunction

	function! RightSection(nr, key)
		return modestatus#util#prefix(Section(a:nr, a:key), ' ')
	endfunction

	let active = a:nr == winnr()
	let bufnum = winbufnr(a:nr)

	let statusline  = ''

	if active
		for p in g:modestatus#statusline.active.left
			let statusline .= LeftSection(a:nr, p)
		endfor
		let statusline .= '%='
		for p in g:modestatus#statusline.active.right
			let statusline .= RightSection(a:nr, p)
		endfor
	else
		for p in g:modestatus#statusline.inactive.left
			let statusline .= LeftSection(a:nr, p)
		endfor
		let statusline .= '%='
		for p in g:modestatus#statusline.inactive.right
			let statusline .= RightSection(a:nr, p)
		endfor
	endif

	return statusline
endfunction

function! modestatus#update()
	for nr in range(1, winnr('$'))
		call setwinvar(nr, '&statusline', '%!modestatus#statusline(' . nr . ')')
	endfor
endfunction
