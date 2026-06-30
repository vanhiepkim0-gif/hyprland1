# 🪟 Hyprland Dotfiles — Catppuccin Mocha

Cấu hình Hyprland cá nhân — tông màu **Catppuccin Mocha**, thanh bar nổi, trung tâm điều khiển, gõ tiếng Việt (fcitx5), và nhiều tiện ích. Chạy được trên Ubuntu 26.04 và Arch Linux.

![theme](assets/catppuccin-waves.png)

## ✨ Tính năng
- **Catppuccin Mocha** đồng bộ: Hyprland (viền gradient, blur, shadow, animation) + Waybar + Wofi + Kitty + SwayNC + Cava.
- **Thanh bar nổi (Waybar)** — icon Nerd Font (Material Design), workspace có biểu tượng; đồng hồ VN + **giờ Mỹ** (TikTok Shop US), thời tiết, nhạc đang phát, CPU/RAM/sáng/âm/wifi/pin, nút Telegram, nút thông báo.
- **Trung tâm điều khiển (SwayNC)** — Wifi/Bluetooth/âm lượng/độ sáng/DND + lịch sử thông báo (⊞+N hoặc nút 🔔).
- **Gõ tiếng Việt: fcitx5 + Unikey** — ổn định trên Wayland (ăn tốt với VS Code/Chrome/Electron), tự bật khi đăng nhập.
- Quay màn (wf-recorder), lịch sử clipboard (cliphist, kiểu Win+V), chụp màn (grimshot+swappy), vuốt 3 ngón đổi workspace, bảng tra phím tắt (⊞+/).
- Telegram luôn mở ở workspace 9. Hình nền + icon tự thiết kế (nguồn SVG trong `assets/`).

## ⌨️ Phím tắt (MOD = SUPER / phím Windows)
| Phím | Tác dụng |
|------|----------|
| `MOD+Enter` / `MOD+D` | Terminal / Menu ứng dụng |
| `MOD+E` / `MOD+W` | File manager / Đổi hình nền |
| `MOD+N` | Trung tâm điều khiển (swaync) |
| `MOD+A` / `MOD+T` | Cava (nhạc) / Telegram |
| `MOD+Space` | Đổi bộ gõ Việt ⇄ Anh (fcitx5) |
| `MOD+Shift+Space` | Cứu hộ bộ gõ (restart fcitx5) |
| `MOD+Shift+S` | Chụp vùng → clipboard (giống Windows) |
| `MOD+R` / `MOD+Shift+R` | Quay màn / quay vùng |
| `MOD+V` / `MOD+/` | Lịch sử clipboard / Bảng tra phím tắt |
| `MOD+Escape` | Menu nguồn (wlogout) |
| `MOD+Q` · `MOD+F` · `MOD+1..9` | Đóng · Toàn màn · Workspace · (vuốt 3 ngón đổi ws) |

## 🚀 Cài đặt

### Arch Linux (máy phụ)
```bash
git clone https://github.com/vanhiepkim0-gif/hyprland1.git
cd hyprland1
./install-arch.sh     # cài gói (pacman + AUR) + chép config + hình nền
```
> Cần AUR helper (yay/paru) cho `azote`, `grimshot` — script sẽ nhắc cách cài yay nếu thiếu.

### Ubuntu 26.04
```bash
git clone https://github.com/vanhiepkim0-gif/hyprland1.git
cd hyprland1
sudo apt install hyprland waybar wofi kitty hyprpaper hyprlock hypridle \
  hyprpolkitagent hyprland-qtutils xdg-desktop-portal-hyprland grim slurp \
  wl-clipboard brightnessctl playerctl network-manager-gnome pavucontrol \
  cliphist swappy grimshot wf-recorder blueman azote swaybg \
  sway-notification-center cava fastfetch nautilus \
  fonts-font-awesome fonts-jetbrains-mono \
  fcitx5 fcitx5-unikey fcitx5-config-qt fcitx5-frontend-gtk3 \
  fcitx5-frontend-gtk4 fcitx5-frontend-qt5 fcitx5-frontend-qt6
im-config -n fcitx5           # đặt fcitx5 làm bộ gõ hệ thống
./install.sh                  # chép config + hình nền
```
Ubuntu cần thêm **JetBrainsMono Nerd Font** (tải từ nerd-fonts → `~/.local/share/fonts` → `fc-cache -f`). Arch có sẵn gói `ttf-jetbrains-mono-nerd`.

Sau đó **đăng xuất → chọn Hyprland** ở màn hình đăng nhập.

## 📝 Chỉnh tay sau khi cài
- **Username khác `michael`**: `sed -i "s|/home/michael|$HOME|g" ~/.config/hypr/hyprland.conf ~/.config/hypr/*.sh`
- **Màn hình**: sửa dòng `monitor =` trong `hypr/hyprland.conf` (độ phân giải/scale).
- **Telegram**: sửa `TG=` trong `hypr/telegram.sh` (Arch: `telegram-desktop`).
- **Gõ tiếng Việt**: fcitx5 tự bật; nếu đơ nhấn `MOD+Shift+Space`. Phải đăng nhập lại để env áp vào app.

---
*Tạo với sự hỗ trợ của Claude Code.* 🤖
