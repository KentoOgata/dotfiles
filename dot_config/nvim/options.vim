set ignorecase
set smartcase
set wrapscan
set hlsearch
set autoindent
set smartindent
set smarttab
set shiftround
set hidden
set noswapfile
set updatetime=30
set termguicolors
set cmdheight=1
set laststatus=0
set showtabline=0
set mouse=n
set inccommand=split
set secure
set fileencodings=utf-8,cp932
set fileformats=unix,dos,mac
set expandtab
set nowrap

set number relativenumber
" terminal以外ではnumber,relativenumberを有効化する
autocmd VimRc OptionSet buftype
      \ : if v:option_new ==# 'terminal'
      \ |   setl nonumber norelativenumber
      \ | else
      \ |   setl number relativenumber
      \ | endif

" rgが$PATHにあるときは`:grep`でrgを使う
if executable('rg')
  set grepprg=rg\ --vimgrep\ --ignore-case
  set grepformat=%f:%l:%c:%m
endif
AlterCmd grep silent!<Space>grep

exec 'set' 'guicursor=' .. [
     \ 'n-v-c:block',
     \ 'i-ci-ve:ver25',
     \ 'r-cr:hor20',
     \ 'o:hor50',
     \ 'a:Cursor/lCursor',
     \ 'i-ci-ve:blinkwait700-blinkoff400-blinkon250',
     \ 'sm:block-blinkwait175-blinkoff150-blinkon175',
     \ ]->join(',')
