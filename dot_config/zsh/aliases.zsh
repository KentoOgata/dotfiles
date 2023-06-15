# exaが入ってるときはlsでexaを使う
if which exa &> /dev/null; then
  alias ls="exa --icons"
fi

# シェルからEmacsを起動するときはTUIを起動する
alias emacs='emacs -nw'
