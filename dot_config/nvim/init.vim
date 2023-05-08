lua vim.loader.enable()

" nvim -u init.vim で起動すると
" $MYVIMRCがセットされないので一部の設定が機能しなくなる
let $MYVIMRC = $MYVIMRC ?? expand('<sfile>:p')
const s:here = $MYVIMRC->fnamemodify(':h')

augroup VimRc
  autocmd!
  autocmd FileType * ++once filetype indent on | syntax enable
augroup END

filetype indent off
syntax off

let g:dein#inline_vimrcs = [
      \ s:here .. '/commands.vim',
      \ s:here .. '/options.vim',
      \ s:here .. '/keymaps.vim',
      \ s:here .. '/chezmoi.vim',
      \ s:here .. '/nvim-lsp.lua',
      \ ]

execute 'source' s:here .. '/dein.vim'
