#!/usr/bin/env bash
# Chuyển qua lại giữa Unikey (tiếng Việt) và tiếng Anh
cur=$(ibus engine 2>/dev/null)
if [ "$cur" = "Unikey" ]; then
    ibus engine xkb:us::eng
    notify-send -t 1000 "Bộ gõ" "🇺🇸 Tiếng Anh (EN)" 2>/dev/null || true
else
    ibus engine Unikey
    notify-send -t 1000 "Bộ gõ" "🇻🇳 Tiếng Việt (VI)" 2>/dev/null || true
fi
