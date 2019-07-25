function! modestatus#parts#ale#init()
	call modestatus#parts#add('ale_totals', 'modestatus#parts#ale#totals')
	call modestatus#parts#add('ale_errors', 'modestatus#parts#ale#errors')
	call modestatus#parts#add('ale_warnings', 'modestatus#parts#ale#warnings')
	call modestatus#parts#add('ale_info', 'modestatus#parts#ale#info')
	call modestatus#parts#add('ale_style_errors', 'modestatus#parts#ale#style_errors')
	call modestatus#parts#add('ale_style_warnings', 'modestatus#parts#ale#style_warnings')
endfunction

function! s:get_modestatus_count(bufnr)
	try
		return ale#statusline#Count(a:bufnr)
	catch
		return {'total': 0, 'error': 0, 'warning': 0, 'info': 0, 'style_error': 0, 'style_warning': 0}
	endtry
endfunction

function! modestatus#parts#ale#totals()
	let c = s:get_modestatus_count(bufnr('%'))['total']
	return c > 0 ? c : ''
endfunction

function! modestatus#parts#ale#errors()
	let c = s:get_modestatus_count(bufnr('%'))['error']
	return c > 0 ? c : ''
endfunction

function! modestatus#parts#ale#warnings()
	let c = s:get_modestatus_count(bufnr('%'))['warning']
	return c > 0 ? c : ''
endfunction

function! modestatus#parts#ale#info()
	let c = s:get_modestatus_count(bufnr('%'))['info']
	return c > 0 ? c : ''
endfunction

function! modestatus#parts#ale#style_errors()
	let c = s:get_modestatus_count(bufnr('%'))['style_error']
	return c > 0 ? c : ''

endfunction

function! modestatus#parts#ale#style_warnings()
	let c = s:get_modestatus_count(bufnr('%'))['style_warning']
	return c > 0 ? c : ''
endfunction
