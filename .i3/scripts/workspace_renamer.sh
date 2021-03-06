# #!/bin/bash
# set -x
# set -e

# #Thanks to this guy: https://github.com/deiwin/i3-dotfiles/blob/docs/.i3/rename_workspace.sh

# workspace=`i3-msg -t get_workspaces | jq 'map(select(.focused == true))[0]'`
# workspace_num=$(echo $workspace | jq '.num')
# workspace_name=$(echo $workspace | jq '.name')
# echo $workspace_num
# i3-input -F "rename workspace to \"$num %s\"" -P "New name: $num "

# name=`i3-msg -t get_workspaces | jq 'map(select(.focused == true))[0].name'`
# # If empty name was set
# if [[ "$name" =~ ^\"[0-9]+:\"$ ]]
# then
#   # Remove trailing colon and whitespace
#   i3-msg "rename workspace to \"$num\""
# fi

#!/bin/bash
set -e

num=`i3-msg -t get_workspaces | jq 'map(select(.focused == true))[0].num'`
i3-input -F "rename workspace to \"$num:%s\"" -P 'New name: '

name=`i3-msg -t get_workspaces | jq 'map(select(.focused == true))[0].name'`
# If empty name was set
if [[ "$name" =~ ^\"[0-9]+:\"$ ]]
then
  # Remove trailing colon and whitespace
  i3-msg "rename workspace to \"$num\""
fi
