function! modestatus#statusline(nr)

	function! Section(nr, key, side)
		if modestatus#parts#has(a:key)
			let func = modestatus#parts#get(a:key)
			let content = {modestatus#parts#get(a:key)}(a:nr)
			let nosep = 0
			" apply options
			if modestatus#options#has(a:key) && len(content)
				let options = modestatus#options#get(a:key)[a:nr == winnr() ? 'active' : 'inactive']
				" format the part
				if has_key(options, 'format')
					let content = printf(options['format'], content)
				endif
				" add a separator
				if has_key(options, 'nosep') && options['nosep']
					let nosep = 1
				endif
				" color the part
				if has_key(options, 'color')
					if modestatus#colors#has(options['color'])
						let content = '%' . modestatus#colors#get(options['color']) . '*' . content . '%*'
					endif
				endif
			endif
			" add separator (if it hasnt been added already)
			if !nosep
				if a:side ==# 'left'
					let content = modestatus#util#postfix(content, ' ')
				else
					let content = modestatus#util#prefix(content, ' ')
				endif
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
	for p in g:modestatus#statusline[a:nr == winnr() ? 'active' : 'inactive'].left
		let statusline .= LeftSection(a:nr, p)
	endfor
	let statusline .= '%='
	for p in g:modestatus#statusline[a:nr == winnr() ? 'active' : 'inactive'].right
		let statusline .= RightSection(a:nr, p)
	endfor

	return statusline
endfunction

function! modestatus#update()
	for nr in range(1, winnr('$'))
		call setwinvar(nr, '&statusline', '%!modestatus#statusline(' . nr . ')')
	endfor
endfunction
