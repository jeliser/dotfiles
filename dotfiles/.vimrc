
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
" Settings
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
syntax enable
set ruler
set hlsearch
set showcmd
set background=dark
set title
set shell=bash
set tabstop=2
set shiftwidth=2
set expandtab
set comments=
set hid
set nowrap
set backspace=indent,eol,start


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
" Startup the Bundles
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

"set rtp+=~/.vim/bundle/vundle
"call vundle#rc()

"Bundle 'Valloric/YouCompleteMe'

" Remap the binding so you can jump into functions and back quickly.
nnoremap <C-]> :YcmCompleter GoToDefinitionElseDeclaration<CR>
"nnoremap <C-[> <C-o>

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
" Colors
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
hi Comment      ctermfg=LightGreen   cterm=none
hi cComment     ctermfg=LightGreen   cterm=none
hi cStatement   ctermfg=Yellow       cterm=none
hi cLabel       ctermfg=Yellow       cterm=none
hi cConditional ctermfg=Yellow       cterm=none
hi cRepeat      ctermfg=Yellow       cterm=none
hi cSpecial     ctermfg=Magenta      cterm=none
hi cString      ctermfg=Red          cterm=none
hi cFormat      ctermfg=Cyan         cterm=none
hi cInclude     ctermfg=Cyan         cterm=none
hi cPreCondit   ctermfg=Cyan         cterm=none
hi cDefine      ctermfg=Red          cterm=none


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
" Key Mappings
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

" Folding Up Functions zfa}
map  <C-L> zfa}<CR>
imap <C-L> <ESC>zfa}<CR>
cmap <C-L> <ESC><ESC>zfa}<CR>

" Replace The DOS ^M
map  <F11> :call Replace_M()<CR>
imap <F11> <ESC>:call Replace_M()<CR>
cmap <F11> <ESC><ESC>:call Replace_M()<CR>

" Replace Words
map  <F12> :call Replace()<CR>
imap <F12> <ESC>:call Replace()<CR>
cmap <F12> <ESC><ESC>:call Replace()<CR>


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
" Functions
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

fun! Replace()
	let s:word = input("Replace '".expand('<cword>')."' With: ")
	if s:word != ""
		:exe '%s/'.expand('<cword>').'/'.s:word.'/ge'
		:unlet! s:word
	endif
endfun

fun! Replace_M()
  :exe '%s///ge'
endfun


