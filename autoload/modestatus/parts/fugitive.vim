function! modestatus#parts#fugitive#init()
	call modestatus#parts#add('fugitive_branch', 'fugitive#head')
endfunction
