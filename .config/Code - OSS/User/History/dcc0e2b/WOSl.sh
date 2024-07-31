# Delete unnecessary folders
sudo rm -rf ~/Documents ~/Music ~/Public ~/Videos ~/Templates ~/Pictures

# Copy config files
sudo rsync -a .config .local .zshrc ~/

# Copy theming scripts
sudo cp .config/theme-setter/set-theme .config/theme-setter/get-theme /usr/local/bin/

# Update and install packages
yay -Syu && yay -S kitty starship ttf-jetbrains-mono ttf-jetbrains-mono-nerd code neovim ripgrep zathura zathura-pdf-poppler wl-clipboard ranger nvtop htop expressvpn dropbox discord spotify-launcher spicetify-cli obsidian jq nodejs npm python-pipx python-pillow zsh zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting

# Install Spicetify
# spicetify config inject_css 1 replace_colors 1 overwrite_assets 1 inject_theme_js 1
# spicetify config current_theme Comfy
# spicetify config color_scheme dynamic
# spicetify backup apply

# Install Beautiful Discord
pipx install https://github.com/leovoel/BeautifulDiscord/archive/master.zip
# ~/.local/bin/beautifuldiscord --css ~/.config/beautifuldiscord.css

# Make zsh default shell
chsh -s $(which zsh)
