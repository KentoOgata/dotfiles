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
  autocmd FileType * ++once
        \ : filetype plugin indent on
        \ | syntax enable
augroup END

" 起動前にfiletype系のスクリプトを読み込む必要はないので無効化する
" NOTE: filetype offにしてても起動したらonになってる なんでかはわからん
filetype off
filetype plugin indent off
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
" [{ char: string, input: string, input_after: string? }]
let g:AlterCommands = []

" yankした範囲をハイライトする
autocmd VimRc TextYankPost * silent! lua vim.highlight.on_yank()

lua << EOF
vim.api.nvim_create_autocmd('VimEnter', {
  group = 'VimRc',
  once = true,
  desc = '起動したときに "$(getcwd())/.env" を読み込んで環境変数を定義する',
  callback = function()
    local path = vim.fs.joinpath(vim.fn.getcwd(), '.env')
    if 1 == vim.fn.filereadable(path) then
      for line in io.lines(path) do
        local k, v = line:match('([^=]*)=([^=]*)')
        vim.env[k] = v
      end
    end
  end
})
EOF

let g:dein#inline_vimrcs = [
      \ s:here .. '/global.lua',
      \ s:here .. '/commands.vim',
      \ s:here .. '/options.vim',
      \ s:here .. '/keymaps.vim',
      \ s:here .. '/chezmoi.vim',
      \ s:here .. '/nvim-lsp.lua',
      \ ]

execute 'source' s:here .. '/dein.vim'
