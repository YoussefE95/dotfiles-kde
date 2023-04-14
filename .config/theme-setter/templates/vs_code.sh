vs_settings="$HOME/.config/Code/User/settings.json"

if [[ "$1" == "gruvbox" ]]; then
    if [[ "$2" == "normal" ]]; then
        sed -i /.*gruvboxMaterial.darkContrast.*/c\\"\t\"gruvboxMaterial.darkContrast\": \"medium\"," "$vs_settings"
    elif [[ "$2" == "dark" ]]; then
        sed -i /.*gruvboxMaterial.darkContrast.*/c\\"\t\"gruvboxMaterial.darkContrast\": \"hard\"," "$vs_settings"
    fi
fi

sed -i /.*workbench.colorTheme.*/c\\"\t\"workbench.colorTheme\": $3," "$vs_settings"