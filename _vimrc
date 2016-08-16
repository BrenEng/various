execute pathogen#infect()

set langmenu=en_US
let $LANG = 'en_US'
colo slate
set number

set cursorline
autocmd ColorScheme * highlight LineNr ctermfg=red ctermbg=black guibg=black guifg=orange
autocmd ColorScheme * highlight CursorLineNr ctermfg=green ctermbg=black guibg=black guifg=green cterm=bold
autocmd ColorScheme * highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE

set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

autocmd vimenter * NERDTree
autocmd! BufNewFile,BufRead *.pde setlocal ft=arduino

    set runtimepath^=~/.vim/bundle/ctrlp.vim

    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0

    silent! set winheight=35
    silent! set winminheight=5
    silent! set winwidth=40
    silent! set winminwidth=10

    autocmd BufEnter * let &titlestring = ' ' . expand("%:t")             
    set title

set diffexpr=MyDiff()
function MyDiff()
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

call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

"Sensible
Plug 'tpope/vim-sensible'

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

