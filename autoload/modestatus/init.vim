let s:initialized = 0

function! modestatus#init#bootstrap()
	if s:initialized
		return
	endif
	let s:initialized = 1

	set statusline=

	call modestatus#util#check_defined('g:modestatus#default_separator', ' ')
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
		\   ]}})
	call modestatus#util#check_defined('g:modestatus#statusline_override', {})
endfunction
