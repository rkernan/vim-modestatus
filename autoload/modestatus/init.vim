function! s:check_defined(variable, default)
	if !exists(a:variable)
		let {a:variable} = a:default
	endif
endfunction

function! modestatus#init#highlight()
	call modestatus#highlight#copy('Statusline', 'User1')
	call modestatus#highlight#modify('User1', {
		\   'term':    'bold',
		\   'cterm':   'bold',
		\   'ctermfg': 'Red',
		\   'gui':     'bold',
		\   'guifg':   'Red'
		\ })
endfunction

function! modestatus#init#bootstrap()
	call s:check_defined('g:modestatus#mode_map', {})
	call extend(g:modestatus#mode_map, {
		\   'n':      'N',
		\   'i':      'I',
		\   'R':      'R',
		\   'v':      'V',
		\   'V':      'V',
		\   "\<c-v>": 'V',
		\   'c':      'C',
		\   's':      'S',
		\   'S':      'S',
		\   "\<c-s>": 'S',
		\   '?':      '?',
		\ }, 'keep')

	call modestatus#init#highlight()
endfunction
