#!/bin/bash
parser="$HOME/.config/theme-setter/scripts/parser.sh"

theme=$($parser --theme)
mode=$($parser --mode)
bg_opt=$($parser --bg_opt)
current_wallpaper=$($parser --bg)

if [ "$bg_opt" == "" ]; then
    bg_opt="/"
else
    bg_opt="/$bg_opt/"
fi

wallpapers="$HOME/Dropbox/Pictures/Wallpapers/$theme$bg_opt$mode"
wallpaper=$(ls $wallpapers -I $current_wallpaper | sort -R | tail -1)

plasma-apply-wallpaperimage "$wallpapers/$wallpaper"

$parser --set-bg $wallpaper
