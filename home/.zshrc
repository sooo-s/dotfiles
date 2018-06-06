# zsh
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
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, as:theme, \
	hook-load: SPACESHIP_PROMPT_ADD_NEWLINE=false \
	SPACESHIP_PROMPT_SEPARATE_LINE=false \
	SPACESHIP_GIT_SYMBOL="🌿 "
zplug "jimeh/zsh-peco-history"

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
## less color
export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'
export LESS='-R'

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
