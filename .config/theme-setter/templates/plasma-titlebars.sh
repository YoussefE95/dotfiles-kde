palette=("${@}")

dest_dir="$HOME/.local/share/aurorae/themes/Utterly-Round-Dark-Solid/"
dest_file="Utterly-Round-Dark-Solidrc"

fore=$(printf "%d,%d,%d\n" 0x${palette[1]:0:2} 0x${palette[1]:2:2} 0x${palette[1]:4:2})
foreAlt=$(printf "%d,%d,%d\n" 0x${palette[11]:0:2} 0x${palette[11]:2:2} 0x${palette[11]:4:2})

output="$(cat << THEME
[General]
ActiveTextColor=${fore}
Animation=0
InactiveTextColor=${foreAlt}
LeftButtons=XIA
RightButtons=
Shadow=false
TextShadowOffsetX=1
TextShadowOffsetY=1
TitleAlignment=Center
TitleVerticalAlignment=Center
UseTextShadow=true
HaloActive=true
HaloInactive=true

[Layout]
ButtonHeight=15
ButtonWidth=15
ButtonMarginTop=3
ButtonSpacing=8
ExplicitButtonSpacer=10
PaddingBottom=15
PaddingLeft=15
PaddingRight=15
PaddingTop=15
TitleEdgeBottom=5
TitleEdgeBottomMaximized=3
TitleEdgeLeft=8
TitleEdgeLeftMaximized=5
TitleEdgeRight=8
TitleEdgeRightMaximized=5
TitleEdgeTop=5
TitleEdgeTopMaximized=3
TitleHeight=18

THEME
)"

printf '%s' "$output" > "${dest_dir}${dest_file}"