#!/bin/bash
parser="$HOME/.config/theme-setter/scripts/parser.sh"
setters="$HOME/.config/theme-setter/setters"

if [ "$1" == "gruvbox" ] || [ "$1" == "catppuccin" ]; then
    theme="$1"
else
    exit 1
fi

if [ "$2" == "light" ] || [ "$2" == "dark" ]; then
    mode="$2"
else
    mode="dark"
fi

if [ "$3" == "soft" ] || [ "$3" == "hard" ]; then
    tone="$3"
else
    tone="medium"
fi

$parser --set $theme $mode $tone

icons=$($parser --icons)
cursors=$($parser --cursors)
palette=(
    "$($parser --palette background)"
    "$($parser --palette backgroundAlt)"
    "$($parser --palette foreground)"
    "$($parser --palette gray)"
    "$($parser --palette red)"
    "$($parser --palette green)"
    "$($parser --palette yellow)"
    "$($parser --palette blue)"
    "$($parser --palette magenta)"
    "$($parser --palette cyan)"
    "$($parser --palette orange)"
)

{
    $setters/wallpaper.sh &
    $setters/plasma.sh ${palette[@]} $icons $cursors &
    $setters/code.sh $theme $mode $tone &
    $setters/kitty.sh ${palette[@]} &
    $setters/konsole.sh ${palette[@]} &
    $setters/nvim.sh $theme $mode $tone &
    $setters/obsidian.sh ${palette[@]} &
    $setters/okular.sh ${palette[@]} &
    $setters/spicetify.sh ${palette[@]} &
} &> /dev/null
