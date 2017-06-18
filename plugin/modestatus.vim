if exists('g:loaded_modestatus')
	finish
endif
let g:loaded_modestatus = 1

if !exists('g:modestatus#statusline')
	let g:modestatus#statusline = []
endif

let g:modestatus#statusline = get(g:, 'modestatus#statusline', [])

call modestatus#parts#init()

call modestatus#set()
