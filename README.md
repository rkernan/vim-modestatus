# Modestatus

Modestatus is (yet another) statusline replacement aimed at users who prefer
an easy to configure, minimalist vim statusline.

## Usage

The [documentation](doc/modestatus.txt) covers behavior and usage fairly
concisely, so here's my modestatus config as an example:

![screenshot](https://raw.github.com/kernan/vim-modestatus/master/statusline.jpg)

![screenshot_nc](https://raw.github.com/kernan/vim-modestatus/master/statusline_nc.jpg)

```viml
hi StatusLine guifg=#a59f85 guibg=#49483e gui=none ctermfg=20 ctermbg=19 cterm=none
hi StatusLineNC guifg=#75715e guibg=#49483e gui=none ctermfg=08 ctermbg=19 cterm=none
hi ModestatusMode guifg=Yellow guibg=#49483e gui=bold ctermfg=Yellow ctermbg=19 cterm=bold
hi ModestatusFilename guifg=#a59f85 guibg=#49483e gui=bold ctermfg=20 ctermbg=19 cterm=bold
hi ModestatusModified guifg=Red guibg=#49483e gui=bold ctermfg=Red ctermbg=19 cterm=bold
hi link ModestatusModifiedNC ModestatusModified
hi ModestatusReadonly guifg=Red guibg=#49483e gui=none ctermfg=Red ctermbg=19 cterm=none
hi link ModestatusReadonlyNC ModestatusReadonly
hi link ModestatusPaste ModestatusReadonly
hi ModestatusError guifg=White guibg=#af0000 gui=none ctermfg=White ctermbg=124 cterm=none
hi ModestatusWarning guifg=Black guibg=#dfaf00 gui=none ctermfg=Black ctermbg=178 cterm=none
hi ModestatusSignifyAdded guifg=#a6e22e guibg=#49483e gui=none ctermfg=2 ctermbg=19 cterm=none
hi link ModestatusSignifyAddedNC ModestatusSignifyAdded
hi ModestatusSignifyModified guifg=#66d9ef guibg=#49483e gui=none ctermfg=4 ctermbg=19 cterm=none
hi link ModestatusSignifyModifiedNC ModestatusSignifyModified
hi ModestatusSignifyRemoved guifg=#f92672 guibg=#49483e gui=none ctermfg=1 ctermbg=19 cterm=none
hi link ModestatusSignifyRemovedNC ModestatusSignifyRemoved

call modestatus#extensions#enable('core')
call modestatus#extensions#enable('loclist')
call modestatus#extensions#enable('signify')
call modestatus#extensions#enable('denite')

" statusline
let g:modestatus#statusline = {
	\ 'active': {
	\     'left': [
	\         'line_percent',
	\         'position',
	\         'mode',
	\         'filename',
	\         'modified',
	\         'readonly',
	\         'paste',
	\         'filetype',
	\         'encoding',
	\         'fileformat',
	\         'signify_hunk_added',
	\         'signify_hunk_modified',
	\         'signify_hunk_removed',
	\         'loclist_errors',
	\         'loclist_warnings']},
	\ 'inactive': {
	\     'left': [
	\         'filename',
	\         'modified',
	\         'readonly',
	\         'filetype',
	\         'encoding',
	\         'fileformat',
	\         'signify_hunk_added',
	\         'signify_hunk_modified',
	\         'signify_hunk_removed',
	\         'loclist_errors',
	\         'loclist_warnings']}}

let g:modestatus#statusline_override = {
	\ 'denite': {'active': {'left': ['denite_line_percent', 'denite_line', 'denite_mode', 'denite_sources', 'denite_path']}},
	\ 'qf': {'active': {'left': ['line_percent', 'position', 'buftype']}, 'inactive': {'left': ['buftype']}}}

call modestatus#options#add('line_percent', {'common': {'min_winwidth': 30}})
call modestatus#options#add('position', {'common': {'min_winwidth': 30}})
call modestatus#options#add('filename', {'active': {'color': 'ModestatusFilename'}})
call modestatus#options#add('mode', {'active': {'color': 'ModestatusMode', 'format': (has('multi_byte') ? "\u2039%s\u203A" : '<%s>')}})
call modestatus#options#add('modified', {'active': {'color': 'ModestatusModified'}, 'inactive': {'color': 'ModestatusModifiedNC'}})
call modestatus#options#add('readonly', {'active': {'color': 'ModestatusReadonly'}, 'inactive': {'color': 'ModestatusReadonlyNC'}})
call modestatus#options#add('paste', {'active': {'color': 'ModestatusPaste'}})
call modestatus#options#add('filetype', {'common': {'format': '[%s]', 'min_winwidth': 50}})
call modestatus#options#add('buftype', {'active': {'color': 'ModestatusFilename'}})
call modestatus#options#add('encoding', {'common': {'format': '[%s:', 'separator': '', 'min_winwidth': 70}})
call modestatus#options#add('fileformat', {'common': {'format': '%s]', 'min_winwidth': 70}})
" signify part options
call modestatus#options#add('signify_hunk_added', {'active': {'color': 'ModestatusSignifyAdded'}, 'inactive': {'color': 'ModestatusSignifyAddedNC'}})
call modestatus#options#add('signify_hunk_modified', {'active': {'color': 'ModestatusSignifyModified'}, 'inactive': {'color': 'ModestatusSignifyModifiedNC'}})
call modestatus#options#add('signify_hunk_removed', {'active': {'color': 'ModestatusSignifyRemoved'}, 'inactive': {'color': 'ModestatusSignifyRemovedNC'}})
" loglist part options
call modestatus#options#add('loclist_errors', {'common': {'color': 'ModestatusError'}})
call modestatus#options#add('loclist_warnings', {'common': {'color': 'ModestatusWarning'}})
" denite part options
call modestatus#options#add('denite_line_percent', {'common': {'min_winwidth': 30}})
call modestatus#options#add('denite_line', {'common': {'min_winwidth': 30}})
call modestatus#options#add('denite_sources', {'active': {'color': 'ModestatusFilename'}})
call modestatus#options#add('denite_path', {'common': {'min_winwidth': 50}})
call modestatus#options#add('denite_mode', {'active': {'color': 'ModestatusMode', 'format': (has('multi_byte') ? "\u2039%s\u203A" : '<%s>')}})
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

MIT License. Copyright (c) 2014-2015 Robert Kernan
