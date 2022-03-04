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
  kubectl
)

alias vim='nvim'
alias ls='gls --color -h --group-directories-first'

