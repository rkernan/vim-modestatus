let s:options = {}

function! modestatus#options#add(key, val, ...)
	call extend(s:options, {a:key: {}}, 'keep')
	for subkey in keys(a:val)
		call extend(s:options[a:key], {subkey: {}}, 'keep')
		call extend(s:options[a:key][subkey], a:val[subkey], (a:0 == 1 ? a:1 : 'force'))
	endfor
endfunction

function! modestatus#options#has(key)
	return has_key(s:options, a:key)
endfunction

function! modestatus#options#get_concat(key, is_active)
	if modestatus#options#has(a:key)
		let options = {}
		if has_key(s:options[a:key], 'common')
			let options = extend(options, s:options[a:key]['common'])
		endif
		if has_key(s:options[a:key], (a:is_active ? 'active' : 'inactive'))
			let options = extend(options, s:options[a:key][(a:is_active ? 'active' : 'inactive')])
		endif
		return options
	else
		return {}
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
