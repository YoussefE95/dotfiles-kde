yay -Syyu

yay -S kwin-bismuth sierrabreeze-kwin-decoration-git xorg-server xsettingsd alacritty zsh starship apple-fonts ttf-iosevka-nerd ranger ueberzug neofetch pipes.sh gotop-bin htop discord dropbox neovim xclip expressvpn spotify-launcher spicetify-cli cmake extra-cmake-modules jq python-pipx bluez bluedevil nodejs npm

git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

pipx install https://github.com/leovoel/BeautifulDiscord/archive/master.zip

sudo rsync -a .config .local .zshrc ~/
sudo cp .config/theme-setter/set-theme /usr/local/bin/
sudo cp .config/theme-setter/get-theme /usr/local/bin/

sudo rm -rf ~/Documents ~/Music ~/Public ~/Videos ~/Templates ~/Pictures

sudo systemctl enable bluetooth
sudo systemctl enable expressvpn

cd ~/Downloads/
git clone https://github.com/maldoinc/plasma-theme-switcher
cd plasma-theme-switcher
./build-release
sudo cp cmake-build-release/plasma-theme /usr/local/bin/

# set discord theme
# ~/.local/bin/beautifuldiscord --css ~/.config/beautdisc/global_theme.css

# set spotify theme
# spicetify config inject_css 1 replace_colors 1 overwrite_assets 1 inject_theme_js 1
# spicetify config current_theme Comfy
# spicetify config color_scheme dynamic
# spicetify backup apply
