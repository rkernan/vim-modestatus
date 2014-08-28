function! modestatus#util#pad_after(str, amt)
	return a:str . repeat(' ', a:amt - len(a:str))
endfunction

function! modestatus#util#pad_before(str, amt)
	return repeat(' ', a:amt - len(a:str)) . a:str
endfunction

function! modestatus#util#check_defined(var, default)
	if !exists(a:var)
		let {a:var} = a:default
	endif
endfunction

function! modestatus#util#prefix(content, pre)
	return modestatus#util#surround(a:content, a:pre, '')
endfunction

function! modestatus#util#postfix(content, post)
	return modestatus#util#surround(a:content, '', a:post)
endfunction

function! modestatus#util#surround(content, left, ...)
	let right = a:0 == 1 ? a:1 : a:left
	if len(a:content)
		return a:left . a:content . right
	else
		return ''
	endif
endfunction
