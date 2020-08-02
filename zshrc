export ZSH=$HOME/.oh-my-zsh

ZSH_THEME=""

autoload -U promptinit; promptinit
prompt pure

export EDITOR='nvim'

plugins=(
  aws
  git
  tmux
  z
  fzf
)

source $ZSH/oh-my-zsh.sh

alias vim='nvim'
alias ls='gls --color -h --group-directories-first'

