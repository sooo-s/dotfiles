alias ls='ls -G'
alias tmux='tmux -u'
alias npm-exec='PATH=$(npm bin):$PATH'

HISTSIZE=5000
HISTFILESIZE=5000
HISTCONTROL=ignoreboth
HISTIGNORE='ls:ls *:pwd:exit:p-ghq*:history:history *'
HISTTIMEFORMAT="%FT%T%z "

export EDITOR=vim
export MANPAGER='less -R'
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}

# share history
function share_history {
   history -a
   history -c
   history -r
}
PROMPT_COMMAND='share_history'
shopt -u histappend

# cd + peco + ghq
function p-ghq {
  local dir="$(ghq list -p | perl -nlpe 's[.*src/(.*)][$1\0$_]' | peco --null)"
  if [ ! -z "$dir" ] ; then
    cd "$dir"
  fi
}

# 逆順にして直近の履歴を上にもってくる
p-history() {
  declare l=$(HISTTIMEFORMAT=  history | LC_ALL=C sort -r |  awk '{for(i=2;i<NF;i++){printf("%s%s",$i,OFS=" ")}print $NF}'   |  peco --query "$READLINE_LINE")
  READLINE_LINE="$l"
  READLINE_POINT=${#l}
}
bind -x '"\C-r": p-history'

export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

if [ -f "$(brew --prefix bash-git-prompt)/share/gitprompt.sh" ]; then
  GIT_PROMPT_THEME=Default
  GIT_PROMPT_ONLY_IN_REPO=1
  source "$(brew --prefix bash-git-prompt)/share/gitprompt.sh"
fi

# itermocil
complete -W "$(itermocil --list)" itermocil

eval "$(direnv hook bash)"
