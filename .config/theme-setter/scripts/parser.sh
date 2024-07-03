#!/bin/bash
current="$HOME/.config/theme-setter/info/current.json"
themes="$HOME/.config/theme-setter/info/themes.json"

is_valid_theme() {
    valid=0

    for theme in $(jq 'keys' $themes | sed 's/\[\|\]\|\,\|\"\|//g'); do
        if [ "$1" == "$theme" ]; then
            valid=1
        fi
    done

    echo $valid
}

set() {
    tmp=$(mktemp)
    jq --arg a "$1" '.theme = $a' $current > "$tmp" && mv "$tmp" $current
    jq --arg a "$2" '.mode = $a' $current > "$tmp" && mv "$tmp" $current
    jq --arg a "$3" '.bg_opt = $a' $current > "$tmp" && mv "$tmp" $current
}

set_bg() {
    tmp=$(mktemp)
    jq --arg a "$1" '.bg = $a' $current > "$tmp" && mv "$tmp" $current
}

get_theme() {
    echo "$(jq ".theme" "$current" | sed 's/\"//g')" 
}

get_mode() {
    echo "$(jq ".mode" "$current" | sed 's/\"//g')"
}

get_bg_opt() {
    echo "$(jq ".bg_opt" "$current" | sed 's/\"//g')"
}

get_bg() {
    echo "$(jq ".bg" "$current" | sed 's/\"//g')"
}

get_nvim() {
    jq ".$(get_theme).nvim" "$themes" | sed 's/\"//g'
}

get_cursors() {
    jq ".$(get_theme).cursors.$(get_mode)" "$themes" | sed 's/\"//g'
}

get_icons() {
    jq ".$(get_theme).icons.$(get_mode)" "$themes" | sed 's/\"//g'
}

get_palette() {
    jq ".$(get_theme).palette.$(get_mode).$1" "$themes" | sed 's/\"//g' 
}

if [ "$1" == "--is-valid" ]; then
    is_valid_theme $2
elif [ "$1" == "--set" ]; then
    set $2 $3 $4
elif [ "$1" == "--set-bg" ]; then
    set_bg $2
elif [ "$1" == "--theme" ]; then
    get_theme
elif [ "$1" == "--mode" ]; then
    get_mode
elif [ "$1" == "--bg_opt" ]; then
    get_bg_opt
elif [ "$1" == "--bg" ]; then
    get_bg
elif [ "$1" == "--nvim" ]; then
    get_nvim
elif [ "$1" == "--cursors" ]; then
    get_cursors
elif [ "$1" == "--icons" ]; then
    get_icons
elif [ "$1" == "--palette" ]; then
    get_palette $2
fi
