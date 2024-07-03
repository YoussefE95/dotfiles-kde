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

if [ "$3" == "ghibli" ]; then
    bg_opt="/ghibli/"
else
    bg_opt="/"
fi

$parser --set $theme $mode $(echo "$bg_opt" | sed 's/\///g')

nvim=$($parser --nvim)
cursors=$($parser --cursors)
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
    $setters/wallpaper.sh
    $setters/plasma.sh "${palette[@]}" "$cursors" "$icons" &
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
