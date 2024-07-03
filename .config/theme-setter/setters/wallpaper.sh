#!/bin/bash

if [ "$3" == "" ]; then
    bg_opt="/"
else
    bg_opt="/$3/"
fi

wallpapers="$HOME/Dropbox/Pictures/Wallpapers/$1$bg_opt$2"
wallpaper=$(ls $wallpapers | sort -R | tail -1)

plasma-apply-wallpaperimage "$wallpapers/$wallpaper"
