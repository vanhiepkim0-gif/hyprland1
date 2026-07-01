#!/usr/bin/env bash
# Mở terminal tại ~/teamhiep + claude --resume để CHỌN session nối lại.
# Khi Claude thoát, rớt về shell trong thư mục đó.
exec kitty --directory /home/michael/teamhiep --title "Claude · teamhiep" \
    bash -c '/home/michael/.local/bin/claude --resume; exec bash'
