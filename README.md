# Modestatus

Modestatus is (yet another) statusline replacement!

## Installation

Just choose your favorite plugin manager:

- [NeoBundle](https://github.com/Shougo/neobundle.vim)
  - `NeoBundle 'kernan/vim-modestatus'`
- [Pathogen](https://github.com/tpope/vim-pathogen)
  - `git clone https://github.com/kernan/vim-modestatus.git ~/.vim/bundle/`
- [vim-plug](https://github.com/junegunn/vim-plug)
  - `Plug 'kernan/vim-modestatus'`
- [Vundle](https://github.com/gmarik/Vundle.vim)
  - `Plugin 'kernan/vim-modestatus'`

## Supported Plugins

- [ALE](https://github.com/w0rp/ale)
- [Denite](https://github.com/Shougo/denite.nvim)
- [Fugitive](https://github.com/tpope/vim-fugitive)
- [Signify](https://github.com/mhinz/vim-signify)

## Example Statusline

![screenshot](https://raw.github.com/kernan/vim-modestatus/master/statusline.png)

```viml
let g:modestatus#statusline = [
	\		['mode'],
	\		['fugitive_branch', 'signify_added', 'signify_modified', 'signify_removed'],
	\		'filename', 'modified', 'readonly', 'filetype', 'ale_errors', 'ale_warnings', 'ale_style_errors', 'ale_style_warnings',
	\		'%=',
	\		'expandtab', 'shiftwidth', 'encoding', 'bomb', 'fileformat',
	\		['line', 'column', 'line_percent']
	\	]

let g:modestatus#statusline_override_denite = [['denite_mode'], 'denite_sources', 'denite_path', 'filetype', '%=', ['line', 'line_max', 'line_percent']]
let g:modestatus#statusline_override_fugitiveblame = ['filetype', '%=', ['line', 'line_max', 'line_percent']]
let g:modestatus#statusline_override_qf = [['mode'], 'buftype', 'filetype', '%=', ['line', 'line_max', 'line_percent']]

augroup vimrc
	" overrides
	autocmd FileType denite call modestatus#setlocal('denite')
	autocmd FileType fugitiveblame call modestatus#setlocal('fugitiveblame')
	autocmd FileType qf call modestatus#setlocal('qf')
augroup END

call modestatus#options#add('mode', 'color', 'ModestatusMode')
call modestatus#options#add('fugitive_branch', 'color', ['Modestatus2', 'Modestatus2NC'])
call modestatus#options#add('signify_added', 'color', ['Modestatus2Green', 'Modestatus2NCGreen'])
call modestatus#options#add('signify_modified', 'color', ['Modestatus2Aqua', 'Modestatus2NCAqua'])
call modestatus#options#add('signify_removed', 'color', ['Modestatus2Red', 'Modestatus2NCRed'])
call modestatus#options#add('filename', 'color', ['ModestatusBold', 'ModestatusNC'])
call modestatus#options#add('modified', 'color', ['ModestatusRedBold', 'ModestatusNCRedBold'])
call modestatus#options#add('readonly', 'color', ['ModestatusRed', 'ModestatusNCRed'])
call modestatus#options#add('ale_errors', 'color', ['ModestatusRed', 'ModestatusNCRed'])
call modestatus#options#add('ale_errors', 'format', '•%s')
call modestatus#options#add('ale_warnings', 'color', ['ModestatusYellow', 'ModestatusNCYellow'])
call modestatus#options#add('ale_warnings', 'format', '•%s')
call modestatus#options#add('ale_style_errors', 'color', ['ModestatusPurple', 'ModestatusNCPurple'])
call modestatus#options#add('ale_style_errors', 'format', '•%s')
call modestatus#options#add('ale_style_warnings', 'color', ['ModestatusAqua', 'ModestatusNCAqua'])
call modestatus#options#add('ale_style_warnings', 'format', '•%s')
call modestatus#options#add('expandtab', 'format', '[%s')
call modestatus#options#add('shiftwidth', 'format', '%s]')
call modestatus#options#add('encoding', 'format', '[%s')
call modestatus#options#add('encoding', 'separator', 0)
call modestatus#options#add('bomb', 'format', '-%s')
call modestatus#options#add('bomb', 'separator', 0)
call modestatus#options#add('fileformat', 'format', ':%s]')
call modestatus#options#add('line', 'color', ['Modestatus2', 'Modestatus2NC'])
call modestatus#options#add('line', 'separator', 0)
call modestatus#options#add('column', 'format', ',%s')
call modestatus#options#add('column', 'color', ['Modestatus2', 'Modestatus2NC'])
call modestatus#options#add('line_max', 'format', '/%s')
call modestatus#options#add('line_max', 'color', ['Modestatus2', 'Modestatus2NC'])
call modestatus#options#add('line_percent', 'color', ['Modestatus2', 'Modestatus2NC'])
call modestatus#options#add('denite_mode', 'color', 'ModestatusMode')
call modestatus#options#add('denite_sources', 'color', ['ModestatusBold', 'ModestatusNC'])

```

The above uses the excellent [gruvbox](https://github.com/morhetz/gruvbox) vim colorscheme.

```viml
function! s:get_gruvbox_color(group)
	let gui_color = synIDattr(hlID(a:group), 'fg', 'gui')
	let term_color = synIDattr(hlID(a:group), 'fg', 'cterm')
	return [gui_color, term_color]
endfunction

function! s:hl(group, fg, bg, emphasis)
	execute 'highlight ' . a:group . ' guifg=' . a:fg[0] . ' guibg=' . a:bg[0] . ' gui=' . a:emphasis .
		\                        ' ctermfg=' . a:fg[1] . ' ctermbg=' . a:bg[1] . ' cterm=' . a:emphasis
endfunction

let s:bg0 = s:get_gruvbox_color('GruvboxBg0')
let s:bg1 = s:get_gruvbox_color('GruvboxBg1')
let s:bg2 = s:get_gruvbox_color('GruvboxBg2')
let s:bg3 = s:get_gruvbox_color('GruvboxBg3')
let s:bg4 = s:get_gruvbox_color('GruvboxBg4')
let s:fg0 = s:get_gruvbox_color('GruvboxFg0')
let s:fg1 = s:get_gruvbox_color('GruvboxFg1')
let s:fg2 = s:get_gruvbox_color('GruvboxFg2')
let s:fg3 = s:get_gruvbox_color('GruvboxFg3')
let s:fg4 = s:get_gruvbox_color('GruvboxFg4')
let s:red = s:get_gruvbox_color('GruvboxRed')
let s:green = s:get_gruvbox_color('GruvboxGreen')
let s:yellow = s:get_gruvbox_color('GruvboxYellow')
let s:aqua = s:get_gruvbox_color('GruvboxAqua')
let s:blue = s:get_gruvbox_color('GruvboxBlue')
let s:orange = s:get_gruvbox_color('GruvboxOrange')

" active statusline colors
call s:hl('StatusLine', s:fg4, s:bg2, 'none')
call s:hl('ModestatusBold', s:fg4, s:bg2, 'bold')
call s:hl('ModestatusRed', s:red, s:bg2, 'none')
call s:hl('ModestatusRedBold', s:red, s:bg2, 'bold')
call s:hl('Modestatus2', s:fg3, s:bg3, 'none')
call s:hl('Modestatus2Red', s:red, s:bg3, 'none')
call s:hl('Modestatus2Green', s:green, s:bg3, 'none')
call s:hl('Modestatus2Aqua', s:aqua, s:bg3, 'none')
" inactive statusline colors
call s:hl('StatusLineNC', s:bg4, s:bg1, 'none')
call s:hl('ModestatusNCRed', s:red, s:bg1, 'none')
call s:hl('ModestatusNCRedBold', s:red, s:bg1, 'bold')
call s:hl('ModestatusNCYellow', s:yellow, s:bg1, 'none')
call s:hl('Modestatus2NC', s:fg4, s:bg2, 'none')
call s:hl('Modestatus2NCRed', s:red, s:bg2, 'none')
call s:hl('Modestatus2NCGreen', s:green, s:bg2, 'none')
call s:hl('Modestatus2NCAqua', s:aqua, s:bg2, 'none')
" mode colors
call s:hl('ModestatusModeNormal', s:bg0, s:fg4, 'none')
call s:hl('ModestatusModeInsert', s:bg0, s:blue, 'none')
call s:hl('ModestatusModeReplace', s:bg0, s:aqua, 'none')
call s:hl('ModestatusModeVisual', s:bg0, s:orange, 'none')
call s:hl('ModestatusModeVisualLine', s:bg0, s:orange, 'none')
call s:hl('ModestatusModeVisualBlock', s:bg0, s:orange, 'none')
```

# License

MIT License. Copyright (c) 2014-2017 Robert Kernan
