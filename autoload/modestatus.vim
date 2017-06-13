function! modestatus#part(part, format, first)
	if a:first
		let b:__modestatus_first = 1
	endif

	if strlen(a:part) > 0
		let part = (b:__modestatus_first ? '  ' : '') . printf(a:format, a:part)
		let b:__modestatus_first = 0
		return part
	else
		return ''
	endif
endfunction

function! s:format(first, part, format, separator)
	return 'modestatus#part(' . modestatus#parts#get(a:part) . '(),"' . a:format . a:separator . '",' . a:first . ')'
endfunction

function! s:on_active_only(active_win, part, active_only)
	if a:active_only
		return 'winnr()==' . a:active_win . '?' . a:part . ':""'
	else
		return a:part
	endif
endfunction

function! s:colorize(active_win, part, color)
	if empty(a:color)
		return '%{' . a:part . '}'
	elseif type(a:color) == v:t_list
		return '%#' . a:color[0] . '#%{winnr()==' . a:active_win . '?' . a:part . ':""}' .
			\ '%#' . a:color[1] . '#%{winnr()!=' . a:active_win . '?' . a:part . ':""}%*'
	else
		return '%#' . a:color . '#%{' . a:part . '}%*'
	endif
endfunction

function! modestatus#statusline_part(active_win, part, first)
	if modestatus#parts#has(a:part)
		let part = s:format(a:first, a:part, modestatus#options#get(a:part, 'format'), modestatus#options#get(a:part, 'separator'))
		let part = s:on_active_only(a:active_win, part, modestatus#options#get(a:part, 'active_only'))
		return s:colorize(a:active_win, part, modestatus#options#get(a:part, 'color'))
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
			let first = 1
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
