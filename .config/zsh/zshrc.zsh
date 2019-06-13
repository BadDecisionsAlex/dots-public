#############################
# Environment Variables
##########################

EDITOR="vim"
BROWSER="firefox"
READER="vim -R -c 'set filetype=zsh' -c 'nnoremap q :q<CR>' -"
DIFF_READER="vim -R -c 'set filetype=diff' -c 'nnoremap q :q<CR>' -"

MY_CONF_DIR="${HOME}/.config"
MY_ZSH_DIR="${MY_CONF_DIR}/zsh"

MY_ZSHRC="${MY_ZSH_DIR}/zshrc.zsh"
MY_VIMRC="${HOME}/.vimrc"


##############
# Prompt
###########
autoload -Uz colors && colors
autoload -Uz promptinit && promptinit
prompt lambda-pure


##############
# Aliases
###########

alias aliases="cat ${MY_ZSHRC}|awk '/^alias/ { split(\$2,a,\"=\"); print a[1] }'"

# Shortcuts/Various
# ------------------
alias shutdown="for ((i=0;i<14;i++)) { sleep 0.5; printf .; } && shutdown 0"
alias python="python3"

function dots() {
  git --git-dir=${HOME}/public/dots --work-tree=${HOME} $@
}

# Functions/Utils
alias s="sudo"
alias mx="chmod +x"
compdef _files mx
alias rm="rm -r"
alias rmf="rm -rf"
alias cp="cp -r"
alias back="cd -"
alias "cd.."="cd .."
alias "..."="cd ../.."
alias diskSummary="df"
# Colorize `ls`, and use "natural sort" to sort numbered files properly
alias ls="ls -v --color=auto"
alias ll="ls -l"
alias la="ls -a"
alias lal="ls -la"
alias lala="ls -la"
alias mkdir="nocorrect mkdir -p"
function mkc () { nocorrect mkdir -p ${1} && cd ${1}; }
alias wget="wget -c"
alias h="history"
alias ra="ranger"
alias suvim="sudo vim"
alias reader="${READER}"
alias seepath="echo ${PATH} | sed 's/:/\n/g'"
#alias irc="glirc2 fn"
#alias chat="glirc2 fn"
#function slack-term() {
#  if [[ $# -lt 1 ]]; then
#    read "workspace?Which workspace: (`jq -r '.workspaces | keys | @csv' $HOME/.slack-term | sed 's/"//g' | sed 's/,/\|/g'`) ? "
#  else
#    workspace=${1}
#  fi
#  command slack-term -workspace $workspace
#}
#function iperl() { rlwrap perl6 ${@} }

alias mks="mkScript"

# Git
alias g="git"
alias ga="git add"
alias gc="git commit -am"
alias gdv="git diff -w ${@} | ${DIFF_READER}"
alias gk="git checkout"
alias gl="git pull"
alias gp="git push"
alias gpa="gitPullAll"
alias gs="git status"
alias gta="gitTrackAll"
function gi () { echo "${@}" | sed 's:\s\+:\n:g' >> .gitignore }
compdef _files gi

# Directories
# -------------
alias cdz="cd ${MY_ZSH_DIR}"
alias cdc="cd ${MY_CONF_DIR}"
alias hme="cd ${HOME}"
alias srcd="cd ${HOME}/src"
alias cdt="cd ${HOME}/src/textbookit"
alias cdtb="cd ${HOME}/src/textbookit/Bookstore"

# Vim Configs
# ------------
alias vimconf="vim ${MY_VIMRC}"

# Zsh Configs
# ------------
alias zshconf="${EDITOR} ${MY_ZSHRC} && source ${MY_ZSHRC}"

# -----------------------------------------------------------------------------

#################
# ZSH Settings
###############

# Set colors used by ls
eval `dircolors -b`
export LS_COLORS="${LS_COLORS}tw=01;35:ow=01;35:"

# Options
setopt append_history
setopt auto_cd
setopt auto_param_slash
setopt complete_aliases
setopt correct_all
# Don't suggest hidden directories.
export CORRECT_IGNORE_FILE='.*'
setopt extended_glob
setopt no_match
setopt notify
setopt hash_list_all
setopt list_types
setopt share_history
setopt interactive_comments
setopt c_bases
setopt c_precedences
unsetopt beep
