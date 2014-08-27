function! s:check_defined(var, default)
	if !exists(a:var)
		let {a:var} = a:default
	endif
endfunction

function! modestatus#init#highlight()

	call modestatus#highlight#copy('Statusline', 'User1')
	call modestatus#highlight#modify('User1', g:modestatus#user1_keys)
	call modestatus#highlight#copy('Statusline', 'User2')
	call modestatus#highlight#modify('User2', g:modestatus#user2_keys)
	call modestatus#highlight#copy('Statusline', 'User3')
	call modestatus#highlight#modify('User3', g:modestatus#user3_keys)
	call modestatus#highlight#copy('Statusline', 'User4')
	call modestatus#highlight#modify('User4', g:modestatus#user4_keys)
	call modestatus#highlight#copy('Statusline', 'User5')
	call modestatus#highlight#modify('User5', g:modestatus#user5_keys)
	call modestatus#highlight#copy('Statusline', 'User6')
	call modestatus#highlight#modify('User6', g:modestatus#user6_keys)
	call modestatus#highlight#copy('Statusline', 'User7')
	call modestatus#highlight#modify('User7', g:modestatus#user7_keys)
	call modestatus#highlight#copy('Statusline', 'User8')
	call modestatus#highlight#modify('User8', g:modestatus#user8_keys)
	call modestatus#highlight#copy('Statusline', 'User9')
	call modestatus#highlight#modify('User9', g:modestatus#user9_keys)
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

	call s:check_defined('g:modestatus#user1_keys', {
		\   'term': 'bold',
		\   'cterm': 'bold',
		\   'gui': 'bold'
		\ })
	call s:check_defined('g:modestatus#user2_keys', {
		\   'ctermfg': 'Yellow',
		\   'guifg': 'Yellow'
		\ })
	call s:check_defined('g:modestatus#user3_keys', {
		\   'term': 'bold',
		\   'cterm': 'bold',
		\   'ctermfg': 'Red',
		\   'gui': 'bold',
		\   'guifg': 'Red'
		\ })
	call s:check_defined('g:modestatus#user4_keys', {})
	call s:check_defined('g:modestatus#user5_keys', {})
	call s:check_defined('g:modestatus#user6_keys', {})
	call s:check_defined('g:modestatus#user7_keys', {})
	call s:check_defined('g:modestatus#user8_keys', {
		\   'ctermfg': 'White',
		\   'ctermbg': '124',
		\   'guifg': 'White',
		\   'guibg': '#af0000'
		\ })
	call s:check_defined('g:modestatus#user9_keys', {
		\   'ctermfg': 'Black',
		\   'ctermbg': '178',
		\   'guifg': 'Black',
		\   'guibg': '#dfaf00'
		\ })

	call modestatus#init#highlight()
endfunction
