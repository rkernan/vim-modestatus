# Modestatus

Modestatus is (yet another) statusline replacement aimed at users who prefer
an easy to configure, minimalist vim statusline.

## Usage

The [documentation](doc/modestatus.txt) covers behavior and usage fairly
concisely, so here's my config as an example (colors are handled in a separate
file):

```viml
let g:modestatus#statusline = [
	\   ['mode'],
	\   ['git_branch', 'hunks_added', 'hunks_modified', 'hunks_removed'],
	\   'filename', 'modified', 'readonly', 'filetype', 'loclist_errors', 'loclist_warnings',
	\   '%=',
	\   'expandtab', 'shiftwidth', 'encoding', 'bomb', 'fileformat',
	\   ['line', 'column', 'line_percent']
	\ ]

let g:modestatus#statusline_override_denite = [['denite_mode'], 'denite_sources', 'denite_path', 'filetype', '%=', ['line', 'line_max', 'line_percent']]
let g:modestatus#statusline_override_qf = [['mode'], 'filetype', '%=', ['line', 'line_max', 'line_percent']]

augroup vimrc
	" overrides
	autocmd FileType denite call modestatus#setlocal('denite')
	autocmd FileType qf call modestatus#setlocal('qf')
augroup END

call modestatus#options#add('mode', 'color', 'ModestatusMode')
call modestatus#options#add('git_branch', 'color', ['Modestatus2', 'Modestatus2NC'])
call modestatus#options#add('hunks_added', 'color', ['Modestatus2Green', 'Modestatus2NCGreen'])
call modestatus#options#add('hunks_modified', 'color', ['Modestatus2Aqua', 'Modestatus2NCAqua'])
call modestatus#options#add('hunks_removed', 'color', ['Modestatus2Red', 'Modestatus2NCRed'])
call modestatus#options#add('filename', 'color', ['ModestatusBold', 'ModestatusNC'])
call modestatus#options#add('modified', 'color', ['ModestatusRedBold', 'ModestatusNCRedBold'])
call modestatus#options#add('readonly', 'color', ['ModestatusRed', 'ModestatusNCRed'])
call modestatus#options#add('loclist_errors', 'color', ['ModestatusRed', 'ModestatusNCRed'])
call modestatus#options#add('loclist_errors', 'format', '•%s')
call modestatus#options#add('loclist_warnings', 'color', ['ModestatusYellow', 'ModestatusNCYellow'])
call modestatus#options#add('loclist_warnings', 'format', '•%s')
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

# License

MIT License. Copyright (c) 2014-2017 Robert Kernan
