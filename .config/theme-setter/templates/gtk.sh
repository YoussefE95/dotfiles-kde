xsettingsd_dir="$HOME/.config/xsettingsd/"
xsettingsd_file="xsettingsd.conf"

xsettingsd_output="$(cat << THEME
Net/IconThemeName "$1"
Net/ThemeName "$2"
THEME
)"

printf '%s' "$xsettingsd_output" > "${xsettingsd_dir}${xsettingsd_file}"

xsettingsd &