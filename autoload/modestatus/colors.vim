let s:colors = {}

function! modestatus#colors#add(key, val)
	if a:val > 0 && a:val < 10
		let s:colors[a:key] = a:val
	else
		call modestatus#log#error('color value "' . a:val . '" is invalid, valid: [1,9]')
	endif
endfunction

function! modestatus#colors#has(key)
	return has_key(s:colors, a:key)
endfunction

function! modestatus#colors#get(key)
	if modestatus#colors#has(a:key)
		return s:colors[a:key]
	else
		call modestatus#log#error('color "' . a:key . '" not found')
		return 0
	endif
endfunction

function! modestatus#colors#list()
	echom string(s:colors)
endfunction
