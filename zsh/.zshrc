autoload -Uz compinit promptinit
compinit
promptinit
PROMPT='%~ » '
HISTSIZE=20
SAVEHIST=20
HISTFILE=~/.zhistory
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^H' backward-kill-word
export EDITOR=nvim

# Aliases
alias ls='ls --color'
alias neofetch='fastfetch'
