
ZSH_THEME=""

source $ZSH/oh-my-zsh.sh

autoload -U promptinit; promptinit
prompt pure

export EDITOR='nvim'

plugins=(
  aws
  git
  tmux
  z
)

alias ls='gls --color -h --group-directories-first'

