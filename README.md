# Modestatus

Modestatus is (yet another) statusline replacement aimed at users who prefer
an easy to configure, minimalist vim statusline.

It's designed to be:
- **Simple.** 100% vimscript with as few moving parts as possible.
- **Customizable.** Everything from statusline part colors to string formats
  can be modified.
- **Extensible.** Extensions can define new parts and behaviors. New extensions
  are easy to create.

## Installation

Just choose your favorite plugin manager:

- [NeoBundle][neobundle]
  - `NeoBundle 'kernan/vim-modestatus'`
- [Pathogen][pathogen]
  - `git clone https://github.com/kernan/vim-modestatus.git ~/.vim/bundle/`
- [vim-plug][vim-plug]
  - `Plug 'kernan/vim-modestatus'`
- [Vundle][vundle]
  - `Plugin 'kernan/vim-modestatus'`

## Usage

The [documentation](doc/modestatus.txt) covers behavior and usage fairly
concisely, so here's my modestatus config as an example:

![screenshot][screenshot]

```viml
" colors
hi StatusLine         guifg=#a59f85 guibg=#49483e gui=none ctermfg=20     ctermbg=19  cterm=none
hi StatusLineNC       guifg=#75715e guibg=#383830 gui=none ctermfg=08     ctermbg=18  cterm=none
hi ModestatusMode     guifg=Yellow  guibg=#49483e gui=bold ctermfg=Yellow ctermbg=19  cterm=bold
hi ModestatusFilename guifg=#a59f85 guibg=#49483e gui=bold ctermfg=20     ctermbg=19  cterm=bold
hi ModestatusModified guifg=Red     guibg=#49483e gui=bold ctermfg=Red    ctermbg=19  cterm=bold
hi ModestatusError    guifg=White   guibg=#af0000 gui=none ctermfg=White  ctermbg=124 cterm=none
hi ModestatusWarning  guifg=Black   guibg=#dfaf00 gui=none ctermfg=Black  ctermbg=178 cterm=none

" enable extensions
call modestatus#extensions#enable('core')
call modestatus#extensions#enable('loclist')

" the active/inactive statusline layout
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
    \         'loclist_errors',
    \         'loclist_warnings'
    \     ],
    \     'right': [
    \     ]
    \ },
    \ 'inactive': {
    \     'left': [
    \         'filename',
    \         'modified',
    \         'readonly',
    \         'filetype',
    \         'encoding',
    \         'fileformat',
    \         'loclist_errors',
    \         'loclist_warnings'
    \     ],
    \     'right': [
    \     ]
    \ }}

" filename overrides, part of the core extension
let g:modestatus#extensions#core#filename_override = {
    \     '[No Name]': ''
    \ }

" filename type-based overrides, part of the core extension
let g:modestatus#extensions#core#filetype_override = {
    \     'qf': '',
    \     'undotree': 'UndoTree'
    \ }

" setup general statusline part options
call modestatus#options#add('line_percent', {
    \ 'common': {
    \     'min_winwidth': 30
    \ }})
call modestatus#options#add('position', {
    \ 'common': {
    \     'min_winwidth': 30
    \ }})
call modestatus#options#add('filename', {
    \ 'active': {
    \     'color': 'ModestatusFilename',
    \ }})
call modestatus#options#add('mode', {
    \ 'active': {
    \     'color': 'ModestatusMode',
    \     'format': '‹%s›'
    \ }})
call modestatus#options#add('modified', {
    \ 'active': {
    \     'color': 'ModestatusModified'
    \ }})
call modestatus#options#add('readonly', {
    \ 'active': {
    \     'color': 'ModestatusModified'
    \ }})
call modestatus#options#add('paste', {
    \ 'active': {
    \     'color': 'ModestatusModified'
    \ }})
call modestatus#options#add('filetype', {
    \ 'common': {
    \     'format': '[%s]',
    \     'min_winwidth': 50
    \ }})
call modestatus#options#add('encoding', {
    \ 'common': {
    \     'format': '[%s:',
    \     'separator': '',
    \     'min_winwidth': 70
    \ }})
call modestatus#options#add('fileformat', {
    \ 'common': {
    \     'format': '%s]',
    \     'min_winwidth': 70
    \ }})
call modestatus#options#add('loclist_errors', {
    \ 'common': {
    \     'separator': ''
    \ },
    \ 'active': {
    \     'color': 'ModestatusError',
    \     'format': ' %s ',
    \ }})
call modestatus#options#add('loclist_warnings', {
    \ 'common': {
    \     'separator': ''
    \ },
    \ 'active': {
    \     'color': 'ModestatusWarning',
    \     'format': ' %s ',
    \ }})
```

## Extensions

Extensions exist to make it easier to add new statusline parts, but more
advanced behavior is also possible. In order for the user to initialize an
extension through modestatus it must be located in
`autoload/modestatus/extensions` and define a function
`modestatus#extensions#{name}#init()`.

[loclist](autoload/modestatus/extensions/loclist.vim) is a simple example of an
extension that adds new statusline parts.

# License

MIT License. Copyright (c) 2014-2015 Robert Kernan

[neobundle]:  https://github.com/Shougo/neobundle.vim
[pathogen]:   https://github.com/tpope/vim-pathogen
[screenshot]: https://raw.githubusercontent.com/kernan/vim-modestatus/master/screenshot.png
[vim-plug]:   https://github.com/junegunn/vim-plug
[vundle]:     https://github.com/gmarik/Vundle.vim
