let s:options = {}

function! modestatus#options#add(key, val)
	let s:options[a:key] = a:val
	call extend(s:options[a:key], {'common': {}, 'active': {}, 'inactive': {}}, 'keep')
endfunction

function! modestatus#options#has(key)
	return has_key(s:options, a:key)
endfunction

function! modestatus#options#get(key)
	if modestatus#options#has(a:key)
		return deepcopy(s:options[a:key])
	else
		call modestatus#log#error('options for "' . a:key . '" not found')
		return 0
	endif
endfunction

function! modestatus#options#list()
	for k1 in keys(s:options)
		echom string(k1) . ':'
		for k2 in keys(s:options[k1])
			if len(s:options[k1][k2])
				echom '  ' . string(k2) . ':'
				for k3 in keys(s:options[k1][k2])
					echom '    ' . string(k3) . ': ' . string(s:options[k1][k2][k3])
				endfor
			endif
		endfor
	endfor
endfunction
