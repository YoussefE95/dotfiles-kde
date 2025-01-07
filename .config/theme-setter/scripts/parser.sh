#!/bin/bash
current="$HOME/.config/theme-setter/info/current.json"
themes="$HOME/.config/theme-setter/info/themes.json"

set() {
    tmp=$(mktemp)
    jq ".$1 = \"$2\"" $current > $tmp && mv $tmp $current
}

query() {
    jq $1 $2 | sed 's/\"//g'
}

get() {
    query ".$1" $current
}

get_icons() {
    query ".$(get "theme").icons" $themes
}

get_cursors() {
    query ".$(get "theme").cursors.$(get "mode")" $themes
}

get_palette() {
    query ".$(get "theme").palette.$(get "mode").$(get "tone").$1" $themes
}

if [ "$1" == "--set" ]; then
    set "theme" $2
    set "mode" $3
    set "tone" $4
elif [ "$1" == "--set-bg" ]; then
    set "bg" $2
elif [ "$1" == "--set-epoch" ]; then
    set "epoch" $2
elif [ "$1" == "--theme" ]; then
    get "theme"
elif [ "$1" == "--mode" ]; then
    get "mode" 
elif [ "$1" == "--tone" ]; then
    get "tone"
elif [ "$1" == "--bg" ]; then
    get "bg"
elif [ "$1" == "--epoch" ]; then
    get "epoch"
elif [ "$1" == "--icons" ]; then
    get_icons
elif [ "$1" == "--cursors" ]; then
    get_cursors
elif [ "$1" == "--palette" ]; then
    get_palette $2
fi
