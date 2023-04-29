" chezmoiで管理してるファイルを編集したとき、
" 自動で `$chezmoi apply` を実行する
autocmd VimRc BufWritePost */chezmoi/* ++once
      \ autocmd VimRc VimLeavePre * !chezmoi apply
