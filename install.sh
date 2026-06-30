#!/usr/bin/env bash
# Cài dotfiles: sao chép .config/* vào ~/.config (tự sao lưu bản cũ) + hình nền.
set -e
REPO="$(cd "$(dirname "$0")" && pwd)"
SRC="$REPO/.config"
DST="$HOME/.config"
TS="$(date +%Y%m%d_%H%M%S)"

echo "→ Sao chép config từ $SRC vào $DST"
for dir in "$SRC"/*/; do
    name="$(basename "$dir")"
    if [ -e "$DST/$name" ]; then
        echo "  • Sao lưu $DST/$name -> $DST/$name.bak_$TS"
        mv "$DST/$name" "$DST/$name.bak_$TS"
    fi
    cp -r "$dir" "$DST/$name"
    echo "  ✓ $name"
done
chmod +x "$DST"/hypr/*.sh 2>/dev/null || true

# Hình nền
mkdir -p "$HOME/Pictures/wallpapers"
[ -f "$REPO/assets/catppuccin-waves.png" ] && cp "$REPO/assets/catppuccin-waves.png" "$HOME/Pictures/wallpapers/" && echo "  ✓ hình nền -> ~/Pictures/wallpapers/"

echo
echo "✅ Xong! Đăng xuất rồi chọn 'Hyprland' ở màn hình đăng nhập."
echo "   Nếu username KHÁC 'michael', sửa các đường dẫn /home/michael/... trong ~/.config/hypr/hyprland.conf:"
echo "     sed -i \"s|/home/michael|\$HOME|g\" ~/.config/hypr/hyprland.conf ~/.config/hypr/*.sh"
