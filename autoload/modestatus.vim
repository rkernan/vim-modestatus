function! modestatus#format(part, format)
	if len(a:part) > 0
		return printf(a:format, a:part)
	else
		return ''
	endif
endfunction

function! modestatus#colorize(active_win, part, color)
	if type(a:color) == v:t_list
		return '%#' . a:color[0] . '#%{winnr()==' . a:active_win . '?' . a:part . ':""}' .
			\ '%#' . a:color[1] . '#%{winnr()!=' . a:active_win . '?' . a:part . ':""}'
	else
		return '%#' . a:color . '#%{' . a:part . '}'
	endif
endfunction

function! modestatus#statusline_part(active_win, part, first)
	if modestatus#parts#has(a:part)
		" format
		let format = (a:first ? '  ' : '') .
			\ (modestatus#options#has(a:part, 'format') ? modestatus#options#get(a:part, 'format') : '%s') .
			\ (modestatus#options#has(a:part, 'separator') ? (!modestatus#options#get(a:part, 'separator') ? '' : ' ') : ' ')
		let part = 'modestatus#format(' . modestatus#parts#get(a:part) . '(' . a:active_win . '),"' . format . '")'
		" color
		if modestatus#options#has(a:part, 'color')
			let part = modestatus#colorize(a:active_win, part, modestatus#options#get(a:part, 'color'))
		else
			let part = '%{' . part . '}'
		endif
		return part . '%*'
	else
		return a:part
	endif
endfunction

function! modestatus#statusline_section(active_win, parts)
	let statusline = ''
	let first = 1
	for part in a:parts
		if type(part) == v:t_list
			let statusline .= modestatus#statusline_section(a:active_win, part)
		else
			let statusline .= modestatus#statusline_part(a:active_win, part, first)
			let first = 0
		endif
	endfor
	return statusline
endfunction

function! modestatus#statusline(active_win, ...)
	" override
	if a:0 == 1
		let parts = g:modestatus#statusline_override_{a:1}
	else
		let parts = g:modestatus#statusline
	endif
	return modestatus#statusline_section(a:active_win, parts)
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
