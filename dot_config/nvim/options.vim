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
set nocursorline
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

if executable('rg')
  set grepprg=rg\ --vimgrep\ --ignore-case
  set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m
endif
