# zsh
## zsh-completion
fpath=(/usr/local/share/zsh-completions $fpath)
## completion
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
compinit
## case-insensitive completion
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'

## history
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
bindkey -e
setopt hist_no_store
setopt hist_ignore_space
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_expand
setopt hist_reduce_blanks
setopt inc_append_history
setopt share_history



## alias
alias ls='ls -G'
alias tmux='tmux -u'
alias ql='qlmanage -p "$@" >& /dev/null'

