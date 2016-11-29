set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'

" Use vdebug remote debugging plugin - http://www.vim.org/scripts/script.php?script_id=4170
Plugin 'joonty/vdebug'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

syn on
set hidden
colorscheme elflord
set showmatch
set number

set ignorecase
set smartcase
set incsearch
set hlsearch

set expandtab
set tabstop=4
set shiftwidth=4
set smarttab

set tabpagemax=20

set textwidth=0

set wildmode=longest,list

set scrolloff=4
set showcmd
set nostartofline
set foldmethod=marker

let g:syntastic_enable_signs=1

" Open file using path as path of currently open buffer
map ,e :e <C-R>=expand("%:p:h")."/"<CR>

" Ctrl-j/k to move the line up/down in command mode
nmap <C-j> mz:m+<cr>`z
nmap <C-k> mz:m-2<cr>`z

" Move around splits
map ,h <C-W>h
map ,j <C-W>j
map ,k <C-W>k
map ,l <C-W>l

" Diff what I've done since loading the buffer
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
                \ | wincmd p | diffthis

" filetype plugin indent on

" turn off php-indent brace spacing
let g:PHP_BracesAtCodeLevel=1

augroup myfiletypes
    " Clear commands in group
    autocmd!
    " autoindent with two spaces, always expand tabs
    autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et
    " Set Ruby for certain non .rb files
      autocmd BufNewFile,BufReadPost .autotest,*.watchr,Guardfile,Capfile,Cheffile setfiletype ruby
augroup END

if exists('mutt_mode')
    " It seems that when you've started completion, vim chooses to ignore
    " these mappings. That means we can simply 'invoke' the preferred
    " completion method and then C-n and C-p will behave as they should while
    " the menu is present
    ino <C-n> <C-X><C-U>
    ino <C-p> <C-X><C-U>


    fun! LBDBCompleteFn(findstart, base)
        if a:findstart
            " locate the start of the word
            let line = getline('.')
            let start = col('.') - 1
            while start > 0 && line[start - 1] =~ '[^:,]'
              let start -= 1
            endwhile
            while start < col('.') && line[start] =~ '[:, ]'
                let start += 1
            endwhile
            return start
        else
            let res = []
            let query = substitute(a:base, '"', '', 'g')
            let query = substitute(query, '\s*<.*>\s*', '', 'g')
            for m in LbdbQuery(query)
                call add(res, printf('"%s" <%s>', escape(m[0], '"'), m[1]))
            endfor
            return res
        endif
    endfun

    set completefunc=LBDBCompleteFn
endif

" detect .module files filetype
au BufRead,BufNewFile *.module call s:FTdrupal()
au BufRead,BufNewFile *.install call s:FTdrupal()
func! s:FTdrupal()
   let n = 1
   while n < 10 && n < line("$")
       if getline(n) =~ '\<\?php'
           setlocal filetype=php
           return
       endif
       let n = n + 1
   endwhile
endfunc

" from http://docs.moodle.org/en/Development:vim

" automatically indent files
set autoindent

" Do smart indentation depending on code syntax (e.g. change after { },
" keywords etc)
set smartindent

" set syntax highlighting on
syntax on

" show a ruler with line number, % through file on status line
set ruler
" PHP syntax check
set makeprg=php\ -l\ %
set errorformat=%m\ in\ %f\ on\ line\ %l
"The following mapping allows you to simply hit <enter> on an element to
"perform a search to find it.
nnoremap <silent> <buffer> <cr> :PhpSearchContext<cr>

" set file encodings
set fileencodings=ucs-bom,utf-8,gbk,big5,latin1
set termencoding=utf-8,gbk
if has ('multi_byte') && v:version > 601
  if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
    set ambiwidth=double
  endif
endif

" status line
set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
set laststatus=2

" look for etags
set tags=tags;/

" set shortcut to toggle taglist plugin
nnoremap <silent> <S-F9> :TlistToggle<CR>
let Tlist_Show_One_File = 1
let Tlist_Use_Right_Window = 1

nnoremap <silent> <S-F8> :NERDTreeToggle<CR>

nnoremap <silent> <S-F7> :BufExplorer<CR>

" show whitespace at end of lines
highlight ExtraWhitespace ctermbg=red guibg=red
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/

" difftool: ignore whitespace changes
set diffopt+=iwhite
set diffexpr=""
