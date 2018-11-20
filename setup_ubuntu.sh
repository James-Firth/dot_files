#!/bin/bash
ln -s "$(pwd)/.config/Code" "$HOME/.config/"
ln "$(pwd)/.config/terminator/config" "$HOME/.config/terminator/"
exit 0;

# Ubuntu setup steps


#CONFIG FILES and whatnot
# .i3/config
# ~/.fonts
# ~/.gtkrc-2.0
# ~/.config/gtk-3.0/settings.ini

#

# TODO Tidy up this section
# Update cache and install apps
sudo apt update;
sudo apt upgrade;

# Programming stuff 
sudo apt install -y git git-gui gitk vim zsh tmux curl;
sudo apt install terminator;
#TODO:
# install nvm
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
nvm install 6.10 #Change to whatever I need

# Install spaceship
npm install -g spaceship-prompt
#TODO: This second step probably needs to happen later
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

# i3 stuff - i3 launcher  
sudo apt install i3 rofi compton i3blocks i3lock nitrogen arandr;
sudo apt install imagemagick; # Useful for lots of processing
sudo apt install shutter; # for screenshots
sudo apt install neofetch; # for system info
sudo apt install -y jq keepass2; # required by the workspace_renamer script and keepass for passwords
sudo apt install -y pinta; # Good image editor
sudo snap install slack --classic; # install slack as a snap
# sudo apt install lxappearance # Might not need this now
# sudo apt install -y scrot imagemagick; # Not needed what with having other screenshot stuff
# sudo apt install thunar gnome-icon-theme-full; #only necessary if nautilus isn't working. Or install nemo

# Typora for markdown editing easily
# shutter for screenshots
# cava and vis for commandline visualisers

# kitematic for docker, insomnica for REST testing

#install ohmyzsh (curl isn't installed by default)
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# Download Font-awesome
#firefox https://github.com/FortAwesome/Font-Awesome/releases

# Download system font (Yosemite San Francisco) and copy to ~/.fonts/
#firefox https://github.com/supermarin/YosemiteSanFranciscoFont


# Setup folder structure I like
mkdir -p "$HOME/.fonts"
mkdir -p "$HOME/.config/gtk-3.0"
mkdir -p "$HOME/.config/dunst"
mkdir -p "$HOME/bin"
mkdir -p "$HOME/passwords"
mkdir -p "$HOME/projects/personal"
rm -r "$HOME/Templates" #remove templates makes tab-complete annoying

# Copy my personal programs
wget -O "$HOME/bin/makekey" https://raw.githubusercontent.com/James-Firth/useful-commandline-snippets/master/the_keymaker.sh


# TODO: Symlinks need to be set up afer a bunch of stuff. Maybe put in separate file?
# VSCode should launch once then copy symlinks
# ZSH needs to launch once
# Some files should be hardlinks instead I think

# Make symlinks to all the proper locations. This allows us to keep the repo up to date
echo "making symlinks"
ln "$(pwd)/.zshrc" "$HOME/.zshrc" #link zshrc file
ln -s "$(pwd)/.i3" "$HOME/" #link i3 files
ln -s "$(pwd)/.tmux.conf" "$HOME/"
ln -s "$(pwd)/.vimrc" "$HOME/"
ln -s "$(pwd)/.xlock" "$HOME/"
# ln "$(pwd)/.gtkrc-2.0" "$HOME/"

ln -s "$(pwd)/.config/Code" "$HOME/.config/"
ln "$(pwd)/.config/terminator/config" "$HOME/.config/terminator/"
ln "$(pwd)/.config/gtk-3.0/settings.ini" "$HOME/.config/gtk-3.0/"
ln -s "$(pwd)/.config/dunst/dunstrc" "$HOME/.config/dunst/dunstrc"
ln -s $(pwd)/scripts/* "$HOME/bin/" # Link all my scripts to the bin folder

ln "$"
echo "Do not forget to install and setup the System San Francisco font"
echo "   * Got to the site and install it."
echo "   * Not using it? Update the values in:"
echo "     * .fonts folder."
echo "     * Update i3 config if necessary"
echo "     * Update the gtk files"
echo "INSTALL SLACK"

#TODO: Separate script?
# Post launch install spaceship
# npm install -g spaceship-prompt

# TODO:
# Make tiny script that installs git, clones repo and runs install and then wipes the temp dir
#  this https://raw.githubusercontent.com/James-Firth/dot_files/master/setup_ubuntu.sh
