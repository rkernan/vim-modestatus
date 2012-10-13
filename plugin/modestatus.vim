" modeline.vim
" @author Robert Kernan
" @created 10-12-2012
" @modified 10-12-2012

" mode dispay names
if !exists('g:Modestatus_mode_normal')
	let g:Modestatus_mode_normal='NORMAL'
endif
if !exists('g:Modestatus_mode_insert')
	let g:Modestatus_mode_insert='INSERT'
endif
if !exists('g:Modestatus_mode_replace')
	let g:Modestatus_mode_replace='REPLACE'
endif
if !exists('g:Modestatus_mode_visual')
	let g:Modestatus_mode_visual='VISUAL'
endif
if !exists('g:Modestatus_mode_visualLine')
	let g:Modestatus_mode_visualLine='VISUAL-LINE'
endif
if !exists('g:Modestatus_mode_visualBlock')
	let g:Modestatus_mode_visualBlock='VISUAL-BLOCK'
endif
if !exists('g:Modestatus_mode_select')
	let g:Modestatus_mode_select='SELECT'
endif
if !exists('g:Modestatus_selectLine')
	let g:Modestatus_mode_selectLine='SELECT-LINE'
endif
if !exists('g:Modestatus_selectBlock')
	let g:Modestatus_mode_selectBlock='SELECT-BLOCK'
endif

" active statusline
if !exists('g:Modestatus_statusline')
	let g:Modestatus_statusline='%#Modestatus_current#%{Modestatus_GetMode()}%* [%n] %f %{&mod?"+":""}%r [%{strlen(&ft)?&ft:"none"}, %{strlen(&fenc)?&fenc:&enc}, %{&fileformat}]%=%l/%L,%c'
endif
" inactive statusline
if !exists('g:Modestatus_statuslineNC')
	let g:Modestatus_statuslineNC='[%n] %f %{&mod?"+":""}%r [%{strlen(&ft)?&ft:"non"}, %{strlen(&fenc)?&fenc:&enc}, %{&fileformat}]%=%l/%L,%c'
endif

" mode colors
hi Modestatus_normal		guifg=#afdf00	guibg=#005f00	gui=bold
hi Modestatus_insert		guifg=#005f5f	guibg=#87dfff	gui=bold
hi Modestatus_replace		guifg=#df0000	guibg=#ffffff	gui=bold
hi Modestatus_visual		guifg=#ff8700	guibg=#870000	gui=bold
hi Modestatus_select		guifg=#606060	guibg=#ffffff	gui=bold
if &t_Co > 255
	hi Modestatus_normal		ctermfg=148		ctermbg=22		cterm=bold
	hi Modestatus_insert		ctermfg=23		ctermbg=117		cterm=bold
	hi Modestatus_replace		ctermfg=160		ctermbg=231		cterm=bold
	hi Modestatus_visual		ctermfg=208		ctermbg=88		cterm=bold
	hi Modestatus_select		ctermfg=241		ctermbg=231		cterm=bold
else
	hi link Modestatus_normal	StatusLine
	hi link Modestatus_insert	StatusLine
	hi link Modestatus_replace	StatusLine
	hi link Modestatus_visual	StatusLine
	hi link	Modestatus_select	StatusLine
endif

" linnk current color to statusline
hi link Modestatus_current StatusLine
" change color and return mode id

function! Modestatus_GetMode()
	let mode=mode()
	if mode =~# '\vi'
		hi link Modestatus_current Modestatus_insert
		return g:Modestatus_mode_insert
	elseif mode =~# '\v(R|Rv)'
		hi link Modestatus_current Modestatus_replace
		return g:Modestatus_mode_replace
	elseif mode =~# '\vv'
		hi link Modestatus_current Modestatus_visual
		return g:Modestatus_mode_visual
	elseif mode =~# '\vV'
		hi link Modestatus_current Modestatus_visual
		return g:Modestatus_mode_visualLine
	elseif mode =~# '\v'
		hi link Modestatus_current Modestatus_visual
		return g:Modestatus_mode_visualBlock
	elseif mode =~# '\vs'
		hi link Modestatus_current Modestatus_select
		return g:Modestatus_mode_select
	elseif mode =~# '\vS'
		hi link Modestatus_current Modestatus_select
		return g:Modestatus_mode_selectLine
	elseif mode =~# '\v'
		hi link Modestatus_current Modestatus_select
		return g:Modestatus_mode_selectBlock
	else
		hi link Modestatus_current Modestatus_normal
		return g:Modestatus_mode_normal
	endif
endfunction

" active/inactive statusline switch
autocmd BufEnter,WinEnter * let &l:statusline=g:Modestatus_statusline
autocmd BufLeave,WinLeave * let &l:statusline=g:Modestatus_statuslineNC
