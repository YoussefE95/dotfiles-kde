dest_dir="$HOME/.local/share/color-schemes/"
dest_file="DynamicTheme.colors"

[[ -d "$dest_dir" ]] || mkdir -pv "$dest_dir"

output="$(cat << THEME
[ColorEffects:Disabled]
Color=#$(jq -r ".\"$1\".palette.\"$2\".gray" "$3")
ColorAmount=0.15000000000000002
ColorEffect=1
ColorAmount=0.42500000000000004
ColorEffect=2
ContrastAmount=0.1
ContrastEffect=1
IntensityAmount=-1
IntensityEffect=2

[ColorEffects:Inactive]
ChangeSelectionColor=true
Color=112,111,110
ColorAmount=0.025
ColorEffect=2
ContrastAmount=0.1
ContrastEffect=2
Enable=false
IntensityAmount=0
IntensityEffect=0

[Colors:Button]
BackgroundAlternate=#$(jq -r ".\"$1\".palette.\"$2\".yellow" "$3")
BackgroundNormal=#$(jq -r ".\"$1\".palette.\"$2\".gray" "$3")
DecorationFocus=#$(jq -r ".\"$1\".palette.\"$2\".yellow" "$3")
DecorationHover=#$(jq -r ".\"$1\".palette.\"$2\".gray" "$3")
ForegroundActive=#$(jq -r ".\"$1\".palette.\"$2\".foreground" "$3")
ForegroundInactive=#$(jq -r ".\"$1\".palette.\"$2\".black" "$3")
ForegroundLink=#$(jq -r ".\"$1\".palette.\"$2\".blue" "$3")
ForegroundNegative=#$(jq -r ".\"$1\".palette.\"$2\".red" "$3")
ForegroundNeutral=#$(jq -r ".\"$1\".palette.\"$2\".yellow" "$3")
ForegroundNormal=#$(jq -r ".\"$1\".palette.\"$2\".foreground" "$3")
ForegroundPositive=#$(jq -r ".\"$1\".palette.\"$2\".green" "$3")
ForegroundVisited=#$(jq -r ".\"$1\".palette.\"$2\".magenta" "$3")

[Colors:Complementary]
BackgroundAlternate=#$(jq -r ".\"$1\".palette.\"$2\".background" "$3")
BackgroundNormal=#$(jq -r ".\"$1\".palette.\"$2\".background" "$3")
DecorationFocus=#$(jq -r ".\"$1\".palette.\"$2\".yellow" "$3")
DecorationHover=#$(jq -r ".\"$1\".palette.\"$2\".gray" "$3")
ForegroundActive=#$(jq -r ".\"$1\".palette.\"$2\".foreground" "$3")
ForegroundInactive=#$(jq -r ".\"$1\".palette.\"$2\".gray" "$3")
ForegroundLink=#$(jq -r ".\"$1\".palette.\"$2\".blue" "$3")
ForegroundNegative=#$(jq -r ".\"$1\".palette.\"$2\".red" "$3")
ForegroundNeutral=#$(jq -r ".\"$1\".palette.\"$2\".yellow" "$3")
ForegroundNormal=#$(jq -r ".\"$1\".palette.\"$2\".foreground" "$3")
ForegroundPositive=#$(jq -r ".\"$1\".palette.\"$2\".green" "$3")
ForegroundVisited=#$(jq -r ".\"$1\".palette.\"$2\".magenta" "$3")

[Colors:Header]
BackgroundAlternate=#$(jq -r ".\"$1\".palette.\"$2\".background" "$3")
BackgroundNormal=#$(jq -r ".\"$1\".palette.\"$2\".background" "$3")
DecorationFocus=#$(jq -r ".\"$1\".palette.\"$2\".yellow" "$3")
DecorationHover=#$(jq -r ".\"$1\".palette.\"$2\".gray" "$3")
ForegroundActive=#$(jq -r ".\"$1\".palette.\"$2\".foreground" "$3")
ForegroundInactive=#$(jq -r ".\"$1\".palette.\"$2\".gray" "$3")
ForegroundLink=#$(jq -r ".\"$1\".palette.\"$2\".blue" "$3")
ForegroundNegative=#$(jq -r ".\"$1\".palette.\"$2\".red" "$3")
ForegroundNeutral=#$(jq -r ".\"$1\".palette.\"$2\".yellow" "$3")
ForegroundNormal=#$(jq -r ".\"$1\".palette.\"$2\".foreground" "$3")
ForegroundPositive=#$(jq -r ".\"$1\".palette.\"$2\".green" "$3")
ForegroundVisited=#$(jq -r ".\"$1\".palette.\"$2\".magenta" "$3")

[Colors:Selection]
BackgroundAlternate=#$(jq -r ".\"$1\".palette.\"$2\".orange" "$3")
BackgroundNormal=#$(jq -r ".\"$1\".palette.\"$2\".orange" "$3")
DecorationFocus=#$(jq -r ".\"$1\".palette.\"$2\".yellow" "$3")
DecorationHover=#$(jq -r ".\"$1\".palette.\"$2\".gray" "$3")
ForegroundLink=#$(jq -r ".\"$1\".palette.\"$2\".blue" "$3")
ForegroundInactive=#$(jq -r ".\"$1\".palette.\"$2\".background" "$3")
ForegroundActive=#$(jq -r ".\"$1\".palette.\"$2\".foreground" "$3")
ForegroundLink=#$(jq -r ".\"$1\".palette.\"$2\".blue" "$3")
ForegroundNegative=#$(jq -r ".\"$1\".palette.\"$2\".red" "$3")
ForegroundNeutral=#$(jq -r ".\"$1\".palette.\"$2\".yellow" "$3")
ForegroundNormal=#$(jq -r ".\"$1\".palette.\"$2\".background" "$3")
ForegroundPositive=#$(jq -r ".\"$1\".palette.\"$2\".green" "$3")
ForegroundVisited=#$(jq -r ".\"$1\".palette.\"$2\".magenta" "$3")

[Colors:Tooltip]
BackgroundAlternate=#$(jq -r ".\"$1\".palette.\"$2\".background" "$3")
BackgroundNormal=#$(jq -r ".\"$1\".palette.\"$2\".background" "$3")
DecorationFocus=#$(jq -r ".\"$1\".palette.\"$2\".yellow" "$3")
DecorationHover=#$(jq -r ".\"$1\".palette.\"$2\".gray" "$3")
ForegroundActive=#$(jq -r ".\"$1\".palette.\"$2\".foreground" "$3")
ForegroundInactive=#$(jq -r ".\"$1\".palette.\"$2\".gray" "$3")
ForegroundLink=#$(jq -r ".\"$1\".palette.\"$2\".blue" "$3")
ForegroundNegative=#$(jq -r ".\"$1\".palette.\"$2\".red" "$3")
ForegroundNeutral=#$(jq -r ".\"$1\".palette.\"$2\".yellow" "$3")
ForegroundNormal=#$(jq -r ".\"$1\".palette.\"$2\".foreground" "$3")
ForegroundPositive=#$(jq -r ".\"$1\".palette.\"$2\".green" "$3")
ForegroundVisited=#$(jq -r ".\"$1\".palette.\"$2\".magenta" "$3")

[Colors:View]
BackgroundAlternate=#$(jq -r ".\"$1\".palette.\"$2\".background" "$3")
BackgroundNormal=#$(jq -r ".\"$1\".palette.\"$2\".background" "$3")
DecorationFocus=#$(jq -r ".\"$1\".palette.\"$2\".yellow" "$3")
DecorationHover=#$(jq -r ".\"$1\".palette.\"$2\".gray" "$3")
ForegroundActive=#$(jq -r ".\"$1\".palette.\"$2\".foreground" "$3")
ForegroundInactive=#$(jq -r ".\"$1\".palette.\"$2\".gray" "$3")
ForegroundLink=#$(jq -r ".\"$1\".palette.\"$2\".blue" "$3")
ForegroundNegative=#$(jq -r ".\"$1\".palette.\"$2\".red" "$3")
ForegroundNeutral=#$(jq -r ".\"$1\".palette.\"$2\".yellow" "$3")
ForegroundNormal=#$(jq -r ".\"$1\".palette.\"$2\".foreground" "$3")
ForegroundPositive=#$(jq -r ".\"$1\".palette.\"$2\".green" "$3")
ForegroundVisited=#$(jq -r ".\"$1\".palette.\"$2\".magenta" "$3")

[Colors:Window]
BackgroundAlternate=#$(jq -r ".\"$1\".palette.\"$2\".background" "$3")
BackgroundNormal=#$(jq -r ".\"$1\".palette.\"$2\".background" "$3")
DecorationFocus=#$(jq -r ".\"$1\".palette.\"$2\".yellow" "$3")
DecorationHover=#$(jq -r ".\"$1\".palette.\"$2\".gray" "$3")
ForegroundActive=#$(jq -r ".\"$1\".palette.\"$2\".foreground" "$3")
ForegroundInactive=#$(jq -r ".\"$1\".palette.\"$2\".gray" "$3")
ForegroundLink=#$(jq -r ".\"$1\".palette.\"$2\".blue" "$3")
ForegroundNegative=#$(jq -r ".\"$1\".palette.\"$2\".red" "$3")
ForegroundNeutral=#$(jq -r ".\"$1\".palette.\"$2\".yellow" "$3")
ForegroundNormal=#$(jq -r ".\"$1\".palette.\"$2\".foreground" "$3")
ForegroundPositive=#$(jq -r ".\"$1\".palette.\"$2\".green" "$3")
ForegroundVisited=#$(jq -r ".\"$1\".palette.\"$2\".magenta" "$3")

[General]
ColorScheme=DynamicTheme
Name=Dynamic Theme
accentActiveTitlebar=false
shadeSortColumn=true

[KDE]
contrast=4

[WM]
activeBackground=#$(jq -r ".\"$1\".palette.\"$2\".background" "$3")
activeBlend=#$(jq -r ".\"$1\".palette.\"$2\".foreground" "$3")
activeForeground=#$(jq -r ".\"$1\".palette.\"$2\".foreground" "$3")
inactiveBackground=#$(jq -r ".\"$1\".palette.\"$2\".background" "$3")
inactiveBlend=#$(jq -r ".\"$1\".palette.\"$2\".gray" "$3")
inactiveForeground=#$(jq -r ".\"$1\".palette.\"$2\".gray" "$3")
THEME
)"

printf '%s' "$output" > "${dest_dir}${dest_file}"

# Latte Dock
killall latte-dock
/usr/lib/plasma-changeicons $(jq -r ".\"$1\".icons" "$3")
latte-dock &

# Wallpaper
dbus-send --session --dest=org.kde.plasmashell --type=method_call /PlasmaShell org.kde.PlasmaShell.evaluateScript "string:
var Desktops = desktops();                                                                                                                       
for (i=0;i<Desktops.length;i++) {
        d = Desktops[i];
        d.wallpaperPlugin = 'org.kde.image';
        d.currentConfigGroup = Array('Wallpaper',
                                    'org.kde.image',
                                    'General');
        d.writeConfig('Image', '$(jq -r ".current.wallpaper" "$3")');
}"

plasma-theme -c "${dest_dir}${dest_file}"