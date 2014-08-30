let s:options = {}

function! modestatus#options#add(key, val)
	let s:options[a:key] = a:val
	call extend(s:options[a:key], {'active': {}, 'inactive': {}}, 'keep')
endfunction

function! modestatus#options#has(key)
	return has_key(s:options, a:key)
endfunction

function! modestatus#options#get(key)
	if modestatus#options#has(a:key)
		return s:options[a:key]
	else
		call modestatus#log#error('options for "' . a:key . '" not found')
		return 0
	endif
endfunction

function! modestatus#options#list()
	echom string(s:options)
endfunction
