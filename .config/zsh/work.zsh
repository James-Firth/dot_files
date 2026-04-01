# Work Machine-related

make_new_note() {
  notename="${@: 1}"
  today_name=$(date +'%Y-%m-%d %H%M')
  if [ "" = "$notename" ]; then
    echo "Note needs a name! Usage: note [NAME]";
    return 1
  fi

  hx "/Users/jamesfirth/projects/work/notes/james-firth/$today_name $notename.md"
}

make_daily_note() {
  #v1! v2 should read the format from my .obsidian/daily-notes.json file
  notes_path="/Users/jamesfirth/projects/work/notes"
  daily_folder=$(jq .folder "$notes_path/.obsidian/daily-notes.json" --raw-output)
  template_file=$(jq .template "$notes_path/.obsidian/daily-notes.json" --raw-output)."md"
  today_name=$(date +'%Y-%m-%d %A')

  if [[ ! -e "$notes_path/$daily_folder/$today_name.md" ]]; then
    echo "Creating Daily Note at: $notes_path/$daily_folder/$today_name.md"
    cp "$notes_path/$template_file" "$notes_path/$daily_folder/$today_name.md"
  fi
   hx "$notes_path/$daily_folder/$today_name.md"
}


# TODO: Can I move this to a git alias or not really?
# https://stackoverflow.com/a/3322412
# REMINDER: Use tab or shift-tab for selecting items in fzf multi
# original from https://github.com/WickyNilliams/dotfiles/blob/c4154dd9b698044bc8d28b93f813d6a38138c8d7/.gitconfig#L41
# Enhanced with a confirm
# Found via https://news.ycombinator.com/item?id=47089509
# This finds all branches not on the remote
git_cleanup_local_v_remote() {
  branches=$(git branch -vv | ag ': gone]' | awk '{print $1}' | fzf --multi --sync --bind start:select-all)
  if [ -n "$branches" ]; then
    read "confirm? Type 'delete' to confirm: "
    if [ "$confirm" = "delete" ]; then
      echo "$branches" | xargs git branch -D
      git remote prune origin
    else
      echo "Aborted."
    fi
  fi
}

github_webm_viewer() {
  mpv <(curl "${@: 1}")
}

# Movement alias
alias work="cd ~/projects/work" # jump to work dir
alias docs="cd ~/projects/work/project_docs" # jump to project docs dir
alias dotfiles="cd ~/projects/personal/dot_files"
alias personal="cd ~/projects/personal/"

# Utilities
alias feslint="pnpm eslint . --ext .js,.jsx --format compact | grep \"Error\" | sed -e 's/ line //' -e 's/, col /:/' -e 's/, Error.*$//'"
alias myip='ifconfig | awk "/inet /&&!/127.0.0.1/{print $2;exit}"'
alias gitvid=github_webm_viewer
# Git stuff
alias cleanup=git_cleanup_local_v_remote

## Notes
alias note=make_new_note
alias daily=make_daily_note

# tmux stuff
alias pgit="tmux popup -d '#{pane_current_path}' -E -w 90% -h 90% lazygit"

alias get_idf='. /Users/jamesfirth/esp/esp-idf/export.sh'

# Use Ctrl-t to pipe fd results into fzf
export FZF_DEFAULT_COMMAND='fd --type file --color=always --follow --hidden --exclude .git --exclude node_modules'
export FZF_DEFAULT_OPTS="--ansi"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
