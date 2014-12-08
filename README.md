# Modestatus

Modestatus is (yet another) statusline replacement aimed at users who prefer
an easy to configure, minimalist vim statusline.

It's designed to be:
- **Simple.** 100% vimscript and designed to have as few moving parts as
  possible.
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
" to keep colors consistent
hi StatusLine   guifg=#a59f85 guibg=#49483e gui=none ctermfg=20 ctermbg=19 cterm=none
hi StatusLineNC guifg=#75715e guibg=#383830 gui=none ctermfg=08 ctermbg=18 cterm=none

" enable extensions, could also use `modestatus#extensions#enable_all()`
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
    \         'loclist_warnings',
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
    \     '[No Name]':         '',
    \     '__Gundo__':         'Undo Tree',
    \     '__Gundo_Preview__': 'Undo Preview'
    \ }

" filename type-based overrides, part of the core extension
let g:modestatus#extensions#core#filetype_override = {
    \     'qf': ''
    \ }

" modify existing highlight groups
call modestatus#highlight#copymod('Statusline', 'User1', {
    \ 'term': 'bold',
    \ 'cterm': 'bold',
    \ 'gui': 'bold'})
call modestatus#highlight#copymod('Statusline', 'User2', {
    \ 'term':  'bold',
    \ 'cterm': 'bold', 'ctermfg': 'Yellow',
    \ 'gui':   'bold', 'guifg':   'Yellow'})
call modestatus#highlight#copymod('Statusline', 'User3', {
    \ 'term':  'bold',
    \ 'cterm': 'bold', 'ctermfg': 'Red',
    \ 'gui':   'bold', 'guifg':   'Red'})
call modestatus#highlight#copymod('Statusline', 'User8', {
    \ 'ctermfg': 'White', 'ctermbg': '124',
    \ 'guifg':   'White', 'guibg':   '#af0000'})
call modestatus#highlight#copymod('Statusline', 'User9', {
    \ 'ctermfg': 'Black', 'ctermbg': '178',
    \ 'guifg':   'Black', 'guibg':   '#dfaf00'})

" name the newly created highlight groups
call modestatus#colors#add('bold', 1)
call modestatus#colors#add('ylw_bold', 2)
call modestatus#colors#add('red_bold', 3)
call modestatus#colors#add('error', 8)
call modestatus#colors#add('warning', 9)

" setup general statusline part options
call modestatus#options#add('filename', {
    \ 'active': {
    \     'color': 'bold'
    \ }})
call modestatus#options#add('mode', {
    \ 'active': {
    \     'color':  'ylw_bold',
    \     'format': '‹%s›'
    \ }})
call modestatus#options#add('modified', {
    \ 'active': {
    \     'color': 'red_bold'
    \ }})
call modestatus#options#add('readonly', {
    \ 'active': {
    \     'color': 'red_bold'
    \ }})
call modestatus#options#add('paste', {
    \ 'active': {
    \     'color': 'red_bold'
    \ }})
call modestatus#options#add('filetype', {
    \ 'active': {
    \     'format': '[%s]'
    \ },
    \ 'inactive': {
    \     'format': '[%s]'
    \ }})
call modestatus#options#add('encoding', {
    \ 'active': {
    \     'format': '[%s:',
    \     'nosep':  1
    \ },
    \ 'inactive': {
    \     'format': '[%s:',
    \     'nosep':  1
    \ }})
call modestatus#options#add('fileformat', {
    \ 'active': {
    \     'format': '%s]'
    \ },
    \ 'inactive': {
    \     'format': '%s]'
    \ }})
call modestatus#options#add('loclist_errors', {
    \ 'active': {
    \     'color':  'error',
    \     'format': ' %s ',
    \     'nosep':  1
    \ },
    \ 'inactive': {
    \     'nosep': 1
    \ }})
call modestatus#options#add('loclist_warnings', {
    \ 'active': {
    \     'color':  'warning',
    \     'format': ' %s ',
    \     'nosep':  1
    \ },
    \ 'inactive': {
    \     'nosep': 1
    \
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

MIT License. Copyright (c) 2014 Robert Kernan

[neobundle]:  https://github.com/Shougo/neobundle.vim
[pathogen]:   https://github.com/tpope/vim-pathogen
[screenshot]: https://raw.githubusercontent.com/kernan/vim-modestatus/master/screenshot.png
[vim-plug]:   https://github.com/junegunn/vim-plug
[vundle]:     https://github.com/gmarik/Vundle.vim
