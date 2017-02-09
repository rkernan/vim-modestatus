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
	call modestatus#util#check_defined('g:modestatus#disable_filetypes', ['qf'])
	call modestatus#util#check_defined('g:modestatus#extensions#auto', 0)

	if g:modestatus#extensions#auto
		call modestatus#extensions#enable_all()
	endif
endfunction
