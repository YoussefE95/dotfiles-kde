yay -Syyu

yay -S kwin-bismuth sierrabreeze-kwin-decoration-git xorg-server xsettingsd alacritty zsh starship apple-fonts ttf-iosevka-nerd ranger ueberzug neofetch cmatrix pipes.sh gotop-bin htop discord dropbox neovim expressvpn spotifyd spotify-tui cmake extra-cmake-modules jq python-pip bluez bluedevil nodejs npm

git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

python3 -m pip install -U https://github.com/leovoel/BeautifulDiscord/archive/master.zip

sudo rsync -a .config .local .zshrc ~/
sudo cp .config/theme-setter/set-theme /usr/local/bin/
sudo cp .config/theme-setter/get-theme /usr/local/bin/
sudo cp .config/theme-setter/reapply-theme /usr/local/bin/

sudo rm -rf ~/Documents ~/Music ~/Public ~/Videos ~/Templates ~/Pictures

systemctl --user enable spotifyd.service --now
sudo systemctl enable bluetooth
sudo systemctl enable expressvpn

cd ~/Downloads/
git clone https://github.com/maldoinc/plasma-theme-switcher
cd plasma-theme-switcher
./build-release
sudo cp cmake-build-release/plasma-theme /usr/local/bin/

# set discord theme
# python3 -m beautifuldiscord --css ~/.config/beautdisc/global_theme.css
