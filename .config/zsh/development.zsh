# Development stuff
# TODO: Clean up and split up!


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# SETUP ANDROID VARS
export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk-11.jdk/Contents/Home
export PATH=${JAVA_HOME}:$PATH
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# NODE
#* MACHINE SPECIFIC
# pnpm start
export PNPM_HOME="/Users/jamesfirth/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# PYTHON
PYTHON_BIN_PATH="$(python3 -m site --user-base)/bin"
# Manually adding the path not sure why the above line wasn't working...
PATH="$PATH:$PYTHON_BIN_PATH:/Users/jamesfirth/.local/bin"
# PYTHON - pyenv setup
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
