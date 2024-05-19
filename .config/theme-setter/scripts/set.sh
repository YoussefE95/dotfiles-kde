#!/bin/bash
parser="$HOME/.config/theme-setter/scripts/parser.sh"
setters="$HOME/.config/theme-setter/setters"

if [ $($parser --is-valid $1) -eq 1 ]; then
    theme="$1"
else
    echo "$1 is not a supported theme"
    exit 1
fi

if [ "$2" != "light" -a "$2" != "dark" ]; then
    mode="medium"
else
    mode="$2"
fi

$parser --set $theme $mode

wallpapers="$HOME/Dropbox/Pictures/Wallpapers/$theme/$mode"
wallpaper=$(ls $wallpapers | sort -R | tail -1)

nvim=$($parser --nvim)
icons=$($parser --icons)
palette=(
    "$($parser --palette background)"
    "$($parser --palette foreground)"
    "$($parser --palette black)"
    "$($parser --palette white)"
    "$($parser --palette red)"
    "$($parser --palette green)"
    "$($parser --palette yellow)"
    "$($parser --palette blue)"
    "$($parser --palette magenta)"
    "$($parser --palette cyan)"
    "$($parser --palette orange)"
    "$($parser --palette gray)"
    "$($parser --palette backgroundAlt)"
)

{
    $setters/plasma.sh "${palette[@]}" "$icons" "$wallpapers/$wallpaper" &
    $setters/discord.sh "${palette[@]}" &
    $setters/gtk.sh "$theme-$mode" "$icons" &
    $setters/kitty.sh "${palette[@]}" &
    $setters/konsole.sh "${palette[@]}" &
    $setters/nvim.sh "$nvim" "$mode" &
    $setters/obsidian.sh "${palette[@]}" &
    $setters/okular.sh "${palette[@]}" &
    $setters/spicetify.sh "${palette[@]}" &
    $setters/zathura.sh "${palette[@]}" &
} &> /dev/null
