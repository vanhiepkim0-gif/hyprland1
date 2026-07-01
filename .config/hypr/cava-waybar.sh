#!/usr/bin/env bash
# ============================================================
#  Sóng nhạc (audio visualizer) cho waybar
#  - Chạy cava, đổi số 0..7 thành cột ▁▂▃▄▅▆▇█
#  - Lúc im lặng (tất cả cột thấp nhất) -> in dòng trống => thanh thu gọn
# ============================================================
CONFIG="/home/michael/.config/cava/waybar_config"

# Bảng đổi số -> ký tự cột nhạc
bar="▁▂▃▄▅▆▇█"
dict="s/;//g"
i=0
while [ "$i" -lt "${#bar}" ]; do
    dict="${dict};s/$i/${bar:$i:1}/g"
    i=$((i + 1))
done

# cava -> đổi số thành cột (unbuffered) -> ẩn khi im lặng
cava -p "$CONFIG" | sed -u "$dict" | while IFS= read -r line; do
    # Bỏ hết cột thấp nhất; nếu còn rỗng nghĩa là đang im lặng
    if [ -z "${line//▁/}" ]; then
        echo
    else
        echo "$line"
    fi
done
