let s:colors = {}

function! modestatus#colors#add(key, val)
	if a:val > 0 && a:val < 10
		let s:colors[a:key] = a:val
	else
		throw 'color value "' . a:val . '" is invalid, valid: [1,9]'
	endif
endfunction

function! modestatus#colors#get(key)
	if has_key(s:colors, a:key)
		return s:colors[a:key]
	else
		throw 'color "' . a:key . '" not found'
	endif
endfunction
