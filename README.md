# Modestatus

Modestatus is (yet another) statusline replacement aimed at users who prefer
an easy to configure, minimalist vim statusline.

## Usage

The [documentation](doc/modestatus.txt) covers behavior and usage fairly
concisely, so here's my config as an example:

![screenshot](https://raw.github.com/kernan/vim-modestatus/master/statusline.png)

```viml
function! s:setup_statusline_colorscheme()
	hi StatusLine guifg=#a59f85 guibg=#49483e gui=none ctermfg=20 ctermbg=19 cterm=none
	hi StatusLineNC guifg=#75715e guibg=#49483e gui=none ctermfg=08 ctermbg=19 cterm=none
	hi ModestatusMode guifg=Yellow guibg=#49483e gui=none ctermfg=Yellow ctermbg=19 cterm=none
	hi ModestatusRed guifg=Red guibg=#49483e gui=none ctermfg=Red ctermbg=19 cterm=none
	hi ModestatusHunksAdded guifg=#a6e22e guibg=#49483e gui=none ctermfg=2 ctermbg=19 cterm=none
	hi ModestatusHunksModified guifg=#66d9ef guibg=#49483e gui=none ctermfg=4 ctermbg=19 cterm=none
	hi ModestatusHunksRemoved guifg=#f92672 guibg=#49483e gui=none ctermfg=1 ctermbg=19 cterm=none
	hi ModestatusLoclistErrors guifg=White guibg=#af0000 gui=none ctermfg=White ctermbg=124 cterm=none
	hi ModestatusLoclistWarnings guifg=Black guibg=#dfaf00 gui=none ctermfg=Black ctermbg=178 cterm=none
endfunction

call s:setup_statusline_colorscheme()

let g:modestatus#statusline = ['line_percent', 'line', 'column', 'mode', 'filename', 'modified', 'readonly', 'filetype', 'encoding', 'bomb', 'fileformat', 'hunks_added', 'hunks_modified', 'hunks_removed', 'loclist_errors', 'loclist_warnings']
let g:modestatus#statusline_override_denite = ['denite_line_percent', 'denite_line', 'denite_mode', 'denite_sources', 'denite_path', 'filetype']

let g:modestatus#parts#core#readonly_symbol = has('multi_byte') ? '🔒' : 'RO'

call modestatus#options#add('bomb', 'format', '-%s')
call modestatus#options#add('bomb', 'separator', '')
call modestatus#options#add('denite_mode', 'color', 'ModestatusMode')
call modestatus#options#add('denite_mode', 'format', has('multi_byte') ? '‹%s›' : '<%s>')
call modestatus#options#add('encoding', 'format', '[%s')
call modestatus#options#add('encoding', 'separator', '')
call modestatus#options#add('fileformat', 'format', ':%s]')
call modestatus#options#add('hunks_added', 'color', 'ModestatusHunksAdded')
call modestatus#options#add('hunks_modified', 'color', 'ModestatusHunksModified')
call modestatus#options#add('hunks_removed', 'color', 'ModestatusHunksRemoved')
call modestatus#options#add('line', 'separator', ',')
call modestatus#options#add('loclist_errors', 'color', 'ModestatusLoclistErrors')
call modestatus#options#add('loclist_warnings', 'color', 'ModestatusLoclistWarnings')
call modestatus#options#add('mode', 'format', has('multi_byte') ? '‹%s›' : '<%s>')
call modestatus#options#add('mode', 'color', 'ModestatusMode')
call modestatus#options#add('modified', 'color', 'ModestatusRed')
call modestatus#options#add('readonly', 'color', 'ModestatusRed')

augroup vimrc
	autocmd! FileType denite setlocal statusline=%!modestatus#statusline(winnr(),'denite')
	autocmd! ColorScheme * call s:setup_statusline_colorscheme()
augroup END
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
