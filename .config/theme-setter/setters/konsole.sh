#!/bin/bash
palette=("${@}")

dest_dir="$HOME/.local/share/konsole/"
dest_file="Breeze.colorscheme"

output="$(cat << THEME
[Background]
Color=#${palette[0]}

[BackgroundFaint]
Color=#${palette[0]}

[BackgroundIntense]
Color=#${palette[0]}

[Color0]
Color=#${palette[3]}

[Color0Faint]
Color=#${palette[3]}

[Color0Intense]
Color=#${palette[3]}

[Color1]
Color=#${palette[4]}

[Color1Faint]
Color=#${palette[4]}

[Color1Intense]
Color=#${palette[4]}

[Color2]
Color=#${palette[5]}

[Color2Faint]
Color=#${palette[5]}

[Color2Intense]
Color=#${palette[5]}

[Color3]
Color=#${palette[6]}

[Color3Faint]
Color=#${palette[6]}

[Color3Intense]
Color=#${palette[6]}

[Color4]
Color=#${palette[7]}

[Color4Faint]
Color=#${palette[7]}

[Color4Intense]
Color=#${palette[7]}

[Color5]
Color=#${palette[8]}

[Color5Faint]
Color=#${palette[8]}

[Color5Intense]
Color=#${palette[8]}

[Color6]
Color=#${palette[9]}

[Color6Faint]
Color=#${palette[9]}

[Color6Intense]
Color=#${palette[9]}

[Color7]
Color=#${palette[2]}

[Color7Faint]
Color=#${palette[2]}

[Color7Intense]
Color=#${palette[2]}

[Foreground]
Color=#${palette[2]}

[ForegroundFaint]
Color=#${palette[2]}

[ForegroundIntense]
Color=#${palette[2]}

[General]
Description=Breeze
Opacity=1
Wallpaper=
THEME
)"

printf '%s' "$output" > "${dest_dir}${dest_file}"
