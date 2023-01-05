dest_dir="$HOME/.config/alacritty/"
dest_file="colors.yml"

[[ -d "$dest_dir" ]] || mkdir -pv "$dest_dir"

output="$(cat << THEME
colors:
  primary:
    background: '#$(jq -r ".\"$1\".palette.\"$2\".background" "$3")'
    foreground: '#$(jq -r ".\"$1\".palette.\"$2\".foreground" "$3")'
  normal:
    black: '#$(jq -r ".\"$1\".palette.\"$2\".background" "$3")'
    red: '#$(jq -r ".\"$1\".palette.\"$2\".red" "$3")'
    green: '#$(jq -r ".\"$1\".palette.\"$2\".green" "$3")'
    yellow: '#$(jq -r ".\"$1\".palette.\"$2\".yellow" "$3")'
    magenta: '#$(jq -r ".\"$1\".palette.\"$2\".magenta" "$3")'
    cyan: '#$(jq -r ".\"$1\".palette.\"$2\".cyan" "$3")'
    white: '#$(jq -r ".\"$1\".palette.\"$2\".white" "$3")'
  bright:
    black: '#$(jq -r ".\"$1\".palette.\"$2\".gray" "$3")'
    red: '#$(jq -r ".\"$1\".palette.\"$2\".red" "$3")'
    green: '#$(jq -r ".\"$1\".palette.\"$2\".green" "$3")'
    yellow: '#$(jq -r ".\"$1\".palette.\"$2\".yellow" "$3")'
    magenta: '#$(jq -r ".\"$1\".palette.\"$2\".magenta" "$3")'
    cyan: '#$(jq -r ".\"$1\".palette.\"$2\".cyan" "$3")'
    white: '#$(jq -r ".\"$1\".palette.\"$2\".white" "$3")'
THEME
)"

printf '%s' "$output" > "${dest_dir}${dest_file}"