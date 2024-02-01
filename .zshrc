# NOTE: Anything with a full path is marked with #* MACHINE-SPECIFIC comment
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
#* MACHINE SPECIFIC
export ZSH="/Users/jamesfirth/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

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
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git docker docker-compose)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


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
  git checkout "origin/$1";
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

# Misc tools/commands
alias zedit="vim ~/.zshrc"
alias zource="source ~/.zshrc"
alias sshi="cat ~/.ssh/config"
alias scanet="sudo nmap -sP 192.168.0.100-254"
alias showfp="ssh-keygen -lf" # Get the fingerprint of an ssh key. Usage: showfp ~/.ssh/mykey.pub
alias showart="ssh-keygen -lvf" # Get randomart of ssh key. Usage: showart ~/.ssh/mykey.pub

# git
 # Git Checkout Remote
alias gcr='git checkout -t'
  # Git update (via rebase)
alias ggup="git pull --rebase origin $(git_current_branch)"
  # Git Checkout origin
alias gcoo="gpeek"
  # Pull all repos under this folder
alias gupall='find . -type d -name .git -exec sh -c "cd \"{}\"/../ && pwd && git pull" \;'

# Flags - I'm lazy so this makes things easier
alias cless="less -R"
alias lessn="less --LINE-NUMBERS"
alias clessn="less --LINE-NUMBERS --RAW-CONTROl-CHARS"
alias kssh="kitty +kitten ssh"

# Macros
alias clear3="clear; clear; clear;"
  # Remove node modules
alias nmrm='rm -rf ./node_modules;'
# Would be nice to have it be recursive
#alias nmrm='find . -type d -name \"node_modules\" -exec rm -rf {} \;'
  # fuzzy find with preview
alias fzfp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"

# Node
alias jscripts="jq .scripts package.json"

# Movement alias
alias work="cd ~/projects/work"
alias docs="cd ~/projects/work/project_docs"

# LINUX-SPECIFIC
# System Update alias
# alias bynars="sudo apt update && notify-send 'Permission required' && sudo apt upgrade && notify-send 'Permission required' && sudo apt auto-remove && echo 'UPGRADE COMPLETE!' && notify-send 'UPGRADE COMPLETE';"
## END ALIASES ##


autoload -Uz compinit
compinit
# Completion for kitty
[ "$TERM" = "xterm-kitty" ] && kitty + complete setup zsh | source /dev/stdin
EDITOR='vim'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship
source "$HOME/.zsh_rc_movement"

# SETUP ANDROID VARS
export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk-11.jdk/Contents/Home
export PATH=${JAVA_HOME}:$PATH
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# PYTHON
PYTHON_BIN_PATH="$(python3 -m site --user-base)/bin"
# Manually adding the path not sure why the above line wasn't working...
PATH="$PATH:$PYTHON_BIN_PATH:/Users/jamesfirth/.local/bin"

# User binaries
export PATH="$PATH:$HOME/bin"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/usr/local/sbin:$PATH"

#* MACHINE SPECIFIC
# pnpm
export PNPM_HOME="/Users/jamesfirth/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# PYTHON - pyenv setup
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
