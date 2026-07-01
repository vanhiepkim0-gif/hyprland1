#!/usr/bin/env bash
# ============================================================
#  Dịch nhanh (Google Translate qua translate-shell)
#  - Dịch nội dung đang có trong CLIPBOARD, tự nhận hướng VN <-> EN
#  - Kết quả hiện ở thông báo + tự copy lại vào clipboard để dán ngay
# ============================================================
text="$(wl-paste 2>/dev/null)"

if [ -z "${text//[[:space:]]/}" ]; then
    notify-send -a "Dịch" "🌐 Google Dịch" "Clipboard trống.
Bôi đen + Ctrl+C đoạn cần dịch rồi bấm lại (hoặc chuột phải để mở web)."
    exit 0
fi

norm() { printf '%s' "$1" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:][:punct:]'; }

# Mặc định dịch sang tiếng Anh; nếu vốn đã là tiếng Anh -> dịch sang tiếng Việt
out="$(trans -b ':en' -- "$text" 2>/dev/null)"
dir="→ EN 🇺🇸"
if [ -z "$out" ] || [ "$(norm "$out")" = "$(norm "$text")" ]; then
    out="$(trans -b ':vi' -- "$text" 2>/dev/null)"
    dir="→ VI 🇻🇳"
fi

if [ -n "$out" ]; then
    printf '%s' "$out" | wl-copy
    notify-send -a "Dịch" "🌐 Google Dịch  $dir  (đã copy)" "$out"
else
    notify-send -a "Dịch" "🌐 Google Dịch" "Không dịch được — kiểm tra mạng, hoặc chuột phải mở web."
fi
