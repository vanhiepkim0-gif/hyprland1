#!/usr/bin/env bash
# Cài dotfiles: sao chép .config/* vào ~/.config (tự sao lưu bản cũ).
set -e
SRC="$(cd "$(dirname "$0")" && pwd)/.config"
DST="$HOME/.config"
TS="$(date +%Y%m%d_%H%M%S)"

echo "→ Sao chép từ $SRC vào $DST"
for dir in "$SRC"/*/; do
    name="$(basename "$dir")"
    if [ -e "$DST/$name" ]; then
        echo "  • Sao lưu $DST/$name -> $DST/$name.bak_$TS"
        mv "$DST/$name" "$DST/$name.bak_$TS"
    fi
    cp -r "$dir" "$DST/$name"
    echo "  ✓ $name"
done

# Cấp quyền chạy cho script
chmod +x "$DST"/hypr/*.sh 2>/dev/null || true

echo
echo "✅ Xong! Đăng xuất rồi chọn 'Hyprland' ở màn hình đăng nhập."
echo "   (Nhớ cài JetBrainsMono Nerd Font để icon thanh bar hiển thị đúng.)"
