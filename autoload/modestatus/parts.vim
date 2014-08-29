let s:parts = {}

function! modestatus#parts#add(key, func)
	let s:parts[a:key] = a:func
endfunction

function! modestatus#parts#get(key)
	if has_key(s:parts, a:key)
		return s:parts[a:key]
	else
		throw 'part "' . a:key . '" not found'
	endif
endfunction

function! modestatus#parts#list()
	echom string(s:parts)
endfunction
