function! s:check_defined(variable, default)
	if !exists(a:variable)
		let {a:variable} = a:default
	endif
endfunction

function! modestatus#init#highlight()
	call modestatus#highlight#copy('Statusline', 'User1')
	call modestatus#highlight#modify('User1', {
		\   'term': 'bold',
		\   'cterm': 'bold',
		\   'gui': 'bold'
		\ })

	call modestatus#highlight#copy('Statusline', 'User2')
	call modestatus#highlight#modify('User2', {
		\   'term': 'bold',
		\   'cterm': 'bold',
		\   'ctermfg': 'Yellow',
		\   'gui': 'bold',
		\   'guifg': 'Yellow'
		\ })

	call modestatus#highlight#copy('Statusline', 'User3')
	call modestatus#highlight#modify('User3', {
		\   'term': 'bold',
		\   'cterm': 'bold',
		\   'ctermfg': 'Red',
		\   'gui': 'bold',
		\   'guifg': 'Red'
		\ })

	call modestatus#highlight#add('User7', {
		\   'cterm': 'bold',
		\   'ctermfg': 'White',
		\   'ctermbg': 'Red',
		\   'gui': 'bold',
		\   'guifg': 'White',
		\   'guibg': 'Red'
		\ })

	call modestatus#highlight#add('User8', {
		\   'cterm': 'bold',
		\   'ctermfg': 'Black',
		\   'ctermbg': 'Yellow',
		\   'gui': 'bold',
		\   'guifg': 'Black',
		\   'guibg': 'Yellow'
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
