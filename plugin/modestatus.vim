if exists('g:modestatus_loaded') && g:modestatus_loaded
	finish
endif

call modestatus#init#bootstrap()

augroup statusline
	autocmd!
	autocmd VimEnter,WinEnter,BufWinEnter,CursorHold * call modestatus#update()
augroup END

let g:modestatus_loaded = 1
