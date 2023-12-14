#!/bin/bash

cd

echo "Downloading fonts"
wget https://github.com/bradleyhodges/SFWindows/archive/refs/heads/main.zip -O fonts.zip

echo "Unzipping and applying fonts"
unzip fonts.zip -d fonts

mkdir ~/.fonts
mv ~/fonts/SFWindows-main/**/*.otf ~/.fonts

gsettings set org.gnome.desktop.interface font-name 'SF Pro Display 10'
gsettings set org.gnome.desktop.interface monospace-font-name 'SF Mono 10'
gsettings set org.gnome.desktop.interface document-font-name 'SF Pro Text 10'
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'SF Pro Display 10'

echo "Installing git"
sudo pacman -Syu git

echo "Downloading WhiteSur GTK theme"
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git --depth=1

echo "Installing theme"
./WhiteSur-gtk-theme/install.sh

echo "Installing gdm theme"
sudo ./WhiteSur-gtk-theme/tweaks.sh -g

echo "Installing Firefox theme"
./WhiteSur-gtk-theme/tweaks.sh -f

cd
echo "Downloading WhiteSur icon pack"
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git

echo "Installing icon pack"
./WhiteSur-icon-theme/install.sh

echo "Installing gnome browser connector"

~/extensions.sh

gsettings set org.gnome.shell.extensions.user-theme name 'WhiteSur-Dark'
gsettings set org.gnome.desktop.interface gtk-theme 'WhiteSur-Dark'
gsettings set org.gnome.desktop.interface icon-theme 'WhiteSur-dark'

git clone https://github.com/vinceliuice/WhiteSur-wallpapers.git

WhiteSur-wallpapers/install-wallpapers.sh

gsettings org.gnome.desktop.background picture-uri ~/.local/share/backgrounds/Ventura-dark.jpg

sudo pacman -Syu zsh
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

reboot

