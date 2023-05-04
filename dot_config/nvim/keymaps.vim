let g:mapleader = "\<Space>"

" sh,vim,help,c以外の多くのftでは不要
nnoremap K <Nop>
call nvim_create_autocmd('FileType', #{
      \ pattern: ['bash', 'zsh', 'sh', 'vim', 'help', 'c', 'cpp', 'man'],
      \ group: 'VimRc',
      \ command: 'nnoremap <buffer> K K',
      \ })

" <A-,>でinit.vimを開く
nnoremap <expr> <A-,> executable('chezmoi')
      \ ? $'<Cmd>edit {system(['chezmoi', 'source-path', $MYVIMRC])}<CR>'
      \ : '<Cmd>edit $MYVIMRC<CR>'

" 空行でインサートを開始するときにインデントする
nnoremap <expr> a getline('.')->empty() ? '"_cc' : 'a'
nnoremap <expr> i getline('.')->empty() ? '"_cc' : 'i'

" Emacs-style key mappings (insert mode)
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <A-f> <Cmd>normal! w<CR>
inoremap <A-b> <Cmd>normal! b<CR>
inoremap <C-f> <C-g>U<Right>
inoremap <C-b> <C-g>U<Left>
" 補完のpopupmenuには影響しない
inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-k> <Cmd>normal! D<CR><C-g>U<Right>

" Emacs-style key mappings (cmdline mode)
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
" TODO: <A-f>と<A-b>のやつ
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
" カーソルが一番左にあるときはgetcmdpos()は1を返す
" 'hello'[:0] => 'h' なので、カーソルがh|elloにあるとき(getcmdpos() == 2)で0になるようにする
" 1のときに -2 するとおかしいのでそこだけ対応する
cnoremap <C-k> <Cmd>call setcmdline(getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos() - 2])<CR>

" Fuzzy Finder
nmap <Space>ff <Plug>(ff-files)
nmap <Space>fc <Plug>(ff-config_files)
nmap <Space>fw <Plug>(ff-grep)
nmap <Space>fh <Plug>(ff-help_tags)
nmap <Space>fs <Plug>(ff-lines)
nmap <Space>fb <Plug>(ff-buffers)
nmap <Space>fn <Plug>(ff-resume)
