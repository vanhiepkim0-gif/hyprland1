#!/usr/bin/env bash
# Lịch sử clipboard (giống Windows + V): chọn 1 mục -> chép lại; hoặc xoá sạch.

CLEAR="🗑️  Xoá sạch lịch sử clipboard"

# Hiện danh sách: các mục đã copy + dòng "Xoá sạch" ở cuối
choice=$( { cliphist list; echo "$CLEAR"; } | wofi --dmenu --prompt "📋 Lịch sử clipboard" --width 700 --height 400 )

# Không chọn gì -> thoát
[ -z "$choice" ] && exit 0

if [ "$choice" = "$CLEAR" ]; then
    # Hỏi xác nhận trước khi xoá
    confirm=$( printf "Không\nCÓ, xoá sạch" | wofi --dmenu --prompt "Xoá toàn bộ lịch sử clipboard?" )
    if [ "$confirm" = "CÓ, xoá sạch" ]; then
        cliphist wipe
        notify-send -t 1500 "📋 Clipboard" "🗑️ Đã xoá sạch lịch sử" 2>/dev/null || true
    fi
    exit 0
fi

# Chọn 1 mục -> giải mã rồi chép lại vào clipboard
printf '%s' "$choice" | cliphist decode | wl-copy
