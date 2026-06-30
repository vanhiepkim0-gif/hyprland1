#!/usr/bin/env bash
# PHÍM CỨU HỘ: lỡ gõ tiếng Việt bị "đơ" thì chạy cái này (⊞+Shift+Space).
# Khởi động lại ibus rồi bật Unikey.
ibus restart 2>/dev/null
sleep 1.5
ibus engine Unikey 2>/dev/null
notify-send -t 1500 "🇻🇳 Bộ gõ" "Đã khởi động lại tiếng Việt (Unikey)" 2>/dev/null || true
