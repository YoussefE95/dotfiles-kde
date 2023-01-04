xsettingsd_dir="$HOME/.config/xsettingsd/"
xsettingsd_file="xsettingsd.conf"

xsettingsd_output="$(cat << THEME
Net/ThemeName "$(jq -r ".gtk.\"$1\".theme" "$2")"
Gtk/CursorThemeName "$(jq -r ".gtk.\"$1\".cursor" "$2")"
Net/IconThemeName "$(jq -r ".gtk.\"$1\".icons" "$2")"
THEME
)"

printf '%s' "$xsettingsd_output" > "${xsettingsd_dir}${xsettingsd_file}"

xsettingsd &