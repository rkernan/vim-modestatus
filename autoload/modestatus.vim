function! modestatus#format(part, format)
	if len(a:part) > 0
		return printf(a:format, a:part)
	else
		return ''
	endif
endfunction

function! modestatus#statusline_part(nr, part, right_side)
	if modestatus#parts#has(a:part)
		let format = modestatus#options#has(a:part, 'format') ? modestatus#options#get(a:part, 'format') : '%s'
		let separator = modestatus#options#has(a:part, 'separator') ? modestatus#options#get(a:part, 'separator') : g:modestatus#statusline_separator
		if a:right_side
			let format = separator . format
		else
			let format = format . separator
		endif
		let part = '%{modestatus#format(' . modestatus#parts#get(a:part) . '(' . a:nr . '), "' . format . '")}'
		if modestatus#options#has(a:part, 'color')
			" colorize the part
			let part = '%#' . modestatus#options#get(a:part, 'color') . '#' . part . '%*'
		endif
		return part
	else
		return a:part
	endif
endfunction

function! modestatus#statusline(nr, ...)
	let statusline  = ''
	let right_side = v:false
	let statusline_parts = g:modestatus#statusline
	if a:0 == 1
		let statusline_parts = g:modestatus#statusline_override_{a:1}
	endif
	for part in statusline_parts
		let statusline .= modestatus#statusline_part(a:nr, part, right_side)
		if part ==# '%='
			let right_side = v:true
		endif
	endfor
	return statusline
endfunction
