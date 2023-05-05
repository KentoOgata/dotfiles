HISTFILE="${HOME}/.zsh_history"
HISTSIZE=1000
SAVEHIST=1000
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt EXTENDED_HISTORY

if [ -f "${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
        source "${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
        bindkey '^f' autosuggest-accept
fi
