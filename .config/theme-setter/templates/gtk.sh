xsettingsd_dir="$HOME/.config/xsettingsd/"
xsettingsd_file="xsettingsd.conf"

xsettingsd_output="$(cat << THEME
Net/ThemeName "$(jq -r ".\"$1\".gtk.\"$2\"" "$3")"
Net/IconThemeName "$(jq -r ".\"$1\".icons" "$3")"
THEME
)"

printf '%s' "$xsettingsd_output" > "${xsettingsd_dir}${xsettingsd_file}"

xsettingsd &


# Gtk/CursorThemeName "$(jq -r ".gtk.\"$1\".cursor" "$2")" 