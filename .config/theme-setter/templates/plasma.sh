palette=("${@}")

dest_dir="$HOME/.local/share/color-schemes/"
dest_file="DynamicTheme.colors"

[[ -d "$dest_dir" ]] || mkdir -pv "$dest_dir"

output="$(cat << THEME
[ColorEffects:Disabled]
Color=#${palette[11]}
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
BackgroundAlternate=#${palette[6]}
BackgroundNormal=#${palette[11]}
DecorationFocus=#${palette[6]}
DecorationHover=#${palette[11]}
ForegroundActive=#${palette[1]}
ForegroundInactive=#${palette[2]}
ForegroundLink=#${palette[7]}
ForegroundNegative=#${palette[4]}
ForegroundNeutral=#${palette[6]}
ForegroundNormal=#${palette[1]}
ForegroundPositive=#${palette[5]}
ForegroundVisited=#${palette[8]}

[Colors:Complementary]
BackgroundAlternate=#${palette[0]}
BackgroundNormal=#${palette[0]}
DecorationFocus=#${palette[6]}
DecorationHover=#${palette[11]}
ForegroundActive=#${palette[1]}
ForegroundInactive=#${palette[11]}
ForegroundLink=#${palette[7]}
ForegroundNegative=#${palette[4]}
ForegroundNeutral=#${palette[6]}
ForegroundNormal=#${palette[1]}
ForegroundPositive=#${palette[5]}
ForegroundVisited=#${palette[8]}

[Colors:Header]
BackgroundAlternate=#${palette[0]}
BackgroundNormal=#${palette[0]}
DecorationFocus=#${palette[6]}
DecorationHover=#${palette[11]}
ForegroundActive=#${palette[1]}
ForegroundInactive=#${palette[11]}
ForegroundLink=#${palette[7]}
ForegroundNegative=#${palette[4]}
ForegroundNeutral=#${palette[6]}
ForegroundNormal=#${palette[1]}
ForegroundPositive=#${palette[5]}
ForegroundVisited=#${palette[8]}

[Colors:Selection]
BackgroundAlternate=#${palette[10]}
BackgroundNormal=#${palette[10]}
DecorationFocus=#${palette[6]}
DecorationHover=#${palette[11]}
ForegroundLink=#${palette[7]}
ForegroundInactive=#${palette[0]}
ForegroundActive=#${palette[1]}
ForegroundLink=#${palette[7]}
ForegroundNegative=#${palette[4]}
ForegroundNeutral=#${palette[6]}
ForegroundNormal=#${palette[0]}
ForegroundPositive=#${palette[5]}
ForegroundVisited=#${palette[8]}

[Colors:Tooltip]
BackgroundAlternate=#${palette[0]}
BackgroundNormal=#${palette[0]}
DecorationFocus=#${palette[6]}
DecorationHover=#${palette[11]}
ForegroundActive=#${palette[1]}
ForegroundInactive=#${palette[11]}
ForegroundLink=#${palette[7]}
ForegroundNegative=#${palette[4]}
ForegroundNeutral=#${palette[6]}
ForegroundNormal=#${palette[1]}
ForegroundPositive=#${palette[5]}
ForegroundVisited=#${palette[8]}

[Colors:View]
BackgroundAlternate=#${palette[0]}
BackgroundNormal=#${palette[0]}
DecorationFocus=#${palette[6]}
DecorationHover=#${palette[11]}
ForegroundActive=#${palette[1]}
ForegroundInactive=#${palette[11]}
ForegroundLink=#${palette[7]}
ForegroundNegative=#${palette[4]}
ForegroundNeutral=#${palette[6]}
ForegroundNormal=#${palette[1]}
ForegroundPositive=#${palette[5]}
ForegroundVisited=#${palette[8]}

[Colors:Window]
BackgroundAlternate=#${palette[0]}
BackgroundNormal=#${palette[0]}
DecorationFocus=#${palette[6]}
DecorationHover=#${palette[11]}
ForegroundActive=#${palette[1]}
ForegroundInactive=#${palette[11]}
ForegroundLink=#${palette[7]}
ForegroundNegative=#${palette[4]}
ForegroundNeutral=#${palette[6]}
ForegroundNormal=#${palette[1]}
ForegroundPositive=#${palette[5]}
ForegroundVisited=#${palette[8]}

[General]
ColorScheme=DynamicTheme
Name=Dynamic Theme
accentActiveTitlebar=false
shadeSortColumn=true

[KDE]
contrast=4

[WM]
activeBackground=#${palette[0]}
activeBlend=#${palette[1]}
activeForeground=#${palette[1]}
inactiveBackground=#${palette[0]}
inactiveBlend=#${palette[11]}
inactiveForeground=#${palette[11]}
THEME
)"

printf '%s' "$output" > "${dest_dir}${dest_file}"

# Latte Dock
/usr/lib/plasma-changeicons "${palette[12]}"
$latte-dock —replace

# Wallpaper
dbus-send --session --dest=org.kde.plasmashell --type=method_call /PlasmaShell org.kde.PlasmaShell.evaluateScript "string:
var Desktops = desktops();                                                                                                                       
for (i=0;i<Desktops.length;i++) {
        d = Desktops[i];
        d.wallpaperPlugin = 'org.kde.image';
        d.currentConfigGroup = Array('Wallpaper',
                                    'org.kde.image',
                                    'General');
        d.writeConfig('Image', '${palette[13]}');
}"

plasma-theme -c "${dest_dir}${dest_file}"