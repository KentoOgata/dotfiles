" sh,vim,help,c以外の多くのftでは不要
nnoremap K <Nop>
call nvim_create_autocmd('FileType', #{
      \ pattern: ['bash', 'zsh', 'sh', 'vim', 'help', 'c', 'cpp'],
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

" Emacs-style key mappings
Keymap ic <C-a> <Home>
Keymap ic <C-e> <End>
Keymap ic <A-f> <Cmd>normal! w<CR>
Keymap ic <A-b> <Cmd>normal! b<CR>
Keymap ic <C-f> <C-g>U<Right>
Keymap ic <C-b> <C-g>U<Left>
" 補完のpopupmenuには影響しない
inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-k> <Cmd>normal! D<CR><C-g>U<Right>
