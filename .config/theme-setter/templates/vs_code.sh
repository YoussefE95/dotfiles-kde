vs_settings="$HOME/.config/Code/User/settings.json"
sed -i /.*workbench.colorTheme.*/c\\"\t\"workbench.colorTheme\": $1," "$vs_settings"