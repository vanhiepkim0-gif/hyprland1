#!/usr/bin/env bash
# ============================================================
#  Tỷ giá USD -> VND cho waybar (cập nhật mỗi giờ)
# ============================================================
out=$(curl -s --max-time 8 https://open.er-api.com/v6/latest/USD 2>/dev/null \
  | python3 -c 'import sys,json
try:
    v=json.load(sys.stdin)["rates"]["VND"]
    print(f"{round(v):,}")
except Exception:
    pass' 2>/dev/null)

if [ -n "$out" ]; then
    printf '{"text":"%s","tooltip":"1 USD = %s ₫  (cuộn/bấm để tra Google)"}\n' "$out" "$out"
else
    printf '{"text":"--","tooltip":"Chưa lấy được tỷ giá USD→VND (kiểm tra mạng)"}\n'
fi
