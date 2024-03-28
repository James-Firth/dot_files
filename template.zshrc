# TO USE THIS CONFIG
# you must have moved the zsh config folder to the proper director
# You must have moved this config to your home folder AND renamed it to .zshrc

# REQUIRED
source $HOME/.config/zsh/base.zsh #import the base that we customize on top of
# * NOTES
# inside $HOME/.config/zsh/
# * ONLY bash.zsh and plugins.zsh are ALWAYS imported
#       If $HOME/.config/zsh/overrides.sh is present it gets imported AFTER
#       variable declarations in bash.zsh
# * Remember to update below if you want any of the other files imported!

### EXAMPLES ###
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

# Machine-specific changes will likey automatically be applied below
# Or recommend to be applied
##### END OF TEMPLATE #####

# Place your customization here
