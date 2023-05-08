export ZENO_ENABLE_SOCK=1
export ZENO_GIT_CAT="bat --color-always"
export ZENO_GIT_TREE="exa --tree"
export ZENO_HOME="${ZDOTDIR}/zeno.d"
zinit load yuki-yano/zeno.zsh
if [[ -n $ZENO_LOADED ]]; then
  bindkey ' ' zeno-auto-snippet
  export ZENO_AUTO_SNIPPET_FALLBACK=self-insert
  bindkey '^m' zeno-auto-snippet-and-accept-line
  bindkey '^i' zeno-completion
  bindkey '^x ' zeno-insert-space
  bindkey '^x^m' accept-line
  bindkey '^x^z' zeno-toggle-auto-snippet
fi
