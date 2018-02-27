function! modestatus#parts#denite#init()
	call modestatus#parts#add('denite_line', 'modestatus#parts#denite#line')
	call modestatus#parts#add('denite_line_max', 'modestatus#parts#denite#line_max')
	call modestatus#parts#add('denite_line_percent', 'modestatus#parts#denite#line_percent')
	call modestatus#parts#add('denite_mode', 'modestatus#parts#denite#mode')
	call modestatus#parts#add('denite_path', 'modestatus#parts#denite#path')
	call modestatus#parts#add('denite_sources', 'modestatus#parts#denite#sources')

	call modestatus#options#add('denite_mode', 'active_only', 1)

	if !exists('g:modestatus#parts#denite#mode_colors')
		let g:modestatus#parts#denite#mode_colors = {
			\ '-- INSERT -- ': 'ModestatusModeInsert',
			\ '-- NORMAL -- ': 'ModestatusModeNormal'}
	endif

	if !exists('g:modestatus#parts#denite#mode_master_color')
		let g:modestatus#parts#denite#mode_master_color = 'ModestatusMode'
	endif

	if !exists('g:modestatus#parts#denite#mode_symbols')
		let g:modestatus#parts#denite#mode_symbols = {
			\ '-- INSERT -- ': 'I',
			\ '-- NORMAL -- ': 'N'}
	endif
endfunction

function! modestatus#parts#denite#line()
	return denite#get_status('line_cursor')
endfunction

function! modestatus#parts#denite#line_max()
	return denite#get_status('line_total')
endfunction

function! modestatus#parts#denite#line_percent()
	let line_cursor = denite#get_status('line_cursor')
	let line_total = denite#get_status('line_total')
	let percent = (line_cursor * 1.0) / (line_total * 1.0) * 100.0
	if percent > 100.0
		let percent = 100.0
	endif
	return float2nr(round(percent)) . '%'
endfunction

function! modestatus#parts#denite#path()
	return denite#get_status('path')
endfunction

function! modestatus#parts#denite#mode()
	let mode = denite#get_status('mode')
	if strlen(g:modestatus#parts#denite#mode_master_color)
		execute 'highlight! link ' . g:modestatus#parts#denite#mode_master_color . ' ' . g:modestatus#parts#denite#mode_colors[mode]
	endif
	return g:modestatus#parts#denite#mode_symbols[mode]
endfunction

function! modestatus#parts#denite#sources()
	return denite#get_status('sources')
endfunction
