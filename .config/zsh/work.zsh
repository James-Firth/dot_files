# Work Machine-related

make_new_note() {
  notename="${@: 1}"
  if [ "" = "$notename" ]; then
    echo "Missing parameters!";
    return 1
  fi

  hx "/Users/jamesfirth/projects/work/notes/james-firth/$notename.md"
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

# Movement alias
alias work="cd ~/projects/work" # jump to work dir
alias docs="cd ~/projects/work/project_docs" # jump to project docs dir
alias dotfiles="cd ~/projects/personal/dot_files"
alias personal="cd ~/projects/personal/"

# Utilities
alias feslint="pnpm eslint . --ext .js,.jsx --format compact | grep \"Error\" | sed -e 's/ line //' -e 's/, col /:/' -e 's/, Error.*$//'"

## Notes
alias note=make_new_note
alias daily=make_daily_note

# tmux stuff
alias pgit="tmux popup -d '#{pane_current_path}' -E -w 90% -h 90% lazygit"

# Use Ctrl-t to pipe fd results into fzf
export FZF_DEFAULT_COMMAND='fd --type file --color=always --follow --hidden --exclude .git --exclude node_modules'
export FZF_DEFAULT_OPTS="--ansi"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
