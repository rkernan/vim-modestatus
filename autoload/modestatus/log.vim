function! modestatus#log#error(msg)
	echom 'ERR:  ' . a:msg
endfunction

function! modestatus#log#warning(msg)
	echom 'WARN: ' . a:msg
endfunction
