#!/bin/bash

base_dir="$HOME/.config/theme-setter"
templates="$base_dir/templates"
theme_info="$base_dir/themes.json"

if [[ "$1" == "everforest" || "$1" == "gruvbox" || "$1" == "rose-pine" ]]; then
    theme="$1"
else
    echo "$1 is not a supported theme"
    exit 1
fi

if [[ "$2" != "light" && "$2" != "dark" ]]; then
    mode="medium"
else
    mode="$2"
fi

wallpapers="$HOME/Dropbox/Pictures/Wallpapers/$theme/$mode"
wallpaper="$wallpapers/$(ls $wallpapers | sort -R | tail -1)"

icon=$(jq ".\"$theme\".icons.\"$mode\"" "$theme_info" | sed 's/\"//g')
cursor=$(jq ".\"$theme\".cursors.\"$mode\"" "$theme_info" | sed 's/\"//g')
gtk=$(jq ".\"$theme\".gtk.\"$mode\"" "$theme_info" | sed 's/\"//g')
code=$(jq ".\"$theme\".code.\"$mode\"" "$theme_info" | sed 's/\"//g')
palette=(
    "$(jq ".\"$theme\".palette.\"$mode\".background" "$theme_info" | sed 's/\"//g')"
    "$(jq ".\"$theme\".palette.\"$mode\".foreground" "$theme_info" | sed 's/\"//g')"
    "$(jq ".\"$theme\".palette.\"$mode\".black" "$theme_info" | sed 's/\"//g')"
    "$(jq ".\"$theme\".palette.\"$mode\".white" "$theme_info" | sed 's/\"//g')"
    "$(jq ".\"$theme\".palette.\"$mode\".red" "$theme_info" | sed 's/\"//g')"
    "$(jq ".\"$theme\".palette.\"$mode\".green" "$theme_info" | sed 's/\"//g')"
    "$(jq ".\"$theme\".palette.\"$mode\".yellow" "$theme_info" | sed 's/\"//g')"
    "$(jq ".\"$theme\".palette.\"$mode\".blue" "$theme_info" | sed 's/\"//g')"
    "$(jq ".\"$theme\".palette.\"$mode\".magenta" "$theme_info" | sed 's/\"//g')"
    "$(jq ".\"$theme\".palette.\"$mode\".cyan" "$theme_info" | sed 's/\"//g')"
    "$(jq ".\"$theme\".palette.\"$mode\".orange" "$theme_info" | sed 's/\"//g')"
    "$(jq ".\"$theme\".palette.\"$mode\".gray" "$theme_info" | sed 's/\"//g')"
    "$(jq ".\"$theme\".palette.\"$mode\".backgroundAlt" "$theme_info" | sed 's/\"//g')"
)

{
    # $templates/gnome-shell.sh "${palette[@]}" "$gtk"
    # $templates/gtk-2.sh "${palette[@]}" "$gtk"
    # $templates/gtk-3.sh "${palette[@]}" "$gtk"
    # $templates/gtk-4.sh "${palette[@]}" "$gtk"

    $templates/code.sh "$code" "$mode" &
    $templates/discord.sh "${palette[@]}" &
    $templates/gtk.sh "$icon" "$cursor" "$gtk" &
    $templates/kitty.sh "${palette[@]}" &
    $templates/obsidian.sh "${palette[@]}" &
    $templates/okular.sh "${palette[@]}" &
    $templates/plasma.sh "${palette[@]}" "$icon" "$wallpaper" &
    $templates/spicetify.sh "${palette[@]}" &
} &> /dev/null
