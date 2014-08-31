function! modestatus#util#check_defined(var, default)
	if !exists(a:var)
		let {a:var} = a:default
	endif
endfunction

function! modestatus#util#pad_before(str, amt, ...)
	let pad = ' '
	if a:0 == 1
		let pad = a:1
	endif
	return modestatus#util#prefix(a:str, repeat(pad, a:amt - len(a:str)))
endfunction

function! modestatus#util#pad_after(str, amt, ...)
	let pad = ' '
	if a:0 == 1
		let pad = a:1
	endif
	return modestatus#util#suffix(a:str, repeat(pad, a:amt - len(a:str)))
endfunction

function! modestatus#util#prefix(str, pre)
	if len(a:str)
		return a:pre . a:str
	else
		return ''
	endif
endfunction

function! modestatus#util#suffix(str, post)
	if len(a:str)
		return a:str . a:post
	else
		return ''
	endif
endfunction
