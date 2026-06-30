#!/usr/bin/env bash
# Mở terminal tại ~/teamhiep và gọi luôn Claude CLI.
# Khi Claude thoát, rớt về shell ngay trong thư mục đó (cửa sổ không tự tắt).
exec kitty --directory /home/michael/teamhiep --title "Claude · teamhiep" \
    bash -c '/home/michael/.local/bin/claude; exec bash'
