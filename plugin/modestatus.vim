if exists('g:loaded_statusline') && g:loaded_statusline
	finish
endif

call modestatus#init#bootstrap()

augroup statusline
	autocmd!
	autocmd VimEnter,WinEnter,BufWinEnter * call modestatus#update()
	autocmd ColorScheme * call modestatus#init#highlight()
augroup END

let loaded_statusline = 1
