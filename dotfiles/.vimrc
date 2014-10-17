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
set t_vb=

set backup
set backupdir=~/.vim/backup


" Set syntax highlighting for particular files
au BufReadPost SCons* set syntax=python
au BufReadPost *.yaml set syntax=None
au BufReadPost *.gradle set syntax=groovy

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
" Startup the Bundles
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

" Remap the binding so you can jump into functions and back quickly.
nnoremap <C-]> :YcmCompleter GoToDefinitionElseDeclaration<CR>
"nnoremap <C-[> <C-o>

" Set the UndoTree save directory
if has("persistent_undo")
  set undolevels=1000
  set undoreload=10000
  set undodir=~/.vim/.undodir/
  set undofile
endif

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


if &diff
  colorscheme evening
endif

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

" Run make and open the outputs in another tab
map  <F10> :call UndoTree()<CR>
imap <F10> <ESC>:call UndoTree()<CR>
cmap <F10> <ESC><ESC>:call UndoTree()<CR>

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

  " TODO: There has to be a better way to do the comparision
  let s:type=split(system("ls | grep Makefile | wc -l"), "\n")[0]
  if s:type == 1
    :tabe | exec "AsyncMake" | tabp
  else
    "echo "Missing a Makefile to build against"
    :tabe | call AsyncBuildCmd("scons -u -j 10 install_all") | tabp
  endif
endfun

" Run a command in an async tab with a window split
fun! AsyncBuildCmd(target)
  " TODO: This is causing an error to be thrown before showing the quick launch window
  let title = 'Building Source: '
  if a:target == ''
      let title .= "(default)"
  else
      let title .= a:target
  endif
  call asynccommand#run(a:target, asynchandler#quickfix(&errorformat, title))
  "let scons_cmd = "echo ".a:target
"  let vim_func = asynchandler#split()
"  call asynccommand#run(a:target, vim_func)
endfun

fun! Replace_M()
  :exe '%s///ge'
endfun

fun! UndoTree()
  :UndotreeToggle
endfun


