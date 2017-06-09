let s:options = {}
let s:valid_options = ['color', 'format', 'separator']

function! modestatus#options#add(part, option, val, ...)
	let force = a:0 == 1 ? a:1 : 1
	if index(s:valid_options, a:option) == -1
		echoerr 'invalid option "' . a:option . '"'
	else
		call extend(s:options, {a:part: {}}, 'keep')
		if !has_key(s:options[a:part], a:option) || force
			let s:options[a:part][a:option] = a:val
		endif
	endif
endfunction

function! modestatus#options#has(part, option)
	if has_key(s:options, a:part)
		return has_key(s:options[a:part], a:option)
	else
		return 0
	endif
endfunction

function! modestatus#options#get(part, option)
	if modestatus#options#has(a:part, a:option)
		return s:options[a:part][a:option]
	else
		return ''
	endif
endfunction

function! modestatus#options#list()
	for part in keys(s:options)
		echom string(part) . ':'
		for option in keys(s:options[part])
			echom '  ' . string(option) . ': ' . string(s:options[part][option])
		endfor
	endfor
endfunction
