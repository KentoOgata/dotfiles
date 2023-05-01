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
set number
set relativenumber
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

" - VimEnterの起動より前にはOptionSetが発火しないのでcolorschemeの設定に
"   合わせてVimEnter時に設定する
" - 基本的にはcursorlineなどは要らないが、light themeのときは欲しい
autocmd VimRc VimEnter * ++once
      \ : if &background ==# 'light'
      \ |   set cursorline cursorcolumn
      \ | else
      \ |   set nocursorline nocursorcolumn
      \ | endif
