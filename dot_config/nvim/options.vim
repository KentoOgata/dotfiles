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
set colorcolumn=130
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
  set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m
endif

" set bg=light されたとき、cursorlineとcursorcolumnを有効にする
" TUIだとカーソルの位置を見失うことが多いので
autocmd VimRc OptionSet background
      \ : if v:option_new ==# 'light'
      \ |   set cursorline cursorcolumn
      \ | else
      \ |   set nocursorline nocursorcolumn
      \ | endif
