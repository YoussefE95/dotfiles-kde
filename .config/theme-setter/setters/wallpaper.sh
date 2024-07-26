#!/bin/bash
parser="$HOME/.config/theme-setter/scripts/parser.sh"
wallpapers="$HOME/Dropbox/Pictures/Wallpapers"

mode=$($parser --mode)
tone=$($parser --tone)

current_wallpaper=$($parser --bg)
current_wallpaper_base=$(basename $current_wallpaper .jpg)

if [ "$current_wallpaper" != "" ]; then
    new_wallpaper=$(ls $wallpapers -I $current_wallpaper | sort -R | tail -1)
    rm "$wallpapers/[DIM]$current_wallpaper_base.jpg"
else
    new_wallpaper=$(ls $wallpapers | sort -R | tail -1)
fi

$parser --set-bg $new_wallpaper
new_wallpaper_base=$(basename "$new_wallpaper" .jpg)

if [ $mode == "dark" ]; then
    if [ $tone == "hard" ]; then
        fill="45%"
    else
        fill="25%"
    fi
else
    fill="10%"
fi

magick "$wallpapers/$new_wallpaper" \
    -fill "#$($parser --palette backgroundAlt)" \
    -colorize $fill \
    -fill "#$($parser --palette orange)" \
    -colorize 10% \
    "$wallpapers/[DIM]$new_wallpaper_base.jpg"

plasma-apply-wallpaperimage "$wallpapers/[DIM]$new_wallpaper_base.jpg"
