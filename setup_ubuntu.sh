# Ubuntu setup steps


#CONFIG FILES and whatnot
# .i3/config
# ~/.fonts
# ~/.gtkrc-2.0
# ~/.config/gtk-3.0/settings.ini

#Add this ppa:


## Remove these lines after you've confirmed the version/path below ##
echo "Exiting early to make sure you checked the arc-theme repo version/path"
exit 1;
## End of block to remove **

#Update key and add repo to list
# This is one of the two  URLs to check.
wget http://download.opensuse.org/repositories/home:Horst3180/xUbuntu_16.04/Release.key;
sudo apt-key add - < Release.key;

# This is the other string to confirm
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_16.04/ /' > /etc/apt/sources.list.d/arc-theme.list";
sudo apt-get clean; #Needed to re-build the cache. otherwise the opensuse stuff freaks out.
sudo apt-get update;

# Install apps
sudo apt-get install -y git git-gui gitk vim terminator zsh i3 tmux lxappearance arc-theme rofi compton i3blocks;
sudo apt-get install -y scrot imagemagick i3lock;
sudo apt-get install -y jq; # required by the workspace_renamer script
sudo apt-get install -y keepass2 keepassx; #don't like X but need it for a few things.
sudo apt-get install -y thunar gnome-icon-theme-full; #only necessary if nautilus isn't working
sudo apt-get install -y nitrogen; #for configuring wallpapers
sudo apt-get install -y arandr;
#Install icon theme
#firefox https://github.com/NitruxSA/flattr-icons/releases
# move Flattr and Flattr Dark to /usr/share/icons/

#install ohmyzsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Download Font-awesome
#firefox https://github.com/FortAwesome/Font-Awesome/releases

# Download system font (Yosemite San Francisco) and copy to ~/.fonts/
#firefox https://github.com/FortAwesome/Font-Awesome/releases

# Install Firefox theme
#firefox https://github.com/horst3180/arc-firefox-theme/releases

# Setup folder structure I like
mkdir -p "$HOME/.fonts"
mkdir -p "$HOME/.config/gtk-3.0"
mkdir -p "$HOME/.config/dunst"
mkdir -p "$HOME/bin"
mkdir -p "$HOME/passwords"
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

echo "Do not forget to install and setup the System San Francisco font"
echo "   * Got to the site and install it."
echo "   * Not using it? Update the values in:"
echo "     * .fonts folder."
echo "     * Update i3 config if necessary"
echo "     * Update the gtk files"
echo "Using luv (continued flattr) icons"
#sudo tar -xzf icon_themes.tar.gz -C /usr/share/icons/
#mv .fonts/ ~/
