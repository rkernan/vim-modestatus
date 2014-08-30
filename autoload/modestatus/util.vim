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
	if len(a:content)
		return a:pre . a:content
	else
		return ''
	endif
endfunction

function! modestatus#util#postfix(content, post)
	if len(a:content)
		return a:content . a:post
	else
		return ''
	endif
endfunction
