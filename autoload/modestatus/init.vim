let s:initialized = 0

function! modestatus#init#bootstrap()
	if s:initialized
		return
	endif
	let s:initialized = 1

	set statusline=

	" statusline
	call modestatus#util#check_defined('g:modestatus#statusline', {
		\ 'active': {
		\   'left': [
		\     'line_percent',
		\     'position',
		\     'mode',
		\     'filename',
		\     'modified',
		\     'readonly',
		\     'paste',
		\     'filetype',
		\     'encoding_and_format',
		\     'loclist_errors',
		\     'loclist_warnings',
		\   ],
		\   'right': []
		\ },
		\ 'inactive': {
		\   'left': [
		\     'filename',
		\     'modified',
		\     'readonly',
		\     'filetype',
		\     'encoding_and_format',
		\     'loclist_errors',
		\     'loclist_warnings'
		\   ],
		\   'right': []
		\ }})

	" colors
	call modestatus#util#check_defined('g:modestatus#highlights', {
		\ 'user1': {
		\   'term': 'bold',
		\   'cterm': 'bold',
		\   'gui': 'bold'
		\ },
		\ 'user2': {
		\   'ctermfg': 'Yellow',
		\   'guifg': 'Yellow'
		\ },
		\ 'user3': {
		\   'term': 'bold',
		\   'cterm': 'bold',
		\   'ctermfg': 'Red',
		\   'gui': 'bold',
		\   'guifg': 'Red'
		\ },
		\ 'user8': {
		\   'ctermfg': 'White',
		\   'ctermbg': '124',
		\   'guifg': 'White',
		\   'guibg': '#af0000'
		\ },
		\ 'user9': {
		\   'ctermfg': 'Black',
		\   'ctermbg': '178',
		\   'guifg': 'Black',
		\   'guibg': '#dfaf00'
		\ }})
	call extend(g:modestatus#highlights, {
		\ 'user1': {},
		\ 'user2': {},
		\ 'user3': {},
		\ 'user4': {},
		\ 'user5': {},
		\ 'user6': {},
		\ 'user7': {},
		\ 'user8': {},
		\ 'user9': {}
		\ }, 'keep')
	call modestatus#colors#add('bold', 1)
	call modestatus#colors#add('ylw_bold', 2)
	call modestatus#colors#add('red_bold', 3)
	call modestatus#colors#add('error', 8)
	call modestatus#colors#add('warning', 9)

	call modestatus#init#highlight()

	call modestatus#extensions#enable_all()
endfunction

function! modestatus#init#highlight()
	call modestatus#highlight#copy_and_modify('Statusline', 'User1', g:modestatus#highlights['user1'])
	call modestatus#highlight#copy_and_modify('Statusline', 'User2', g:modestatus#highlights['user2'])
	call modestatus#highlight#copy_and_modify('Statusline', 'User3', g:modestatus#highlights['user3'])
	call modestatus#highlight#copy_and_modify('Statusline', 'User4', g:modestatus#highlights['user4'])
	call modestatus#highlight#copy_and_modify('Statusline', 'User5', g:modestatus#highlights['user5'])
	call modestatus#highlight#copy_and_modify('Statusline', 'User6', g:modestatus#highlights['user6'])
	call modestatus#highlight#copy_and_modify('Statusline', 'User7', g:modestatus#highlights['user7'])
	call modestatus#highlight#copy_and_modify('Statusline', 'User8', g:modestatus#highlights['user8'])
	call modestatus#highlight#copy_and_modify('Statusline', 'User9', g:modestatus#highlights['user9'])
endfunction
