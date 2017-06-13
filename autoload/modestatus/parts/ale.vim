function! modestatus#parts#ale#init()
	call modestatus#parts#add('ale_totals', 'modestatus#parts#ale#totals')
	call modestatus#parts#add('ale_errors', 'modestatus#parts#ale#errors')
	call modestatus#parts#add('ale_warnings', 'modestatus#parts#ale#warnings')
	call modestatus#parts#add('ale_info', 'modestatus#parts#ale#info')
	call modestatus#parts#add('ale_style_errors', 'modestatus#parts#ale#style_error')
	call modestatus#parts#add('ale_style_warnings', 'modestatus#parts#ale#style_error')
endfunction

function modestatus#parts#ale#totals(...)
	return ale#statusline#Count(winnr())['total']
endfunction

function modestatus#parts#ale#errors(...)
	return ale#statusline#Count(winnr())['error']
endfunction

function modestatus#parts#ale#warnings(...)
	return ale#statusline#Count(winnr())['warning']
endfunction

function modestatus#parts#ale#info(...)
	return ale#statusline#Count(winnr())['info']
endfunction

function modestatus#parts#ale#style_errors(...)
	return ale#statusline#Count(winnr())['style_error']

endfunction

function modestatus#parts#ale#style_warnings(...)
	return ale#statusline#Count(winnr())['style_warning']
endfunction
