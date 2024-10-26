autoload -Uz compinit promptinit
compinit
promptinit
PROMPT='%~ » '
HISTSIZE=20
SAVEHIST=20
HISTFILE=~/.zhistory
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
export EDITOR=nvim
