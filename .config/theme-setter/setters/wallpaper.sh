#!/bin/bash
parser="$HOME/.config/theme-setter/scripts/parser.sh"
wallpapers="$HOME/Dropbox/Pictures/Wallpapers"
local_path="$HOME/.local/share"

theme=$($parser --theme)
mode=$($parser --mode)
tone=$($parser --tone)
current_wallpaper=$($parser --bg)
current_epoch=$($parser --epoch)

wallpaper_ls="ls $wallpapers/$theme"

if [ "$current_wallpaper" != "" ]; then
    wallpaper_ls="$wallpaper_ls -I $current_wallpaper"
fi

new_wallpaper=$($wallpaper_ls | sort -R | tail -1)
new_epoch=$(date +%s)

$parser --set-bg "$new_wallpaper"
$parser --set-epoch "$new_epoch"

rm "$local_path/$current_epoch.jpg"

if [ $mode == "dark" ]; then
    fill="50%" 
else
    fill="25%"
fi

magick "$wallpapers/$theme/$new_wallpaper" \
    -fill "#$($parser --palette backgroundAlt)" \
    -colorize $fill \
    -fill "#$($parser --palette orange)" \
    -colorize 10% \
    "$local_path/$new_epoch.jpg"

plasma-apply-wallpaperimage "$local_path/$new_epoch.jpg"
