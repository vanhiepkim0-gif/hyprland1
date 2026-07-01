#!/usr/bin/env bash
# ============================================================
#  Nhiệt độ CPU (AMD k10temp) cho waybar
#  Tự tìm cảm biến THEO TÊN -> không lệ thuộc số hwmon (đổi sau mỗi lần khởi động)
# ============================================================
temp="?"
for h in /sys/class/hwmon/hwmon*; do
    if [ "$(cat "$h/name" 2>/dev/null)" = "k10temp" ] && [ -f "$h/temp1_input" ]; then
        t=$(cat "$h/temp1_input" 2>/dev/null)
        [ -n "$t" ] && temp=$(( (t + 500) / 1000 ))
        break
    fi
done

cls="normal"
if [ "$temp" != "?" ] && [ "$temp" -ge 82 ] 2>/dev/null; then
    cls="critical"
elif [ "$temp" != "?" ] && [ "$temp" -ge 70 ] 2>/dev/null; then
    cls="warning"
fi

printf '{"text":"%s°C","class":"%s","tooltip":"Nhiệt độ CPU (k10temp): %s°C"}\n' "$temp" "$cls" "$temp"
