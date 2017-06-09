if exists('g:modestatus_loaded') && g:modestatus_loaded
	finish
endif
let g:modestatus_loaded = 1

if !exists('g:modestatus#statusline')
	let g:modestatus#statusline = []
endif

let g:modestatus#statusline = get(g:, 'modestatus#statusline', [])

call modestatus#parts#init()

call modestatus#set()
