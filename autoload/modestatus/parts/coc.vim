function! modestatus#parts#coc#init()
	call modestatus#parts#add('coc_errors', 'modestatus#parts#coc#errors')
	call modestatus#parts#add('coc_warnings', 'modestatus#parts#coc#warnings')
	call modestatus#parts#add('coc_information', 'modestatus#parts#coc#information')
	call modestatus#parts#add('coc_hints', 'modestatus#parts#coc#hints')
endfunction

function! s:get_coc_diagnostic_info()
	return get(b:, 'coc_diagnostic_info', {'error': 0, 'warning': 0, 'information': 0, 'hint': 0})
endfunction

function! modestatus#parts#coc#errors()
	let errors = s:get_coc_diagnostic_info()['error']
	return errors > 0 ? errors : ''
endfunction

function! modestatus#parts#coc#warnings()
	let warnings = s:get_coc_diagnostic_info()['warning']
	return warnings > 0 ? warnings : ''
endfunction

function! modestatus#parts#coc#information()
	let information = s:get_coc_diagnostic_info()['information']
	return information > 0 ? information : ''
endfunction

function! modestatus#parts#coc#hints()
	let hints = s:get_coc_diagnostic_info()['hint']
	return hints > 0 ? hints : ''
endfunction
