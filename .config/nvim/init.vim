" - - - Vim Configuration

" - Colors

" " Custom
" hi TabLine cterm=italic ctermfg=8 ctermbg=0
" hi TabLineFill cterm=none ctermfg=8 ctermbg=none
" hi TabLineSel cterm=italic ctermfg=6 ctermbg=0
" hi Title cterm=bold ctermfg=none ctermbg=none
" hi StatusLine cterm=italic ctermfg=6 ctermbg=none
" hi StatusLineNC cterm=italic ctermfg=8 ctermbg=none
" hi VertSplit cterm=none ctermfg=6 ctermbg=none
" hi WildMenu cterm=italic ctermfg=8 ctermbg=0
" hi ModeMsg cterm=bold ctermfg=6 ctermbg=none
" hi ErrorMsg cterm=italic ctermfg=9 ctermbg=none
" hi LineNr cterm=none ctermfg=15 ctermbg=none
" hi LineNrAbove cterm=none ctermfg=8 ctermbg=none
" hi LineNrBelow cterm=none ctermfg=8 ctermbg=none
" hi CursorLine cterm=none ctermfg=none ctermbg=0
" hi CursorLineNr cterm=none ctermfg=15 ctermbg=none
" hi Folded cterm=none ctermfg=14 ctermbg=0
" hi Operator cterm=none ctermfg=11
" hi Identifier cterm=none

" Seoul-256
set bg=dark
let g:seoul256_background = 235
set cul
"colo seoul256
colo stellarized

" - Options

set autochdir              " Working directory matches current file
set autoindent             " New line indents to match previous line
set background=dark        " Ensure a dark background
set belloff=all            " Be quiet
set clipboard+=unnamedplus " Use system clipboard
set ignorecase             " Search is case-insensitive
set incsearch              " Search begins while typing query
set laststatus=1           " Statusline only on splits
set nohls                  " Disable highlighted search
set noruler                " Disable ruler
set nowrap                 " Disable line wrapping
set showcmd                " Show keystrokes and size of visual selections
set noshowmode             " Do not show current mode
set number                 " Line numbers
set relativenumber         " Relative line numbers 
set shortmess=I            " Disable intro message
set showtabline=2          " Tabline always
set smartcase              " if query is all lower case
set splitbelow             " Horizontal splits open below current
set splitright             " Vertical splits open to the right of current
set title                  " Pass title to terminal emulator
set ttimeoutlen=5          " Reduced key delay
set undofile               " Preserve undo tree across file closures
set wildmenu               " Menu for command completions
syntax on                  " Syntax coloring

" Cursor
let &t_SI.="\e[6 q"   " Line cursor in insert mode
let &t_EI.="\e[2 q"   " Block cursor in other modes

" Indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
filetype indent on

" Backup, swap, and undo file locations
" set backupdir=~/.vim/backup//
" set directory=~/.vim/swap//
" set undodir=~/.vim/undo//

" Backspace behavior
set backspace=indent,eol,start

" path for find commands
set path=.,/usr/include,/usr/local/include,/home/eric

" - Keymaps

" Leader
let mapleader=' '

" Fast quit
nnoremap <bs> :q<cr>

" Easy redo
nnoremap U <c-r>

" Buffer navigation
nnoremap <leader>n :bn<cr>
nnoremap <leader>p :bp<cr>

" Viewport navigation
nnoremap <leader>w <c-w>w
nnoremap <leader><space> <c-w>w
nnoremap <leader>x :sp<space>
nnoremap <leader>v :vsp<space>

" Tab navigation
nnoremap <leader><tab> :tabn<cr>
nnoremap <s-tab> :tabp<cr>
nnoremap <leader>t <c-w>T

" Substitution
nnoremap <leader>s :s//g<left><left>
nnoremap <leader>S :%s//g<left><left>

" o / O
nnoremap 2o o<Esc>o
nnoremap 2O O<Esc>O
nnoremap 1o o<Esc>o<Esc>o<Esc>ki
nnoremap 1O O<Esc>O<Esc>O<Esc>ji

" Comments
nnoremap <leader>* O/**/<esc><left>i<space><space><esc>i

" Edit vimrc
nnoremap <leader>= :tabedit<space>~/.config/nvim/init.vim<cr>

" Visual line shifts
vnoremap H <gv
vnoremap J :m<space>'>+1<cr>gv=gv
vnoremap K :m<space>'<-2<cr>gv=gv
vnoremap L >gv

" Centered mode

function! ToggleCentered()
  if &scrolloff ==# 0
    set scrolloff=99
  else
    set scrolloff=0
  endif
endfunction

nnoremap <silent><leader>c :call<space>ToggleCentered()<cr>

" Netrw

nnoremap <leader>- :Explore<cr>
let g:netrw_banner=0

" Scroll by paragraphs

function! ScrollDownByPara()
	if &scrolloff ==# 99
		set scrolloff=0
	endif
	execute "normal H}}"
 	if line(".") == line("$")
		echo "BOT"
	endif
	execute "normal {jztL"
endfunction

function! ScrollUpByPara()
	if &scrolloff ==# 99
		set scrolloff=0
	endif
	execute "normal H{{jzt"
	if line(".") == 2
		execute "normal k"
		echo "TOP"
	endif
	execute "normal L"
endfunction

nnoremap <silent><leader>J :call<space>ScrollDownByPara()<cr>
nnoremap <silent><leader>K :call<space>ScrollUpByPara()<cr>

function! WordCount()
   let s:old_status = v:statusmsg
   let position = getpos(".")
   exe ":silent normal g\<c-g>"
   let stat = v:statusmsg
   let s:word_count = 0
   if stat != '--No lines in buffer--'
     let s:word_count = str2nr(split(v:statusmsg)[11])
     let v:statusmsg = s:old_status
   end
   call setpos('.', position)
   return s:word_count 
endfunction

function! ShowWordCountInRuler()
	if &ru == 0
		set ruf=%9(%{WordCount()}\ words%)
		set ru
	else
		set ruf=
		set noru
	endif
endfunction

" - Autocommands

" Disable automatic commenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Open at last cursor insert-mode cursor position
" autocmd VimEnter * execute "normal `."

" Neovide

set guifont=mono:h20

let g:neovide_refresh_rate=140
let g:neovide_transparency=1
let g:neovide_profiler = v:false
let g:neovide_cursor_animation_length=0.03
" let g:neovide_cursor_vfx_mode = "railgun"

