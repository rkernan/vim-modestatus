if exists('g:modestatus_loaded') && g:modestatus_loaded
	finish
endif
let g:modestatus_loaded = 1

if !exists('g:modestatus#statusline')
	let g:modestatus#statusline = []
endif

if !exists('g:modestatus#statusline_separator')
	let g:modestatus#statusline_separator = ' '
endif

call modestatus#parts#init()

set statusline=%!modestatus#statusline(winnr())
