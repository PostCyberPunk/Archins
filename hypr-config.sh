chmod +x ~/.config/hypr/scripts/*

# Set executable for initial-boot.sh
chmod +x ~/.config/hypr/initial-boot.sh
chmod +x ~/.config/rofi/scripts/*
ln -sf "$HOME/.config/waybar/configs/[TOP & BOT] SummitSplit" "$HOME/.config/waybar/config"
ln -sf "$HOME/.config/waybar/style/CatCha.css" "$HOME/.config/waybar/style.css"
ln -sf "$HOME/.config/hypr/lib/GPU/1 Default.conf" "$HOME/.config/hypr/configs/GPU.conf"
ln -sf "$HOME/.config/hypr/lib/Monitor/1 Default.conf" "$HOME/.config/hypr/configs/Monitors.conf"
# wal -i $wallpaper -s -t
