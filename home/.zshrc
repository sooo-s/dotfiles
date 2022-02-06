# zsh
export LANG="ja_JP.UTF-8"
## brew prefix path
BREW_PREFIX=$(brew --prefix)
## brew comp
if type brew &>/dev/null; then
  FPATH=${BREW_PREFIX}/share/zsh/site-functions:$FPATH
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

setopt interactivecomments
## color
autoload -Uz colors
colors

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
  SPACESHIP_DIR_LOCK_SYMBOL="🔒"
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
export EDITOR=nvim
## sooo-s/homebin
export PATH="$PATH:$HOME/bin"

## alias
alias ls='ls -G'
alias tmux='tmux -u'
alias ql='qlmanage -p "$@" >& /dev/null'
alias -g @p='| tee /dev/tty |' # print and pipe
alias -g @g='| grep'
alias -g @l='| less'

# brew
## rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
## plenv
if which plenv > /dev/null; then eval "$(plenv init - zsh)"; fi
## nodenv
if which nodenv > /dev/null; then eval "$(nodenv init -)"; fi
## pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
## go
export GOPATH="$HOME/.go"
export PATH="$PATH:$GOPATH/bin"
## homeshick --HEAD
export HOMESHICK_DIR=${BREW_PREFIX}/opt/homeshick
source "${HOMESHICK_DIR}/homeshick.sh"
## direnv
if which direnv > /dev/null; then eval "$(direnv hook zsh)"; fi
## fzf
export FZF_DEFAULT_OPTS="--reverse --inline-info"
### install key bindings and fuzzy completion
### $ $(brew --prefix)/opt/fzf/install
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
### fzf + git
#### fbr - checkout git branch (including remote branches)
fbr() {
  local branches branch
  branches=$(git branch --all | \grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}
## source-highlight
export LESSOPEN='| ${BREW_PREFIX}/bin/src-hilite-lesspipe.sh %s'
export LESS='-R'
