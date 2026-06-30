#!/usr/bin/env bash
# Session Claude CHUYÊN check shop — luôn NỐI LẠI cuộc trò chuyện cũ
# (Claude nhớ ngữ cảnh, khỏi phải kể lại dự án mỗi lần).
DIR=/home/michael/teamhiep/meologin
CLAUDE=/home/michael/.local/bin/claude
exec kitty --directory "$DIR" --title "Claude · CHECK SHOP" \
    bash -c "$CLAUDE --continue || $CLAUDE ; exec bash"
