#!/bin/bash
settings="$HOME/.config/Code - OSS/User/settings.json"

if [ "$1" == "gruvbox" ]; then
    if [ "$2" == "dark" ]; then
        sed -i "s/.*workbench.colorTheme.*/\"workbench.colorTheme\": \"Gruvbox Material Dark\",/" "$settings"
        sed -i "s/.*gruvboxMaterial.darkContrast.*/\"gruvboxMaterial.darkContrast\": \"$3\",/" "$settings"
    else
        sed -i "s/.*workbench.colorTheme.*/\"workbench.colorTheme\": \"Gruvbox Material Light\",/" "$settings"
        sed -i "s/.*gruvboxMaterial.lightContrast.*/\"gruvboxMaterial.lightContrast\": \"$3\",/" "$settings"
    fi
else
    if [ "$2" == "dark" ]; then
        if [ "$3" == "hard" ]; then
            sed -i "s/.*workbench.colorTheme.*/\"workbench.colorTheme\": \"Catppuccin Mocha\",/" "$settings"
        elif [ "$3" == "medium" ]; then
            sed -i "s/.*workbench.colorTheme.*/\"workbench.colorTheme\": \"Catppuccin Macchiato\",/" "$settings"
        else
            sed -i "s/.*workbench.colorTheme.*/\"workbench.colorTheme\": \"Catppuccin Frappé\",/" "$settings"
        fi
    else
        sed -i "s/.*workbench.colorTheme.*/\"workbench.colorTheme\": \"Catppuccin Latte\",/" "$settings"
    fi
fi