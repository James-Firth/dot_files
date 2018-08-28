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
# Programming stuff 
sudo apt install -y git git-gui gitk vim terminator zsh tmux;
# i3 stuff - i3 launcher  
sudo apt install -y i3 lxappearance rofi compton i3blocks i3lock gnome-icon-theme-full nitrogen arandr;
sudo apt install -y scrot imagemagick;
sudo apt install -y jq; # required by the workspace_renamer script
sudo apt install -y keepass2; #don't like X but need it for a few things.
sudo apt install thunar gnome-icon-theme-full; #only necessary if nautilus isn't working. Or install nemo
sudo apt install -y pinta; # Good image editor

# Typora for markdown editing easily
# shutter for screenshots
# cava and vis for commandline visualisers

# kitematic for docker, insomnica for REST testing

#install ohmyzsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Download Font-awesome
#firefox https://github.com/FortAwesome/Font-Awesome/releases

# Download system font (Yosemite San Francisco) and copy to ~/.fonts/
#firefox https://github.com/FortAwesome/Font-Awesome/releases


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

# Make symlinks to all the proper locations. This allows us to keep the repo up to date
ln -s "$(pwd)/.zshrc" "$HOME/" #link zshrc file
ln -s "$(pwd)/.i3" "$HOME/" #link i3 files
ln -s "$(pwd)/.tmux.conf" "$HOME/"
ln -s "$(pwd)/.vimrc" "$HOME/"
ln -s "$(pwd)/.xlock" "$HOME/"
ln -s "$(pwd)/.gtkrc-2.0" "$HOME/"
ln -s "$(pwd)/.config/gtk-3.0/settings.ini" "$HOME/.config/gtk-3.0/"
ln -s "$(pwd)/.config/dunst/dunstrc" "$HOME/.config/dunst/dunstrc"
ln -s "$(pwd)/scripts/*" "$HOME/bin/" # Link all my scripts to the bin folder

echo "Do not forget to install and setup the System San Francisco font"
echo "   * Got to the site and install it."
echo "   * Not using it? Update the values in:"
echo "     * .fonts folder."
echo "     * Update i3 config if necessary"
echo "     * Update the gtk files"
