dest_dir="$HOME/.config/spicetify/Themes/Default/"
dest_file="color.ini"

[[ -d "$dest_dir" ]] || mkdir -pv "$dest_dir"

output="$(cat << THEME
[Ocean]
text               = $(jq -r ".\"$1\".palette.\"$2\".foreground" "$3")
subtext            = $(jq -r ".\"$1\".palette.\"$2\".foreground" "$3")
main               = $(jq -r ".\"$1\".palette.\"$2\".background" "$3")
sidebar            = $(jq -r ".\"$1\".palette.\"$2\".background" "$3")
player             = $(jq -r ".\"$1\".palette.\"$2\".background" "$3")
card               = $(jq -r ".\"$1\".palette.\"$2\".background" "$3")
shadow             = $(jq -r ".\"$1\".palette.\"$2\".background" "$3")
selected-row       = $(jq -r ".\"$1\".palette.\"$2\".foreground" "$3")
button             = $(jq -r ".\"$1\".palette.\"$2\".red" "$3")
button-active      = $(jq -r ".\"$1\".palette.\"$2\".red" "$3")
button-disabled    = $(jq -r ".\"$1\".palette.\"$2\".black" "$3")
tab-active         = $(jq -r ".\"$1\".palette.\"$2\".black" "$3")
notification       = $(jq -r ".\"$1\".palette.\"$2\".cyan" "$3")
notification-error = $(jq -r ".\"$1\".palette.\"$2\".yellow" "$3")
misc               = $(jq -r ".\"$1\".palette.\"$2\".background" "$3")
THEME
)"

printf '%s' "$output" > "${dest_dir}${dest_file}"

spicetify update -q