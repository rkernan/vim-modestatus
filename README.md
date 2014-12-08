# Modestatus

Modestatus is (yet another) statusline replacement aimed at users who prefer
an easy to configure, minimalist vim statusline.

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
concisely, so here's an example:

![example1][example1]

```viml
call modestatus#extensions#enable('core')
call modestatus#extensions#enable('loclist')

call modestatus#highlight#copymod('Statusline', 'User1', {
    \ 'term':  'bold',
    \ 'cterm': 'bold',
    \ 'gui':   'bold'})
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
    \ 'guifg':   'White', 'guibg': '#af0000'})
call modestatus#highlight#copymod('Statusline', 'User9', {
    \ 'ctermfg': 'Black', 'ctermbg': '178',
    \ 'guifg':   'Black', 'guibg': '#dfaf00'})

call modestatus#colors#add('bold', 1)
call modestatus#colors#add('ylw_bold', 2)
call modestatus#colors#add('red_bold', 3)
call modestatus#colors#add('error', 8)
call modestatus#colors#add('warning', 9)

let g:modestatus#statusline = {
        \ 'active': {
        \   'left': [
        \     'line_percent',
        \     'position',
        \     'mode',
        \     'filename',
        \     'modified',
        \     'readonly',
        \     'paste',
        \     'filetype',
        \     'encoding',
        \     'fileformat',
        \     'loclist_errors',
        \     'loclist_warnings',
        \   ],
        \   'right': [
        \   ]
        \ },
        \ 'inactive': {
        \   'left': [
        \     'filename',
        \     'modified',
        \     'readonly',
        \     'filetype',
        \     'encoding',
        \     'fileformat',
        \     'loclist_errors',
        \     'loclist_warnings'
        \   ],
        \   'right': [
        \   ]
        \ }}

call modestatus#options#add('filename', {
    \ 'active': {
    \     'color': 'bold'
    \ }})
call modestatus#options#add('mode', {
    \ 'active': {
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
    \     'format': [%s]
    \ }})
call modestatus#options#add('encoding', {
    \ 'active': {
    \     'format': '[%s:',
    \     'nosep': 1
    \ },
    \ 'inactive': {
    \     'format': '[%s:',
    \     'nosep': 1
    \ }})
call modestatus#options#add('fileformat', {
    \ 'active': {
    \     'format': '%s]',
    \     'nosep': 1
    \ },
    \ 'inactive': {
    \     'format': '%s]',
    \     'nosep': 1
    \ }})
call modestatus#options#add('loclist_errors', {
    \ 'active': {
    \     'color': 'error',
    \     'format': ' %s ',
    \     'nosep': 1
    \ },
    \ 'inactive': {
    \     'nosep': 1
    \ }})
call modestatus#options#add('loclist_warnings', {
    \ 'active': {
    \     'color': 'warning',
    \     'format': ' %s ',
    \     'nosep': 1
    \ },
    \ 'inactive': {
    \     'nosep': 1
    \ }})
```

## License

MIT License. Copyright (c) 2014 Robert Kernan

[example1]: https://raw.githubusercontent.com/kernan/i/master/vim-modestatus/example1.gif
[neobundle]: https://github.com/Shougo/neobundle.vim
[pathogen]: https://github.com/tpope/vim-pathogen
[vim-plug]: https://github.com/junegunn/vim-plug
[vundle]: https://github.com/gmarik/Vundle.vim
