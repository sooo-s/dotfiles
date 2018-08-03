# zsh
## brew comp
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi
## completion
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
compinit
## case-insensitive completion
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'
## shift + tab
bindkey '^[[Z' reverse-menu-complete
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
setopt hist_verify
## prompt
setopt transient_rprompt

# zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh
## plugin
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting", \
  hook-load: ZSH_HIGHLIGHT_HIGHLIGHTERS="(main brackets)"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions", \
  hook-load: ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, as:theme
  SPACESHIP_PROMPT_ADD_NEWLINE=false
  SPACESHIP_PROMPT_SEPARATE_LINE=false
  SPACESHIP_CHAR_SYMBOL="$ "
  SPACESHIP_TIME_SHOW=true
  SPACESHIP_TIME_FORMAT="%D{%F (%a) %T}"
  SPACESHIP_GIT_SYMBOL="🌿 "
  SPACESHIP_EXIT_CODE_SHOW=true
  SPACESHIP_PROMPT_ORDER=( user host dir git char )
  SPACESHIP_RPROMPT_ORDER=( jobs exit_code time )

## Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  zplug install
fi
## Then, source plugins and add commands to $PATH
zplug load

# shell
export EDITOR=vim
export PATH="$PATH:./node_modules/.bin"
export PATH="$PATH:$HOME/Dropbox/bin"

## alias
alias ls='ls -G'
alias tmux='tmux -u'
alias ql='qlmanage -p "$@" >& /dev/null'

# brew
## anyenv
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"
## go
export GOPATH="$HOME/.go"
export PATH="$PATH:$GOPATH/bin"
## homeshick --HEAD
export HOMESHICK_DIR=/usr/local/opt/homeshick
source "${HOMESHICK_DIR}/homeshick.sh"
## direnv
eval "$(direnv hook zsh)"
## fzf
export FZF_DEFAULT_OPTS="--reverse --inline-info"
### install key bindings and fuzzy completion
### $ /usr/local/opt/fzf/install
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
## ghq + fzf (alt + r)
function ghq-fzf() {
  local selected_dir=$(ghq list | fzf --query="$LBUFFER")

  if [ -n "$selected_dir" ]; then
    BUFFER="cd $(ghq root)/${selected_dir}"
    zle accept-line
  fi

  zle reset-prompt
}
zle -N ghq-fzf
bindkey "^[r" ghq-fzf

bindkey -r '^T'
bindkey '\et' fzf-file-widget
## source-highlight
export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'
export LESS='-R'
