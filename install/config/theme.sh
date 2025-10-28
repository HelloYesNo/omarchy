# Set links for Nautilius action icons
ln -snf /usr/share/icons/Adwaita/symbolic/actions/go-previous-symbolic.svg /usr/share/icons/Yaru/scalable/actions/go-previous-symbolic.svg
ln -snf /usr/share/icons/Adwaita/symbolic/actions/go-next-symbolic.svg /usr/share/icons/Yaru/scalable/actions/go-next-symbolic.svg

# Setup theme links
mkdir -p $HOME/.config/omarchy/themes
for f in $HOME/.local/share/omarchy/themes/*; do ln -nfs "$f" $HOME/.config/omarchy/themes/; done

# Set initial theme
mkdir -p $HOME/.config/omarchy/current
ln -snf $HOME/.config/omarchy/themes/tokyo-night $HOME/.config/omarchy/current/theme
ln -snf $HOME/.config/omarchy/current/theme/backgrounds/1-scenery-pink-lakeside-sunset-lake-landscape-scenic-panorama-7680x3215-144.png $HOME/.config/omarchy/current/background

# Set specific app links for current theme
# $HOME/.config/omarchy/current/theme/neovim.lua -> $HOME/.config/nvim/lua/plugins/theme.lua is handled via omarchy-setup-nvim

mkdir -p $HOME/.config/btop/themes
ln -snf $HOME/.config/omarchy/current/theme/btop.theme $HOME/.config/btop/themes/current.theme

mkdir -p $HOME/.config/mako
ln -snf $HOME/.config/omarchy/current/theme/mako.ini $HOME/.config/mako/config

mkdir -p $HOME/.config/eza
ln -snf $HOME/.config/omarchy/current/theme/eza.yml $HOME/.config/eza/theme.yml

# Add managed policy directories for Chromium and Brave for theme changes
mkdir -p /etc/chromium/policies/managed
chmod a+rw /etc/chromium/policies/managed

mkdir -p /etc/brave/policies/managed
chmod a+rw /etc/brave/policies/managed
