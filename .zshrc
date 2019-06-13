# Created by newuser for 5.4.2
zmodload zsh/zprof

# Enter part of a command, then use Up/Down keys to see completions
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# Map URxvt codes to expected functionality.
typeset -g -A key
bindkey '^?'    backward-delete-char
bindkey '^[[7~' beginning-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[3~' delete-char
bindkey '^[[8~' end-of-line
bindkey '^[[6~' down-line-or-history
bindkey '^[[A'  up-line-or-search
bindkey '^[[D'  backward-char
bindkey '^[[B'  down-line-or-search
bindkey '^[[C'  forward-char 
bindkey '^[[2~' overwrite-mode

# Autoload anything in XDG's Zsh `fns` subfolder.
MY_ZSH_DIR="${HOME}/.config/zsh"

if [[ -d ${MY_ZSH_DIR}/fns ]]; then
  fpath+=(${MY_ZSH_DIR}/fns)
  autoload -Uz ${MY_ZSH_DIR}/fns/*
fi

[[ -d ${MY_ZSH_DIR}/plugins ]] && source ${MY_ZSH_DIR}/plugins/*.zsh

# Finally Load `zshrc`
[[ -f ${MY_ZSH_DIR}/zshrc.zsh ]] && source ${MY_ZSH_DIR}/zshrc.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
