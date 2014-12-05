function! modestatus#log#error(msg)
	echohl Error
	echom 'ERR:  ' . a:msg
	echohl None
endfunction

function! modestatus#log#warning(msg)
	echohl WarningMsg
	echom 'WARN: ' . a:msg
	echohl None
endfunction
