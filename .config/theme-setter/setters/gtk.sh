#!/bin/bash

gsettings set org.gnome.desktop.interface font-name "Hack Nerd Font"
gsettings set org.gnome.desktop.interface gtk-theme "$1"
gsettings set org.gnome.desktop.interface icon-theme "$2"
# gsettings set org.gnome.desktop.interface cursor-theme "$3"
