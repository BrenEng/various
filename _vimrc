set modelines=1

" Language {{{
set langmenu=en_US
let $LANG = 'en_US'
"}}}

"Appearance {{{
colorscheme slate

set number

set cursorline
autocmd ColorScheme * highlight LineNr ctermfg=DarkYellow ctermbg=black guibg=black guifg=#ffae00
autocmd ColorScheme * highlight CursorLineNr ctermfg=green ctermbg=black guibg=black guifg=green cterm=bold
autocmd ColorScheme * highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE

"You complete me menu
highlight Pmenu ctermfg=2 ctermbg=3 guifg=#ffae00 guibg=#000000

silent! set winheight=35
silent! set winminheight=5
silent! set winwidth=40
silent! set winminwidth=10
"}}}

"Shortcut keys {{{

let mapleader=","       " leader is comma

nnoremap <leader>ev :vsp $MYVIMRC<CR>  
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader><space> :nohlsearch<CR>
nnoremap <space> za
" highlight last inserted text
nnoremap gV `[v`]
" toggle gundo
nnoremap <leader>u :GundoToggle<CR>
" save session
nnoremap <leader>s :mksession<CR>
" open ag.vim
nnoremap <leader>a :Ag


" || (double click console) is escape
"imap || <esc>

"}}}

"Autocommands {{{
autocmd vimenter * NERDTree
autocmd! BufNewFile,BufRead *.pde setlocal ft=arduino
autocmd BufEnter * let &titlestring = ' ' . expand("%:t")

augroup configgroup "language-specific settings
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md
                \:call <SID>StripTrailingWhitespaces()
    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal list
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
augroup END

"}}}

"System things, sets{{{
set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

"enable syntax

set tabstop=4
set softtabstop=4
set expandtab

"set showcmd

filetype indent on
set wildmenu
"set lazydraw
set incsearch
set hlsearch

set foldenable
set foldlevelstart=10
set foldnestmax=10

" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

set runtimepath^=~/.vim/bundle/ctrlp.vim

"Syntastic recommended settings
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"remove 'thanks for flying vim'
let &titlestring = $USER . "@" . hostname() . " " . expand("%:p")
if &term == "screen"
  set t_ts=^[k
  set t_fs=^[\
endif
if &term == "screen" || &term == "xterm"
  set title
endif

set diffexpr=MyDiff()
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction
"}}}

"Plugins {{{
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

"The silver searcher (ag)
Plug 'https://github.com/ggreer/the_silver_searcher'

"Gundo, visualize undo (u) tree
Plug 'https://github.com/sjl/gundo.vim'

"Solarized colorscheme
Plug 'https://github.com/altercation/Vim-colors-solarized'

"Badwolf colorscheme
Plug 'https://github.com/sjl/badwolf/'

"Live preview for html, css, js
"add this to the page(S): <script src='http://127.0.0.1:9001/js/socket.js'></script>
Plug 'https://github.com/jaxbot/browserlink.vim'

"Airline, status/tabline
Plug 'https://github.com/vim-airline/vim-airline'

"Sensible, disabled for now
"Plug 'tpope/vim-sensible'

"Arduino syntax
Plug 'https://github.com/vim-scripts/Arduino-syntax-file'

"Code Completion
Plug 'https://github.com/Valloric/YouCompleteMe'

"Syntastic
Plug 'https://github.com/scrooloose/syntastic' 

"Ctrlp fuzzy search
Plug 'https://github.com/kien/ctrlp.vim'

"Surround, edit surrounding brackets etc
Plug 'https://github.com/tpope/vim-surround'

"Easymotion
Plug 'https://github.com/easymotion/vim-easymotion'

"Fugitive, git in vim
Plug 'https://github.com/tpope/vim-fugitive'

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Group dependencies, vim-snippets depends on ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-master branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'

" Add plugins to &runtimepath
call plug#end()
"}}}


" vim:foldmethod=marker:foldlevel=0
