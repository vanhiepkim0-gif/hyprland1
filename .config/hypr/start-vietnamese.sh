#!/usr/bin/env bash
# Tự bật & GIỮ Unikey khi đăng nhập Hyprland.
# Xử lý "đua tốc độ": nếu ibus mặc định của hệ thống lên trễ và reset về tiếng Anh,
# script vẫn ép lại Unikey cho tới khi ổn định 3 lần liên tiếp.

# Khởi động ibus nếu chưa chạy
pgrep -x ibus-daemon >/dev/null || ibus-daemon -drxR >/dev/null 2>&1 &

ok=0
for i in $(seq 1 25); do
    if ibus engine >/dev/null 2>&1; then
        if [ "$(ibus engine 2>/dev/null)" = "Unikey" ]; then
            ok=$((ok + 1))
            [ "$ok" -ge 3 ] && exit 0    # Unikey đứng vững -> xong
        else
            ibus engine Unikey 2>/dev/null
            ok=0
        fi
    fi
    sleep 1
done
