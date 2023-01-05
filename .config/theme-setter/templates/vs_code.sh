vs_settings="$HOME/.config/Code/User/settings.json"
vs_theme=$(jq ".\"$1\".vs_code.\"$2\"" "$3")
sed -i /.*workbench.colorTheme.*/c\\"\t\"workbench.colorTheme\": $vs_theme," "$vs_settings"