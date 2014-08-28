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
	call modestatus#util#check_defined('g:modestatus#user1_keys', {
		\   'term': 'bold',
		\   'cterm': 'bold',
		\   'gui': 'bold'
		\ })
	call modestatus#util#check_defined('g:modestatus#user2_keys', {
		\   'ctermfg': 'Yellow',
		\   'guifg': 'Yellow'
		\ })
	call modestatus#util#check_defined('g:modestatus#user3_keys', {
		\   'term': 'bold',
		\   'cterm': 'bold',
		\   'ctermfg': 'Red',
		\   'gui': 'bold',
		\   'guifg': 'Red'
		\ })
	call modestatus#util#check_defined('g:modestatus#user4_keys', {})
	call modestatus#util#check_defined('g:modestatus#user5_keys', {})
	call modestatus#util#check_defined('g:modestatus#user6_keys', {})
	call modestatus#util#check_defined('g:modestatus#user7_keys', {})
	call modestatus#util#check_defined('g:modestatus#user8_keys', {
		\   'ctermfg': 'White',
		\   'ctermbg': '124',
		\   'guifg': 'White',
		\   'guibg': '#af0000'
		\ })
	call modestatus#util#check_defined('g:modestatus#user9_keys', {
		\   'ctermfg': 'Black',
		\   'ctermbg': '178',
		\   'guifg': 'Black',
		\   'guibg': '#dfaf00'
		\ })

	call modestatus#init#highlight()
endfunction
