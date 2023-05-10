lua vim.loader.enable()

" nvim -u init.vim で起動すると
" $MYVIMRCがセットされないので一部の設定が機能しなくなる
let $MYVIMRC = $MYVIMRC ?? expand('<sfile>:p')
const s:here = $MYVIMRC->fnamemodify(':h')

augroup VimRc
  autocmd!
  " 最初に'filetype'オプションがセットされたときに以下を有効化する
  "   - ftplugin scriptの検出
  "   - indent scriptの検出
  "   - syntax scriptの検出
  " NOTE: `$ nvim file.vim` のように起動するとftがセットされないので実行されない(つらい)
  autocmd FileType * ++once call map(
        \   [
        \     'filetype plugin indent on',
        \     'syntax enable'
        \   ],
        \   { _, cmd -> execute(cmd) }
        \ )
augroup END

" filetypeの検出を有効化する
filetype off
" filetypeプラグインの検出を無効化する
filetype plugin indent off
" 構文ファイルの読み込みを無効化する
syntax off

" VimEnterより後には実行したくないやつ
augroup VimEnterPre
  autocmd!
  " Vimが起動したときにこのグループに所属してるやつを全部消す
  autocmd VimEnter * autocmd! VimEnterPre
  " 起動前にもFileTypeを発火させたい
  autocmd BufReadPost,BufNewFile * ++once filetype detect
augroup END

" cmdlineにおけるエイリアスを定義する
" [{ keyword: string, input: string, input_after: string? }]
let g:AlterCommands = []

let g:dein#inline_vimrcs = [
      \ s:here .. '/commands.vim',
      \ s:here .. '/options.vim',
      \ s:here .. '/keymaps.vim',
      \ s:here .. '/chezmoi.vim',
      \ s:here .. '/nvim-lsp.lua',
      \ ]

execute 'source' s:here .. '/dein.vim'
