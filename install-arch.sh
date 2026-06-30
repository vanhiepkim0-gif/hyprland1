#!/usr/bin/env bash
# Cài bộ Hyprland (Catppuccin) trên ARCH LINUX: cài gói + chép config.
set -e

PACMAN_PKGS=(
  hyprland xdg-desktop-portal-hyprland hyprpolkitagent hyprpaper hyprlock hypridle hyprland-qtutils
  waybar wofi kitty swaync swaybg
  grim slurp swappy wf-recorder wl-clipboard cliphist
  brightnessctl playerctl pavucontrol
  network-manager-applet blueman
  cava fastfetch nautilus
  ttf-jetbrains-mono ttf-jetbrains-mono-nerd ttf-font-awesome noto-fonts-emoji
  fcitx5 fcitx5-unikey fcitx5-configtool fcitx5-gtk fcitx5-qt
  polkit python
)
AUR_PKGS=( azote grimshot )

echo "→ Cài gói chính (pacman)..."
sudo pacman -S --needed --noconfirm "${PACMAN_PKGS[@]}"

echo "→ Cài gói AUR..."
if command -v yay >/dev/null; then
    yay -S --needed --noconfirm "${AUR_PKGS[@]}"
elif command -v paru >/dev/null; then
    paru -S --needed --noconfirm "${AUR_PKGS[@]}"
else
    echo "  ⚠ Chưa có AUR helper. Cài yay rồi chạy lại:"
    echo "    sudo pacman -S --needed git base-devel"
    echo "    git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si"
    echo "    yay -S ${AUR_PKGS[*]}"
fi

echo "→ Bật Bluetooth..."
sudo systemctl enable --now bluetooth 2>/dev/null || true

echo "→ Chép config + hình nền..."
"$(dirname "$0")/install.sh"

cat <<'NOTE'

✅ Xong! Vài thứ chỉnh tay cho Arch:
  • Arch KHÔNG cần im-config — env fcitx5 đã nằm trong hyprland.conf. Đăng xuất/đăng nhập lại để áp.
  • Telegram: cài 'telegram-desktop' (pacman) rồi sửa dòng TG trong ~/.config/hypr/telegram.sh thành: TG=telegram-desktop
  • Màn hình: sửa dòng 'monitor =' trong hyprland.conf cho đúng độ phân giải/scale máy Arch.
  • Nếu username khác 'michael': sed -i "s|/home/michael|$HOME|g" ~/.config/hypr/hyprland.conf ~/.config/hypr/*.sh
  • Độ sáng: thêm mình vào nhóm video nếu phím sáng lỗi: sudo gpasswd -a $USER video (rồi đăng nhập lại)
NOTE
