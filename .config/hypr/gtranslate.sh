#!/usr/bin/env bash
# ============================================================
#  Google Dịch — cửa sổ POPUP dạng app (Anh <-> Việt)
#  - Mở Google Dịch ở chế độ --app của Chrome: cửa sổ sạch, không tab/thanh địa chỉ
#  - Tự cho NỔI + kích thước gọn + căn giữa (Chrome fork tiến trình nên phải xử lý sau khi mở)
#  - Đã mở sẵn -> chỉ focus (không mở trùng).  Không có Chromium -> mở web thường.
# ============================================================
URL='https://translate.google.com.vn/?sl=auto&tl=vi&op=translate'
PROFILE="$HOME/.config/gtranslate-app"          # hồ sơ riêng -> luôn là cửa sổ độc lập

BROWSER=""
for b in google-chrome-stable google-chrome chromium chromium-browser brave brave-browser microsoft-edge-stable; do
    command -v "$b" >/dev/null 2>&1 && { BROWSER="$b"; break; }
done
[ -z "$BROWSER" ] && { xdg-open "$URL" >/dev/null 2>&1; exit 0; }

export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export HYPRLAND_INSTANCE_SIGNATURE="$(ls -t "$XDG_RUNTIME_DIR/hypr" 2>/dev/null | head -1)"

# Ngoài Hyprland: mở thẳng, không cần chỉnh cửa sổ
if [ -z "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
    setsid "$BROWSER" --app="$URL" --user-data-dir="$PROFILE" --class=gtranslate \
        --no-first-run --no-default-browser-check >/dev/null 2>&1 &
    exit 0
fi

# Đã có cửa sổ Dịch (đang nổi) -> chỉ focus, tránh mở trùng
existing=$(hyprctl clients -j 2>/dev/null | python3 -c '
import sys, json
for c in json.load(sys.stdin):
    if "Dịch" in c.get("title", "") and c.get("floating"):
        print(c["address"]); break' 2>/dev/null)
if [ -n "$existing" ]; then
    hyprctl dispatch focuswindow "address:$existing" >/dev/null 2>&1
    exit 0
fi

# Ghi lại cửa sổ hiện có TRƯỚC khi mở (để nhận ra cửa sổ MỚI)
export BEFORE=$(hyprctl clients -j 2>/dev/null | python3 -c 'import sys,json; print(",".join(c["address"] for c in json.load(sys.stdin)))')

setsid "$BROWSER" --app="$URL" --user-data-dir="$PROFILE" --class=gtranslate \
    --no-first-run --no-default-browser-check >/dev/null 2>&1 &

# Đợi cửa sổ MỚI xuất hiện -> nổi + gọn + căn giữa
for i in $(seq 1 40); do
    addr=$(hyprctl clients -j 2>/dev/null | python3 -c '
import sys, json, os
before = set(filter(None, os.environ.get("BEFORE", "").split(",")))
for c in json.load(sys.stdin):
    a = c["address"]; t = c.get("title", "")
    if a not in before and ("Dịch" in t or "ranslate" in t):
        if not c.get("floating"):
            print(a)
        break' 2>/dev/null)
    if [ -n "$addr" ]; then
        hyprctl --batch "dispatch focuswindow address:$addr ; dispatch togglefloating address:$addr ; dispatch resizewindowpixel exact 900 650,address:$addr ; dispatch centerwindow" >/dev/null 2>&1
        break
    fi
    sleep 0.25
done
