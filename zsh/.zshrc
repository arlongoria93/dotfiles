# scripts
export PATH=$PATH:"$HOME/.scripts"

# programs
export VISUAL="nvim"
export EDITOR="nvim"
export BROWSER="brave"
export TERM="st-256color"
export ZSH="$HOME/.oh-my-zsh"
export GOPATH="$HOME/go"
export GOBIN="$HOME/go/bin"

# android
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# vim
export VIMCONFIG=~/.config/nvim
export VIMDATA=~/.local/share/nvim

# scraping
export GOOGLE_CHROME_BIN="/usr/bin/chromium"
export CHROMEDRIVER_PATH="/home/manikandan/.scripts/chromedriver"

# fzf
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS=''

# alias
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias p="sudo pacman"
alias ydl="youtube-dl"
alias zt="zathura"
alias dm="diana-mui"
alias ptt="prettier"

## docker
alias dc="docker container"

# zsh
ZSH_THEME="robbyrussell"
plugins=(git)
plugins=(vi-mode)

# edit command in default editor
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

source $ZSH/oh-my-zsh.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
