#!/usr/bin/env bash
# Mở terminal tại ~/teamhiep và gọi Claude với danh sách session để CHỌN NỐI LẠI (--resume).
# Khi Claude thoát, rớt về shell trong thư mục đó.
exec kitty --directory /home/michael/teamhiep --title "Claude · teamhiep" \
    bash -c '/home/michael/.local/bin/claude --resume; exec bash'
