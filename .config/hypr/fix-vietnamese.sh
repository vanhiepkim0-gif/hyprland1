#!/usr/bin/env bash
# PHÍM CỨU HỘ (⊞+Shift+Space): khởi động lại fcitx5 nếu gõ tiếng Việt đơ.
pkill -x fcitx5 2>/dev/null
sleep 1
setsid fcitx5 -d >/dev/null 2>&1 &
sleep 1
notify-send -t 1500 "🇻🇳 Bộ gõ" "Đã khởi động lại fcitx5 (Unikey)" 2>/dev/null || true
