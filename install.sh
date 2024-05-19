# Delete unnecessary folders
sudo rm -rf ~/Documents ~/Music ~/Public ~/Videos ~/Templates ~/Pictures

# Copy config files
sudo rsync -a .config .local .zshrc ~/

# Copy theming scripts
sudo cp .config/theme-setter/set-theme .config/theme-setter/get-theme /usr/local/bin/

# Update and install packages
sudo pacman -Syu && sudo pacman -S kitty starship ttf-iosevka-nerd neovim ripgrep zathura zathura-pdf-poppler wl-clipboard ranger nvtop htop discord spotify-launcher obsidian jq nodejs npm python-pipx python-pillow zsh zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting

# Install Dropbox
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
# ~/.dropbox-dist/dropboxd

# Install Spicetify
curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.sh | sh
# spicetify config inject_css 1 replace_colors 1 overwrite_assets 1 inject_theme_js 1
# spicetify config current_theme Comfy
# spicetify config color_scheme dynamic
# spicetify backup apply

# Install Beautiful Discord
pipx install https://github.com/leovoel/BeautifulDiscord/archive/master.zip
# ~/.local/bin/beautifuldiscord --css ~/.config/beautifuldiscord.css

# Make zsh default shell
chsh -s $(which zsh)
