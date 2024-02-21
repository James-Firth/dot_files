####################################################################################
#    ___                           _           _                        __ _       
#   |_  |                         ( )         | |                      / _(_)      
#     | | __ _ _ __ ___   ___  ___|/   _______| |__     ___ ___  _ __ | |_ _  __ _ 
#     | |/ _` | '_ ` _ \ / _ \/ __|   |_  / __| '_ \   / __/ _ \| '_ \|  _| |/ _` |
# /\__/ / (_| | | | | | |  __/\__ \    / /\__ \ | | | | (_| (_) | | | | | | | (_| |
# \____/ \__,_|_| |_| |_|\___||___/   /___|___/_| |_|  \___\___/|_| |_|_| |_|\__, |
#                                                                             __/ |
#                                                                            |___/ 
####################################################################################
# NOTES ✍️ 
# - If you come from bash you might have to change your $PATH.
# - I have deleted all of the zsh commented out options I do not think I will 
#   ever use

# SET (AND MAYBE EXPORT) ENVIRONMENT VARIABLES
# These may be overridden in the per-machine settings
export ZSH=$HOME/.oh-my-zsh # Path to your oh-my-zsh installation.
export EDITOR='vim' # default editor

export PATH="/usr/local/sbin:/usr/local/bin:$HOME/bin:$PATH"

# My custom env vars
export JF_ZSH_CUSTOM=$HOME/.config/zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"


# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Should make the `plugins` variable available to ohmyzsh
source $JF_ZSH_CUSTOM/plugins.zsh

# actually run the oh-my-zsh script!
source $ZSH/oh-my-zsh.sh

## START FUNCTIONS ##
docker_stop_and_remove() {
  containers="${@: 1}"
  if [ "" = "$containers" ]; then
    echo "Missing parameters!";
    return 1
  fi

  echo "Stopping and removing docker containers..."
  for current in $(echo $containers); do
    echo -n "$(echo $current | cut -c-7)"
    docker stop "$current" && docker rm "$current"
  done
  echo "Stopped and removed all containers listed"
}

change_file_extensions_in_dir() {
  # usage: change_file_extensions_in_dir oldExt newExt
  # Changes all file extensions in a folder AND uses git mv
  #   if in a git repo!
  oldExtension="$1"
  newExtension="$2"
  if [ "" = "$oldExtension" ]; then
    echo "Missing parameters! Should be cfe OLD NEW";
    return 1
  fi
  if [ "" = "$newExtension" ]; then
    echo "Missing parameters! should be cfe OLD NW";
    return 1
  fi

  if [ "true" = $(git rev-parse --is-inside-work-tree) ]; then
    for f in *.$oldExtension; do
      git mv -- "$f" "${f%.$oldExtension}.$newExtension";
    done
    echo "Extensions changed properly with git";
  else
    for f in *.$oldExtension; do
      mv -- "$f" "${f%.$oldExtension}.$newExtension";
    done
    echo "Extensions changed.";
  fi
}

# ONLY required if OHMYZSH is not installed (not always!)
# We will check if the function is defined already then define if needed
if ! type 'git_current_branch' 2>/dev/null | grep -q 'function' ; then
  git_current_branch () {
    local ref
    ref=$(__git_prompt_git symbolic-ref --quiet HEAD 2> /dev/null) 
    local ret=$? 
    if [[ $ret != 0 ]]
    then
      [[ $ret == 128 ]] && return
      ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null)  || return
    fi
    echo ${ref#refs/heads/}
  }
fi


safe_sudo() {
 # Runs a single command as sudo then revokes access
 cmd="${@: 1}"
 if [ "" = "$cmd" ]; then
  echo "Missing parameters!";
  return 1
 fi

 sudo ${@: 1};
 sudo -k;
 echo "Sudo permissions removed from this terminal."
}


git_peek() {
  # I primarily use this function when doing PR reviews
  # I'll peek to grab the branch, but without worrying if the other user force-pushes
  git fetch;

  if [ "$1" = "" ]; then
    echo "You must provide a branch name";
    return 1; # return as an error code. Avoid exiting shell
  else
    git checkout "origin/$1";
  fi
}


git_update_peek() {
  # This ONLY works with ZSH due to the use of $vcs_info_msg_0_
  # This function simplifies re-peeking (see git_peek)
  # use it when you have a detached HEAD and want to look at a more recent commit
  
  # Grab the likely remote branch name. strip out any diffs (zsh adds ~3 if you'ree commits from tip)
  # the cut is used to remove the prefix I don't need
  local branch_name=$(echo $vcs_info_msg_0_ | sed 's/\~.*$//' | cut -c 9-)

  # This is to confirm we grabbed a real branch name and my sed/cut didn't mess up
  if git branch --all | grep -q "$branch_name"; then
    git fetch;
    git checkout $branch_name;
  else
    echo "BRANCH NOT FOUND"; 
    return 1; # return as an error code. Avoid exiting shell
  fi
}
## END FUNCTIONS ##

## START ALIASES ##
# Function call aliases - supercedes other categories to be clear what's a func
# See above section for info.
alias dsrm=docker_stop_and_remove
alias cfe=change_file_extensions_in_dir
alias gpeek=git_peek
alias gupeek=git_update_peek
alias ssudo=safe_sudo

# ZSH editing
alias zeditv="vim ~/.config/zshr" # Edit zshrc with vim
alias zedit="hx ~/.config/zsh/" # edit zshrc with helix (default for practice)
alias zource="source ~/.zshrc" # reload zshrc config

# Misc
alias halias="ag --nonumber '(?s)(^## START ALIASES ##\$.*^## END ALIASES ##\$)' ~/.zshrc ~/.config/zsh/ | sed '1d' | sed '\$d'" # help, list the aliases _I_ manually set not ohmyzsh
alias treeag='tree -a -I ".git|node_modules"' # Gives a nice tree view of a folder ignoring obvious files
alias showmotd='ssudo run-parts /etc/update-motd.d' # shows the motd that I wouldn't see when tmuxing immediately

# SSH 
alias showfp="ssh-keygen -lf" # Get the fingerprint of an ssh key. Usage: showfp ~/.ssh/mykey.pub
alias showart="ssh-keygen -lvf" # Get randomart of ssh key. Usage: showart ~/.ssh/mykey.pub
alias sshi="cat ~/.ssh/config" # dump sshi config to screen

# Docker
alias docc='docker compose'
alias docuc='docker compose pull && docker compose up -d && docker system prune --force'

# git
alias gcr='git checkout -t' # Git Checkout Remote
alias ggup="git pull --rebase origin $(git_current_branch)" # Git update (via rebase)
alias gcoo="gpeek" # Git Checkout origin
alias gupall='find . -type d -name .git -exec sh -c "cd \"{}\"/../ && pwd && git pull" \;' # Pull all repos under this folder
alias lgit="lazygit"

# less: Commonly used flags so I don't have to remember them
alias cless="less -R" # Less with Colours
alias lessn="less --LINE-NUMBERS" # Less with Line Numbers
alias clessn="less --LINE-NUMBERS --RAW-CONTROl-CHARS" # less with Lines AND colours

# Macros
alias clear3="clear; clear; clear;" # clear 3 timex
alias fzfp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'" # fuzzy find with preview
alias nmrm='rm -rf ./node_modules;' # Remove node modules
# Would be nice to have it be recursive
#alias nmrm='find . -type d -name \"node_modules\" -exec rm -rf {} \;'

# Node
alias jscripts="jq .scripts package.json" # What are my scripts in this node project?

# LINUX-SPECIFIC
# System Update alias
# alias bynars="sudo apt update && notify-send 'Permission required' && sudo apt upgrade && notify-send 'Permission required' && sudo apt auto-remove && echo 'UPGRADE COMPLETE!' && notify-send 'UPGRADE COMPLETE';"
## END ALIASES ##


# OTHER INTIALIZATION
# Is this needed?
autoload -Uz compinit; compinit

# Set up FZF (assumed to be installed. Luckily this also checks)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
