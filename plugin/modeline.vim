" Modeline.vim
" @author Robert Kernan
" @created 10-12-2012
" @modified 10-12-2012

" mode dispay names
if !exists('g:Modeline_mode_normal')
	let g:Modeline_mode_normal='NORMAL'
endif
if !exists('g:Modeline_mode_insert')
	let g:Modeline_mode_insert='INSERT'
endif
if !exists('g:Modeline_mode_replace')
	let g:Modeline_mode_replace='REPLACE'
endif
if !exists('g:Modeline_mode_visual')
	let g:Modeline_mode_visual='VISUAL'
endif
if !exists('g:Modeline_mode_visualLine')
	let g:Modeline_mode_visualLine='VISUAL-LINE'
endif
if !exists('g:Modeline_mode_visualBlock')
	let g:Modeline_mode_visualBlock='VISUAL-BLOCK'
endif
if !exists('g:Modeline_mode_select')
	let g:Modeline_mode_select='SELECT'
endif
if !exists('g:Modeline_selectLine')
	let g:Modeline_mode_selectLine='SELECT-LINE'
endif
if !exists('g:Modeline_selectBlock')
	let g:Modeline_mode_selectBlock='SELECT-BLOCK'
endif

" active statusline
if !exists('g:Modeline_statusline')
	let g:Modeline_statusline='%#Modeline_current#%{Modeline_GetMode()}%* [%n] %f %{&mod?"+":""}%r [%{strlen(&ft)?&ft:"none"}, %{strlen(&fenc)?&fenc:&enc}, %{&fileformat}]%=%l/%L,%c'
endif
" inactive statusline
if !exists('g:Modeline_statuslineNC')
	let g:Modeline_statuslineNC='[%n] %f %{&mod?"+":""}%r [%{strlen(&ft)?&ft:"non"}, %{strlen(&fenc)?&fenc:&enc}, %{&fileformat}]%=%l/%L,%c'
endif

" mode colors
hi Modeline_normal		guifg=#afdf00	guibg=#005f00	gui=bold	ctermfg=148		ctermbg=22		cterm=bold
hi Modeline_insert		guifg=#005f5f	guibg=#87dfff	gui=bold	ctermfg=23		ctermbg=117		cterm=bold
hi Modeline_replace		guifg=#df0000	guibg=#ffffff	gui=bold	ctermfg=160		ctermbg=231		cterm=bold
hi Modeline_visual		guifg=#ff8700	guibg=#870000	gui=bold	ctermfg=208		ctermbg=88		cterm=bold
hi Modeline_select		guifg=#606060	guibg=#ffffff	gui=bold	ctermfg=241		ctermbg=231		cterm=bold

" linnk current color to statusline
hi link Modeline_current Statusline
" change color and return mode id

function! Modeline_GetMode()
	let mode=mode()
	if mode =~# '\vi'
		hi link Modeline_current Modeline_insert
		return g:Modeline_mode_insert
	elseif mode =~# '\v(R|Rv)'
		hi link Modeline_current Modeline_repace
		return g:Modeline_mode_replace
	elseif mode =~# '\vv'
		hi link Modeline_current Modeline_visual
		return g:Modeline_mode_visual
	elseif mode =~# '\vV'
		hi link Modeline_current Modeline_visual
		return g:Modeline_mode_visualLine
	elseif mode =~# '\v'
		hi link Modeline_current Modeline_visual
		return g:Modeline_mode_visualBlock
	elseif mode =~# '\vs'
		hi link Modeline_current Modeline_select
		return g:Modeline_mode_select
	elseif mode =~# '\vS'
		hi link Modeline_current Modeline_select
		return g:Modeline_mode_selectLine
	elseif mode =~# '\v'
		hi link Modeline_current Modeline_select
		return g:Modeline_mode_selectBlock
	else
		hi link Modeline_current Modeline_normal
		return g:Modeline_mode_normal
	endif
endfunction

" active/inactive statusline switch
autocmd BufEnter,WinEnter * let &l:statusline=g:Modeline_statusline
autocmd BufLeave,WinLeave * let &l:statusline=g:Modeline_statuslineNC
