function! modestatus#util#pad_after(str, amt)
	return a:str . repeat(' ', a:amt - len(a:str))
endfunction

function! modestatus#util#pad_before(str, amt)
	return repeat(' ', a:amt - len(a:str)) . a:str
endfunction
