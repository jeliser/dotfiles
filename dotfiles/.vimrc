"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
" Settings
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
execute pathogen#infect()
set filetype=off
set filetype=on
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
set number
set mouse=a

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
" Startup the Bundles
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

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

" Open new tab
map  <F5> :tabe ./<CR>
imap <F5> <ESC>:tabe ./<CR>
cmap <F5> <ESC><ESC>:tabe ./<CR>

" Previous tab
map  <F6> :tabp<CR>
imap <F6> <ESC>:tabp<CR>
cmap <F6> <ESC><ESC>:tabp<CR>

" Next tab
map  <F7> :tabn<CR>
imap <F7> <ESC>:tabn<CR>
cmap <F7> <ESC><ESC>:tabn<CR>

" Close tab
map  <F8> :tabc<CR>
imap <F8> <ESC>:tabc<CR>
cmap <F8> <ESC><ESC>:tabc<CR>

" Run make and open the outputs in another tab
map  <F9> :call RunMake()<CR>
imap <F9> <ESC>:call RunMake()<CR>
cmap <F9> <ESC><ESC>:call RunMake()<CR>

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

fun! RunMake()
"  :tabe ./ | make
"  :tabe ./ | make | vert copen | winc =
  :tabe | exec "AsyncMake" | tabp
endfun

fun! Replace_M()
  :exe '%s///ge'
endfun




