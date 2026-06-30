#!/usr/bin/env bash
# Mở/nhảy tới Telegram, luôn đặt ở workspace cố định.
TG="/home/michael/Downloads/tsetup.6.9.3/Telegram/Telegram"
WS=9   # workspace mặc định của Telegram (đổi số này nếu muốn)

# Không ở trong Hyprland -> mở bình thường
if [ -z "$HYPRLAND_INSTANCE_SIGNATURE" ]; then exec "$TG" "$@"; fi

# Tìm cửa sổ Telegram đang mở
addr=$(hyprctl clients -j 2>/dev/null | python3 -c "
import json,sys
for c in json.load(sys.stdin):
    if c.get('class','').startswith('org.telegram.desktop'):
        print(c['address']); break
" 2>/dev/null)

if [ -n "$addr" ]; then
    hyprctl dispatch focuswindow address:$addr      # đã mở -> nhảy tới
else
    hyprctl dispatch exec "[workspace $WS silent] $TG"   # chưa mở -> mở ở workspace WS
fi
