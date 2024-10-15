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

# gpg stuff
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null
gpgconf --launch gpg-agent

# PATH
PATH=$PATH:$HOME/scripts
