# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="spaceship"



# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git nvm aws emoji zsh-syntax-highlighting)

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

fpath=(~/.zsh/completions $fpath)
fpath=(~/.zsh/completion $fpath) #Added for docker
autoload -Uz compinit && compinit #added -z for Docker

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

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

export NODE_PATH=$NODEPATH:/usr/local/lib/node_modules

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#General Aliases for my linux setup.
alias gcr='git checkout -t'
alias sshi="cat ~/.ssh/config"
alias scanet="sudo nmap -sP 192.168.0.100-254"
alias cless="less -R"
alias clear3="clear; clear; clear;"
alias rmnm="find -type d -name \"node_modules\" -exec rm -rf {} \;"

# Movement aliases
alias projects="cd /home/james/projects"
alias work="cd /home/james/projects/work"
alias personal="cd /home/james/projects/personal"

# custom functions used for fancier aliases
safe_sudo() {
 cmd="${@: 1}"
 if [ "" = "$cmd" ]; then
  echo "Missing parameters!";
  return 1
 fi

 sudo ${@: 1};
 sudo -k;
 echo "Sudo permissions removed from this terminal."
}
alias ssudo=safe_sudo

aws_check(){
 cmd="${@: 1}"
 openssl pkcs8 -in "$cmd" -nocrypt -topk8 -outform DER | openssl sha1 -c
}
alias awsfingerprint=aws_check


node_add_and_delete_dependency() {
 cmd="${@: 1}"
 if [ "" = "$cmd" ]; then
  echo "Missing parameters!";
  return 1
 fi

 npm install --save ${@: 1} && rm -r node_modules
 echo "Added dependencies: ${@: 1} and removed node_modules folder"
}
alias nadd=node_add_and_delete_dependency


# Path, ENV, etc. setup. Mostly 3rd party.
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  fi
}
add-zsh-hook chpwd load-nvmrc

export NODE_ENV=development
export GOPATH="$HOME/projects/go"
export PATH="$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:./node_modules/.bin:/opt:/usr/local/go/bin:$GOPATH:$PATH"
# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /home/james/.nvm/versions/node/v6.10.3/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /home/james/.nvm/versions/node/v6.10.3/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /home/james/.nvm/versions/node/v6.10.3/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /home/james/.nvm/versions/node/v6.10.3/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

# added by travis gem
[ -f /home/james/.travis/travis.sh ] && source /home/james/.travis/travis.sh
