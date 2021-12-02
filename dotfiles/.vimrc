"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
" Settings
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
"execute pathogen#infect()
set filetype=off
set filetype=on
syntax enable
filetype plugin indent on 
set ruler
set hlsearch
set showcmd
set background=dark
set title
set shell=bash
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set comments=
set hid
set nowrap
set backspace=indent,eol,start
set number
set mouse=a
set t_vb=
set laststatus=2

set backup
set backupdir=~/.vim/local/backup/
set viewdir=~/.vim/local/view/
set directory=~/.vim/local/swap/


" Set syntax highlighting for particular files
au BufEnter,BufRead,BufNewFile,BufReadPost SCons* set syntax=python
au BufEnter,BufRead,BufNewFile,BufReadPost *.yaml set syntax=yaml
au BufEnter,BufRead,BufNewFile,BufReadPost Jenkins* set syntax=groovy
au BufEnter,BufRead,BufNewFile,BufReadPost *.gradle set syntax=groovy
au BufEnter,BufRead,BufNewFile,BufReadPost *.icc set filetype=cpp
au BufEnter,BufRead,BufNewFile,BufReadPost *.dockerfile set filetype=dockerfile
au BufEnter,BufRead,BufNewFile,BufReadPost *.toml set filetype=toml
" Set syntax highlighting for Jinja files
au BufEnter,BufRead,BufNewFile,BufReadPost *.py.jinja set syntax=python
au BufEnter,BufRead,BufNewFile,BufReadPost *.yml.jinja set syntax=yaml
au BufEnter,BufRead,BufNewFile,BufReadPost *.yaml.jinja set syntax=yaml

" Force the Python stops to be 2
au FileType python setl expandtab shiftwidth=2 softtabstop=2 tabstop=2

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
" Startup the Bundles
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

set rtp+=~/.vim/bundle/vundle
call vundle#rc()
Plugin 'cespare/vim-toml'
call vundle#end()

"let g:ycm_confirm_extra_conf = 0
"let g:ycm_enable_diagnostic_signs = 0
"let g:ycm_enable_diagnostic_highlighting = 0

" Remap the binding so you can jump into functions and back quickly.
"nnoremap <C-]> :YcmCompleter GoToDefinitionElseDeclaration<CR>
"nnoremap <C-[> <C-o>

" Set the UndoTree save directory
if has("persistent_undo")
  set undolevels=1000
  set undoreload=10000
  set undodir=~/.vim/local/undo/
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

" 80 column coloring options
"
"if exists('+colorcolumn')
"  set colorcolumn=80
"else
"  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
"endif
"
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
" Key Mappings
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
"
"Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse> 

" Folding Up Functions zfa}
map  <C-L> zfa}<CR>
imap <C-L> <ESC>zfa}<CR>
cmap <C-L> <ESC><ESC>zfa}<CR>

" Remove line numbers
map  <F4> :set nonumber<CR>
imap <F4> <ESC>:set nonumber<CR>
cmap <F4> <ESC><ESC>:set nonumber<CR>

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

" Paste the contents from the system clipboard into vim
map <F9> i<C-r>* <ESC>
imap <F9> <C-r>*
cmap <F9> <C-r>*

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


