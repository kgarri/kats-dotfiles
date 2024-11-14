[[ $- != *i* ]] && return
#set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME"  
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"
# Load starship theme
# line 1: `starship` binary as command, from github release
# line 2: starship setup at clone(create init.zsh, completion)
# line 3: pull behavior same as clone, source init.zsh
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found

autoload -U compinit &&  compinit

zinit cdreplay -q

#History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory 
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

#Completion styling
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

#keybindings
bindkey '^f' autosuggest-accept

alias rider='/opt/JetBrains\ Rider-*/bin/rider.sh'
alias zip ="/usr/bin/zip"
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias idea='/opt/idea-IU-*/bin/idea'
alias obs=echo"flatpak run com.obsproject.Studio"
alias discord=echo"'flatpak run com.discordapp.Discord"
alias steam=echo"'flatpak run com.valvesoftware.Steam"
. "$HOME/.cargo/env"

#Shell Integrations
eval "$(fzf --zsh)"
cat ~/.cache/wal/sequences
source ~/.cache/wal/colors-tty.sh
# Created by `pipx` on 2024-10-10 19:06:01
export PATH="$PATH:/home/kat/.local/bin"
export ISAAC_ROS_WS=/home/kat/workspace/isaac_ros-dev/
source /opt/ros/iron/setup.bash
