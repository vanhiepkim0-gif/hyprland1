#!/usr/bin/env bash
# PHÍM CỨU HỘ (⊞+Shift+Space): cứu được CẢ khi ibus chết hẳn.
if pgrep -x ibus-daemon >/dev/null; then
    ibus restart 2>/dev/null               # còn sống -> restart
else
    setsid ibus-daemon -d -x --panel disable >/dev/null 2>&1 &   # chết hẳn -> khởi động lại
fi
sleep 2.5
ibus engine Unikey 2>/dev/null
notify-send -t 1500 "🇻🇳 Bộ gõ" "Đã khởi động lại tiếng Việt (Unikey)" 2>/dev/null || true
