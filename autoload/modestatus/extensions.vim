let s:extensions = []

function! modestatus#extensions#enable(ext)
	try
		call modestatus#extensions#{a:ext}#init()
		call add(s:extensions, a:ext)
	catch
		call modestatus#log#error('extensions: "modestatus#' . a:ext . '#init()" not found')
	endtry
endfunction

function! modestatus#extensions#enable_all()
	for file in split(globpath(&rtp, 'autoload/modestatus/extensions/*.vim'), '\n')
		let name = fnamemodify(file, ':t:r')
		call modestatus#extensions#enable(name)
	endfor
endfunction

function! modestatus#extensions#list()
	echom string(s:extensions)
endfunction
