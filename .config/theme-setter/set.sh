templates="$HOME/.config/theme-setter/templates"
info="$HOME/.config/theme-setter/info.json"
tmp_info="$HOME/.config/theme-setter/temp-info.json"

if [[ "$1" == "catppuccin" || "$1" == "gruvbox" || "$1" == "rose-pine" ]]; then
    theme="$1"
else
    echo "$1 is not a supported theme"
    exit 1
fi

if [[ "$2" != "light" && "$2" != "dark" ]]; then
    mode="normal"
else
    mode="$2"
fi

theme_wallpapers="$HOME/Dropbox/Pictures/Wallpapers/$theme/$mode"
random_wallpaper="$theme_wallpapers/$(ls $theme_wallpapers | sort -R | tail -1)"

jq --arg t "$theme" '.current.theme = $t' $info > "$tmp_info" && mv "$tmp_info" $info
jq --arg m "$mode" '.current.mode = $m' $info > "$tmp_info" && mv "$tmp_info" $info
jq --arg w "$random_wallpaper" '.current.wallpaper = $w' $info > "$tmp_info" && mv "$tmp_info" $info

$templates/plasma.sh "$theme" "$mode" "$info"
$templates/gtk.sh "$theme" "$mode" "$info"
$templates/alacritty.sh "$theme" "$mode" "$info"
$templates/vs_code.sh "$theme" "$mode" "$info"
$templates/notion.sh "$theme" "$mode" "$info"
$templates/discord.sh "$theme" "$mode" "$info"
$templates/spotify.sh "$theme" "$mode" "$info"

clear