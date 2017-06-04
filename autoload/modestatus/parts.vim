let s:parts = {}

function! modestatus#parts#init()
	for file in split(globpath(&rtp, 'autoload/modestatus/parts/*.vim'), '\n')
		call modestatus#parts#{fnamemodify(file, ':t:r')}#init()
	endfor
endfunction

function! modestatus#parts#add(key, val)
	let s:parts[a:key] = a:val
endfunction

function! modestatus#parts#has(key)
	return has_key(s:parts, a:key)
endfunction

function! modestatus#parts#get(key)
	if modestatus#parts#has(a:key)
		return s:parts[a:key]
	else
		echoerr 'part "' . a:key . '" not found'
		return 0
	endif
endfunction

function! modestatus#parts#list()
	for key in keys(s:parts)
		echom string(key) . ': ' . string(s:parts[key])
	endfor
endfunction
