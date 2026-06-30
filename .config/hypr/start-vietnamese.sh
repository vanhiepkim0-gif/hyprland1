#!/usr/bin/env bash
# Bật & giữ Unikey khi đăng nhập — KHÔNG đánh nhau với ibus của hệ thống.
# (Trước đây dùng -drxR có cờ -r = thay thế, gây giết nhau loạn → ibus chết. Đã bỏ.)

# 1) Đợi ibus (hệ thống thường tự khởi động) sẵn sàng tối đa ~8s
for i in $(seq 1 16); do
    ibus engine >/dev/null 2>&1 && break
    sleep 0.5
done

# 2) Nếu vẫn chưa có daemon -> tự khởi động, KHÔNG -r (khỏi giết cái khác)
pgrep -x ibus-daemon >/dev/null || { setsid ibus-daemon -d -x --panel disable >/dev/null 2>&1 & sleep 2; }

# 3) Ép giữ Unikey tới khi ổn định 3 lần liên tiếp
ok=0
for i in $(seq 1 20); do
    if ibus engine >/dev/null 2>&1; then
        if [ "$(ibus engine 2>/dev/null)" = "Unikey" ]; then
            ok=$((ok + 1)); [ "$ok" -ge 3 ] && exit 0
        else
            ibus engine Unikey 2>/dev/null; ok=0
        fi
    fi
    sleep 1
done
