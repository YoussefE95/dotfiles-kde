dest_dir="$HOME/.local/share/color-schemes/"
dest_file="DynamicTheme.colors"

[[ -d "$dest_dir" ]] || mkdir -pv "$dest_dir"

output="$(cat << THEME
[ColorEffects:Disabled]
Color=#$(jq -r ".colors.\"$1\".gray" "$2")
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
BackgroundAlternate=#$(jq -r ".colors.\"$1\".yellow" "$2")
BackgroundNormal=#$(jq -r ".colors.\"$1\".gray" "$2")
DecorationFocus=#$(jq -r ".colors.\"$1\".yellow" "$2")
DecorationHover=#$(jq -r ".colors.\"$1\".gray" "$2")
ForegroundActive=#$(jq -r ".colors.\"$1\".foreground" "$2")
ForegroundInactive=#$(jq -r ".colors.\"$1\".black" "$2")
ForegroundLink=#$(jq -r ".colors.\"$1\".blue" "$2")
ForegroundNegative=#$(jq -r ".colors.\"$1\".red" "$2")
ForegroundNeutral=#$(jq -r ".colors.\"$1\".yellow" "$2")
ForegroundNormal=#$(jq -r ".colors.\"$1\".foreground" "$2")
ForegroundPositive=#$(jq -r ".colors.\"$1\".green" "$2")
ForegroundVisited=#$(jq -r ".colors.\"$1\".magenta" "$2")

[Colors:Complementary]
BackgroundAlternate=#$(jq -r ".colors.\"$1\".background" "$2")
BackgroundNormal=#$(jq -r ".colors.\"$1\".background" "$2")
DecorationFocus=#$(jq -r ".colors.\"$1\".yellow" "$2")
DecorationHover=#$(jq -r ".colors.\"$1\".gray" "$2")
ForegroundActive=#$(jq -r ".colors.\"$1\".foreground" "$2")
ForegroundInactive=#$(jq -r ".colors.\"$1\".gray" "$2")
ForegroundLink=#$(jq -r ".colors.\"$1\".blue" "$2")
ForegroundNegative=#$(jq -r ".colors.\"$1\".red" "$2")
ForegroundNeutral=#$(jq -r ".colors.\"$1\".yellow" "$2")
ForegroundNormal=#$(jq -r ".colors.\"$1\".foreground" "$2")
ForegroundPositive=#$(jq -r ".colors.\"$1\".green" "$2")
ForegroundVisited=#$(jq -r ".colors.\"$1\".magenta" "$2")

[Colors:Header]
BackgroundAlternate=#$(jq -r ".colors.\"$1\".background" "$2")
BackgroundNormal=#$(jq -r ".colors.\"$1\".background" "$2")
DecorationFocus=#$(jq -r ".colors.\"$1\".yellow" "$2")
DecorationHover=#$(jq -r ".colors.\"$1\".gray" "$2")
ForegroundActive=#$(jq -r ".colors.\"$1\".foreground" "$2")
ForegroundInactive=#$(jq -r ".colors.\"$1\".gray" "$2")
ForegroundLink=#$(jq -r ".colors.\"$1\".blue" "$2")
ForegroundNegative=#$(jq -r ".colors.\"$1\".red" "$2")
ForegroundNeutral=#$(jq -r ".colors.\"$1\".yellow" "$2")
ForegroundNormal=#$(jq -r ".colors.\"$1\".foreground" "$2")
ForegroundPositive=#$(jq -r ".colors.\"$1\".green" "$2")
ForegroundVisited=#$(jq -r ".colors.\"$1\".magenta" "$2")

[Colors:Selection]
BackgroundAlternate=#$(jq -r ".colors.\"$1\".orange" "$2")
BackgroundNormal=#$(jq -r ".colors.\"$1\".orange" "$2")
DecorationFocus=#$(jq -r ".colors.\"$1\".yellow" "$2")
DecorationHover=#$(jq -r ".colors.\"$1\".gray" "$2")
ForegroundLink=#$(jq -r ".colors.\"$1\".blue" "$2")
ForegroundInactive=#$(jq -r ".colors.\"$1\".background" "$2")
ForegroundActive=#$(jq -r ".colors.\"$1\".foreground" "$2")
ForegroundLink=#$(jq -r ".colors.\"$1\".blue" "$2")
ForegroundNegative=#$(jq -r ".colors.\"$1\".red" "$2")
ForegroundNeutral=#$(jq -r ".colors.\"$1\".yellow" "$2")
ForegroundNormal=#$(jq -r ".colors.\"$1\".background" "$2")
ForegroundPositive=#$(jq -r ".colors.\"$1\".green" "$2")
ForegroundVisited=#$(jq -r ".colors.\"$1\".magenta" "$2")

[Colors:Tooltip]
BackgroundAlternate=#$(jq -r ".colors.\"$1\".background" "$2")
BackgroundNormal=#$(jq -r ".colors.\"$1\".background" "$2")
DecorationFocus=#$(jq -r ".colors.\"$1\".yellow" "$2")
DecorationHover=#$(jq -r ".colors.\"$1\".gray" "$2")
ForegroundActive=#$(jq -r ".colors.\"$1\".foreground" "$2")
ForegroundInactive=#$(jq -r ".colors.\"$1\".gray" "$2")
ForegroundLink=#$(jq -r ".colors.\"$1\".blue" "$2")
ForegroundNegative=#$(jq -r ".colors.\"$1\".red" "$2")
ForegroundNeutral=#$(jq -r ".colors.\"$1\".yellow" "$2")
ForegroundNormal=#$(jq -r ".colors.\"$1\".foreground" "$2")
ForegroundPositive=#$(jq -r ".colors.\"$1\".green" "$2")
ForegroundVisited=#$(jq -r ".colors.\"$1\".magenta" "$2")

[Colors:View]
BackgroundAlternate=#$(jq -r ".colors.\"$1\".background" "$2")
BackgroundNormal=#$(jq -r ".colors.\"$1\".background" "$2")
DecorationFocus=#$(jq -r ".colors.\"$1\".yellow" "$2")
DecorationHover=#$(jq -r ".colors.\"$1\".gray" "$2")
ForegroundActive=#$(jq -r ".colors.\"$1\".foreground" "$2")
ForegroundInactive=#$(jq -r ".colors.\"$1\".gray" "$2")
ForegroundLink=#$(jq -r ".colors.\"$1\".blue" "$2")
ForegroundNegative=#$(jq -r ".colors.\"$1\".red" "$2")
ForegroundNeutral=#$(jq -r ".colors.\"$1\".yellow" "$2")
ForegroundNormal=#$(jq -r ".colors.\"$1\".foreground" "$2")
ForegroundPositive=#$(jq -r ".colors.\"$1\".green" "$2")
ForegroundVisited=#$(jq -r ".colors.\"$1\".magenta" "$2")

[Colors:Window]
BackgroundAlternate=#$(jq -r ".colors.\"$1\".background" "$2")
BackgroundNormal=#$(jq -r ".colors.\"$1\".background" "$2")
DecorationFocus=#$(jq -r ".colors.\"$1\".yellow" "$2")
DecorationHover=#$(jq -r ".colors.\"$1\".gray" "$2")
ForegroundActive=#$(jq -r ".colors.\"$1\".foreground" "$2")
ForegroundInactive=#$(jq -r ".colors.\"$1\".gray" "$2")
ForegroundLink=#$(jq -r ".colors.\"$1\".blue" "$2")
ForegroundNegative=#$(jq -r ".colors.\"$1\".red" "$2")
ForegroundNeutral=#$(jq -r ".colors.\"$1\".yellow" "$2")
ForegroundNormal=#$(jq -r ".colors.\"$1\".foreground" "$2")
ForegroundPositive=#$(jq -r ".colors.\"$1\".green" "$2")
ForegroundVisited=#$(jq -r ".colors.\"$1\".magenta" "$2")

[General]
ColorScheme=DynamicTheme
Name=Dynamic Theme
accentActiveTitlebar=false
shadeSortColumn=true

[KDE]
contrast=4

[WM]
activeBackground=#$(jq -r ".colors.\"$1\".background" "$2")
activeBlend=#$(jq -r ".colors.\"$1\".foreground" "$2")
activeForeground=#$(jq -r ".colors.\"$1\".foreground" "$2")
inactiveBackground=#$(jq -r ".colors.\"$1\".background" "$2")
inactiveBlend=#$(jq -r ".colors.\"$1\".gray" "$2")
inactiveForeground=#$(jq -r ".colors.\"$1\".gray" "$2")
THEME
)"

printf '%s' "$output" > "${dest_dir}${dest_file}"

# Cursor
kwriteconfig5 --file ~/.config/kcminputrc --group Mouse --key cursorTheme $(jq -r ".gtk.\"$1\".cursor" "$2")

# Wallpaper
dbus-send --session --dest=org.kde.plasmashell --type=method_call /PlasmaShell org.kde.PlasmaShell.evaluateScript "string:
var Desktops = desktops();                                                                                                                       
for (i=0;i<Desktops.length;i++) {
        d = Desktops[i];
        d.wallpaperPlugin = 'org.kde.image';
        d.currentConfigGroup = Array('Wallpaper',
                                    'org.kde.image',
                                    'General');
        d.writeConfig('Image', '$3');
}"

plasma-theme -c "${dest_dir}${dest_file}"