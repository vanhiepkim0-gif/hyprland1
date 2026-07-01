#!/usr/bin/env bash
# Mở terminal tại HOME (nơi VS Code lưu các chat Claude) + claude --resume để CHỌN session nối lại.
# Khi Claude thoát, rớt về shell.
exec kitty --directory /home/michael --title "Claude" \
    bash -c '/home/michael/.local/bin/claude --resume; exec bash'
