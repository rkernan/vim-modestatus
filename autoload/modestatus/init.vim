let s:loaded = 0
function! modestatus#init#bootstrap()
	if s:loaded
		return
	endif
	let s:loaded = 1

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
		\     'loclist_warnings'
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
	call modestatus#util#check_defined('g:modestatus#colors', {})
	call extend(g:modestatus#colors, {
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
		\ 'user4': {},
		\ 'user5': {},
		\ 'user6': {},
		\ 'user7': {},
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
		\ }}, 'keep')

	call modestatus#init#highlight()
	call modestatus#init#extensions()
endfunction

function! modestatus#init#highlight()
	call modestatus#highlight#copy_and_modify('Statusline', 'User1', g:modestatus#colors['user1'])
	call modestatus#highlight#copy_and_modify('Statusline', 'User2', g:modestatus#colors['user2'])
	call modestatus#highlight#copy_and_modify('Statusline', 'User3', g:modestatus#colors['user3'])
	call modestatus#highlight#copy_and_modify('Statusline', 'User4', g:modestatus#colors['user4'])
	call modestatus#highlight#copy_and_modify('Statusline', 'User5', g:modestatus#colors['user5'])
	call modestatus#highlight#copy_and_modify('Statusline', 'User6', g:modestatus#colors['user6'])
	call modestatus#highlight#copy_and_modify('Statusline', 'User7', g:modestatus#colors['user7'])
	call modestatus#highlight#copy_and_modify('Statusline', 'User8', g:modestatus#colors['user8'])
	call modestatus#highlight#copy_and_modify('Statusline', 'User9', g:modestatus#colors['user9'])
endfunction

function! modestatus#init#extensions()
	for file in split(globpath(&rtp, 'autoload/modestatus/extensions/*.vim'), '\n')
		let name = fnamemodify(file, ':t:r')
		call modestatus#extensions#{name}#init()
	endfor
endfunction
