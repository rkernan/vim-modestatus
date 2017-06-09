if exists('g:modestatus_loaded') && g:modestatus_loaded
	finish
endif
let g:modestatus_loaded = 1

if !exists('g:modestatus#statusline')
	let g:modestatus#statusline = []
endif

let g:modestatus#statusline = get(g:, 'modestatus#statusline', [])
let g:modestatus#statusline_separator = get(g:, 'modestatus#statusline_separator', ' ')
let g:modestatus#statusline_separator_left = get(g:, 'modestatus#statusline_separator_left', g:modestatus#statusline_separator)

" vim strips single leading spaces from inside %{} blocks - 2 leading spaces == 1
if g:modestatus#statusline_separator_left[0] == ' '
	let g:modestatus#statusline_separator_left = '  ' . g:modestatus#statusline_separator_left[1:]
endif

call modestatus#parts#init()

call modestatus#set()
