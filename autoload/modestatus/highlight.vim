function! modestatus#highlight#get_keys(group)
	" get group definition
	redir => str
		exec 'silent hi ' . a:group
	redir END
	" follow links
	while str =~ 'links to'
		let i = stridx(str, 'links to') + len('links to')
		let linked_group = strpart(str, i + 1)
		redir => str
			exec 'silent hi ' . linked_group
		redir END
	endwhile

	" get keys string
	let str = matchlist(str, '\<xxx\>\s\+\(.*\)')[1]
	" find keys in string
	let term    = matchlist(str, '^\(.\{-}\)term=\([^ ]\+\)\( .\{-}\)\?$')
	let start   = matchlist(str, '^\(.\{-}\)start=\([^ ]\+\)\( .\{-}\)\?$')
	let stop    = matchlist(str, '^\(.\{-}\)stop=\([^ ]\+\)\( .\{-}\)\?$')
	let cterm   = matchlist(str, '^\(.\{-}\)cterm=\([^ ]\+\)\( .\{-}\)\?$')
	let ctermfg = matchlist(str, '^\(.\{-}\)ctermfg=\([^ ]\+\)\( .\{-}\)\?$')
	let ctermbg = matchlist(str, '^\(.\{-}\)ctermbg=\([^ ]\+\)\( .\{-}\)\?$')
	let gui     = matchlist(str, '^\(.\{-}\)gui=\([^ ]\+\)\( .\{-}\)\?$')
	let font    = matchlist(str, '^\(.\{-}\)font=\([^ ]\+\)\( .\{-}\)\?$')
	let guifg   = matchlist(str, '^\(.\{-}\)guifg=\([^ ]\+\)\( .\{-}\)\?$')
	let guibg   = matchlist(str, '^\(.\{-}\)guibg=\([^ ]\+\)\( .\{-}\)\?$')
	let guisp   = matchlist(str, '^\(.\{-}\)guisp=\([^ ]\+\)\( .\{-}\)\?$')
	" create key dict
	let keys = {}
	if term    != [] | call extend(keys, {'term':    term[2]})    | endif
	if start   != [] | call extend(keys, {'start':   start[2]})   | endif
	if stop    != [] | call extend(keys, {'stop':    stop[2]})    | endif
	if cterm   != [] | call extend(keys, {'cterm':   cterm[2]})   | endif
	if ctermfg != [] | call extend(keys, {'ctermfg': ctermfg[2]}) | endif
	if ctermbg != [] | call extend(keys, {'ctermbg': ctermbg[2]}) | endif
	if gui     != [] | call extend(keys, {'gui':     gui[2]})     | endif
	if font    != [] | call extend(keys, {'font':    font[2]})    | endif
	if guifg   != [] | call extend(keys, {'guifg':   guifg[2]})   | endif
	if guibg   != [] | call extend(keys, {'guibg':   guibg[2]})   | endif
	if guisp   != [] | call extend(keys, {'guisp':   guisp[2]})   | endif

	return keys
endfunction

function! modestatus#highlight#make_cmd(group, keys)
	let cmd = ''
	for k in keys(a:keys)
		let cmd .= k . '=' . a:keys[k] . ' '
	endfor
	return len(cmd) ? ('silent hi ' . a:group . ' ' . cmd) : ''
endfunction

function! modestatus#highlight#add(group, keys)
	let cmd = modestatus#highlight#make_cmd(a:group, a:keys)
	if len(cmd)
		exec cmd
	endif
endfunction

function! modestatus#highlight#copy(from, to)
	let keys = modestatus#highlight#get_keys(a:from)
	call modestatus#highlight#add(a:to, keys)
endfunction

function! modestatus#highlight#modify(group, keys)
	let nkeys = modestatus#highlight#get_keys(a:group)
	call extend(nkeys, a:keys, 'force')
	call modestatus#highlight#add(a:group, nkeys)
endfunction
