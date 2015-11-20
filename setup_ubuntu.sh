# Ubuntu setup steps


#CONFIG FILES and whatnot
# .i3/config
# ~/.fonts
# ~/.gtkrc-2.0
# ~/.config/gtk-3.0/settings.ini

#Add this ppa:
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_15.10/ /' >> /etc/apt/sources.list.d/arc-theme.list";
sudo apt-get clean; #Needed to re-build the cache. otherwise the opensuse stuff freaks out.
sudo apt-get update;

# Install apps
sudo apt-get install -y git git-gui gitk vim terminator zsh i3 tmux lxappearance arc-theme rofi compton i3blocks thunar gnome-icon-theme-full;
# Thunar and gnome-icon-theme-full are only requied if nautilus isn't working.

#Install icon theme
#firefox https://github.com/NitruxSA/flattr-icons/release
s
# move Flattr and Flattr Dark to /usr/share/icons/

#install ohmyzsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Download Font-awesome
#firefox https://github.com/FortAwesome/Font-Awesome/releases

# Download system font (Yosemite San Francisco) and copy to ~/.fonts/
#firefox https://github.com/FortAwesome/Font-Awesome/releases

# Install Firefox theme
#firefox https://github.com/horst3180/arc-firefox-theme/releases

# Copy files to their appropriate locations.
tar -xzf icon_themes.tar.gz -C /usr/share/icons/
mv .fonts/ ~/
mv .i3/ ~/
mv .ssh/ ~/
mv .tmux.conf/ ~/
mv .vimrc ~/
mv .xlock/ ~/
