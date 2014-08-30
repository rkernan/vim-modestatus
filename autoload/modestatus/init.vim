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
		\     'mode',
		\     'paste',
		\     'filename',
		\     'modified',
		\     'readonly',
		\     'filetype',
		\     'encoding',
		\     'fileformat'
		\   ],
		\   'right': [
		\     'position',
		\     'line_percent'
		\   ]
		\ },
		\ 'inactive': {
		\   'left': [
		\     'filename',
		\     'modified',
		\     'readonly',
		\     'filetype',
		\     'encoding',
		\     'fileformat'
		\   ],
		\   'right': []
		\ }})

	call modestatus#extensions#enable_all()
endfunction
