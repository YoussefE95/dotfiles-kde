#!/bin/bash
parser="$HOME/.config/theme-setter/scripts/parser.sh"
wallpapers="$HOME/Dropbox/Pictures/Wallpapers"

theme=$($parser --theme)
mode=$($parser --mode)
tone=$($parser --tone)
current_wallpaper=$($parser --bg)

wallpaper_ls="ls $wallpapers/$theme"

if [ "$current_wallpaper" != "" ]; then
    wallpaper_ls="$wallpaper_ls -I $current_wallpaper"
fi

new_wallpaper=$($wallpaper_ls | sort -R | tail -1)
$parser --set-bg $new_wallpaper

if [ $mode == "dark" ]; then
    fill="25%" 
else
    fill="10%"
fi

magick "$wallpapers/$theme/$new_wallpaper" \
    -fill "#$($parser --palette backgroundAlt)" \
    -colorize $fill \
    -fill "#$($parser --palette orange)" \
    -colorize 10% \
    "$wallpapers/$new_wallpaper"

plasma-apply-wallpaperimage "$wallpapers/$new_wallpaper"
cp "$wallpapers/$new_wallpaper" "$wallpapers/current_desktop.jpg"
sleep 1
plasma-apply-wallpaperimage "$wallpapers/current_desktop.jpg"
rm "$wallpapers/$new_wallpaper"
