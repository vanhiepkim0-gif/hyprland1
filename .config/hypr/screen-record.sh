#!/usr/bin/env bash
# Bật/tắt quay màn hình bằng wf-recorder.
#   screen-record.sh full         -> quay cả màn hình (không tiếng)
#   screen-record.sh region       -> chọn vùng để quay (không tiếng)
#   screen-record.sh full audio   -> quay cả màn hình + tiếng (mic/loa mặc định)

mode="${1:-full}"
audio="$2"
dir="$HOME/Videos"
mkdir -p "$dir"

# Nếu đang quay -> dừng (gửi SIGINT để wf-recorder đóng file mp4 đúng cách)
if pgrep -x wf-recorder >/dev/null; then
    pkill -INT -x wf-recorder
    notify-send -t 2500 "🎥 Quay màn hình" "⏹️ Đã dừng — video lưu ở ~/Videos" 2>/dev/null || true
    exit 0
fi

ts=$(date +%Y%m%d_%H%M%S)
file="$dir/quaymanhinh_$ts.mp4"
args=(-f "$file")

if [ "$mode" = "region" ]; then
    geo=$(slurp) || exit 1            # chọn vùng; bấm Esc để huỷ
    args+=(-g "$geo")
fi
[ "$audio" = "audio" ] && args+=(-a)

wf-recorder "${args[@]}" >/dev/null 2>&1 &
sleep 0.6
if pgrep -x wf-recorder >/dev/null; then
    notify-send -t 2500 "🎥 Quay màn hình" "🔴 Đang quay... Nhấn lại phím tắt để DỪNG." 2>/dev/null || true
else
    notify-send -t 2500 "🎥 Quay màn hình" "❌ Không khởi động được" 2>/dev/null || true
fi
