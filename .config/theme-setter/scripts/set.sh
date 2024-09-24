#!/bin/bash
parser="$HOME/.config/theme-setter/scripts/parser.sh"
setters="$HOME/.config/theme-setter/setters"

if [ "$1" == "dark" ] || [ "$1" == "light" ]; then
    mode="$1"
else
    exit 1
fi

if [ "$2" == "soft" ] || [ "$2" == "hard" ]; then
    tone="$2"
else
    tone="medium"
fi

$parser --set $mode $tone

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
    $setters/plasma.sh ${palette[@]} $cursors &
    $setters/code.sh $mode $tone &
    $setters/discord.sh ${palette[@]} &
    $setters/kitty.sh ${palette[@]} &
    $setters/konsole.sh ${palette[@]} &
    $setters/nvim.sh $mode $tone &
    $setters/obsidian.sh ${palette[@]} &
    $setters/okular.sh ${palette[@]} &
    $setters/spicetify.sh ${palette[@]} &
    $setters/zathura.sh ${palette[@]} &
} &> /dev/null
