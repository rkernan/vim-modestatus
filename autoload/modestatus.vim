function! modestatus#format(part, format)
	if len(a:part) > 0
		return printf(a:format, a:part)
	else
		return ''
	endif
endfunction

function! modestatus#statusline_part(nr, part, add_separator)
	if modestatus#parts#has(a:part)
		let format = modestatus#options#has(a:part, 'format') ? modestatus#options#get(a:part, 'format') : '%s'
		if a:add_separator
			let separator = modestatus#options#has(a:part, 'separator') ? modestatus#options#get(a:part, 'separator') : g:modestatus#statusline_separator
			let format = format . separator
		endif
		let raw_part = '%{modestatus#format(' . modestatus#parts#get(a:part) . '(' . a:nr . '), "' . format . '")}'
		if modestatus#options#has(a:part, 'color')
			" colorize the part
			let raw_part = '%#' . modestatus#options#get(a:part, 'color') . '#' . raw_part . '%*'
		endif
		return raw_part
	else
		return a:part
	endif
endfunction

function! modestatus#statusline(nr, ...)
	" override
	if a:0 == 1
		let statusline_parts = g:modestatus#statusline_override_{a:1}
	else
		let statusline_parts = g:modestatus#statusline
	endif
	" build the statusline
	let statusline  = ''
	if len(statusline_parts)
		for part in statusline_parts[0:-2]
			let statusline .= modestatus#statusline_part(a:nr, part, 1)
		endfor
		let statusline .= modestatus#statusline_part(a:nr, statusline_parts[-1], 0)
	endif
	return statusline
endfunction
