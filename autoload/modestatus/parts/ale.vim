function! modestatus#parts#ale#init()
	call modestatus#parts#add('ale_totals', 'modestatus#parts#ale#totals')
	call modestatus#parts#add('ale_errors', 'modestatus#parts#ale#errors')
	call modestatus#parts#add('ale_warnings', 'modestatus#parts#ale#warnings')
	call modestatus#parts#add('ale_info', 'modestatus#parts#ale#info')
	call modestatus#parts#add('ale_style_errors', 'modestatus#parts#ale#style_errors')
	call modestatus#parts#add('ale_style_warnings', 'modestatus#parts#ale#style_errors')
endfunction

function! modestatus#parts#ale#totals()
	let c = ale#statusline#Count(winnr())['total']
	return c > 0 ? c : ''
endfunction

function! modestatus#parts#ale#errors()
	let c = ale#statusline#Count(winnr())['error']
	return c > 0 ? c : ''
endfunction

function! modestatus#parts#ale#warnings()
	let c = ale#statusline#Count(winnr())['warning']
	return c > 0 ? c : ''
endfunction

function! modestatus#parts#ale#info()
	let c = ale#statusline#Count(winnr())['info']
	return c > 0 ? c : ''
endfunction

function! modestatus#parts#ale#style_errors()
	let c = ale#statusline#Count(winnr())['style_error']
	return c > 0 ? c : ''

endfunction

function! modestatus#parts#ale#style_warnings()
	let c = ale#statusline#Count(winnr())['style_warning']
	return c > 0 ? c : ''
endfunction
