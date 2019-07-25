function! modestatus#parts#fugitive#init()
	call modestatus#parts#add('fugitive_branch', 'modestatus#parts#fugitive#head')
endfunction

function! modestatus#parts#fugitive#head()
	try
		return call fugitive#head()
	catch
		return ''
	endtry
endfunction
