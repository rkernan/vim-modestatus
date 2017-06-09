function! modestatus#format(part, format)
	if len(a:part) > 0
		return printf(a:format, a:part)
	else
		return ''
	endif
endfunction

function! modestatus#colorize(active_win, part, color)
	if type(a:color) == v:t_list
		let part  = '%#' . a:color[0] . '#%{winnr()==' . a:active_win . '?' . a:part . ':""}%*'
		let part .= '%#' . a:color[1] . '#%{winnr()!=' . a:active_win . '?' . a:part . ':""}%*'
		return part
	else
		return '%#' . a:color . '#%{' . a:part . '}%*'
	endif
endfunction

function! modestatus#statusline_part(active_win, part, side)
	if modestatus#parts#has(a:part)
		" format
		let format = modestatus#options#has(a:part, 'format') ? modestatus#options#get(a:part, 'format') : '%s'
		if a:side ==# 'left'
			let separator = modestatus#options#has(a:part, 'separator') ? modestatus#options#get(a:part, 'separator') : g:modestatus#statusline_separator_left
			let format = separator . format
		elseif a:side ==# 'right'
			let separator = modestatus#options#has(a:part, 'separator') ? modestatus#options#get(a:part, 'separator') : g:modestatus#statusline_separator
			let format = format . separator
		endif
		let part = 'modestatus#format(' . modestatus#parts#get(a:part) . '(' . a:active_win . '),"' . format . '")'
		" color
		if modestatus#options#has(a:part, 'color')
			let part = modestatus#colorize(a:active_win, part, modestatus#options#get(a:part, 'color'))
		else
			let part = '%{' . part . '}'
		endif
		return part
	else
		return a:part
	endif
endfunction

function! modestatus#statusline(active_win, ...)
	" override
	if a:0 == 1
		let statusline_parts = g:modestatus#statusline_override_{a:1}
	else
		let statusline_parts = g:modestatus#statusline
	endif
	" build the statusline
	let statusline  = ''
	let side = 'left'
	for part in statusline_parts
		if part ==# '%='
			let side = 'right'
		endif
		let statusline .= modestatus#statusline_part(a:active_win, part, side)
	endfor
	return statusline
endfunction

function! modestatus#set()
	let &g:statusline='%!modestatus#statusline(winnr())'
endfunction

function! modestatus#setlocal(...)
	if a:0 == 1
		let &l:statusline='%!modestatus#statusline(winnr(),"' . a:1 . '")'
	else
		let &l:statusline='%!modestatus#statusline(winnr())'
	endif
endfunction
