# Work Machine-related

# Movement alias
alias work="cd ~/projects/work" # jump to work dir
alias docs="cd ~/projects/work/project_docs" # jump to project docs dir
alias dotfiles="cd ~/projects/personal/dot_files"
alias personal="cd ~/projects/personal/"

# Utilities
alias feslint="pnpm eslint . --ext .js,.jsx --format compact | grep \"Error\" | sed -e 's/ line //' -e 's/, col /:/' -e 's/, Error.*$//'"
