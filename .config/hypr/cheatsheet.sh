#!/usr/bin/env bash
# Hiện bảng tra phím tắt Hyprland (đọc từ hyprland.conf), tìm kiếm được bằng wofi.
python3 - "$HOME/.config/hypr/hyprland.conf" <<'PY' | wofi --dmenu --prompt "⌨️  Phím tắt (gõ để tìm)" --width 820 --height 600 --insensitive >/dev/null
import re, sys
conf = sys.argv[1]
rows = []
for ln in open(conf, encoding="utf-8"):
    m = re.match(r'\s*bind[a-z]*\s*=\s*(.*)', ln)
    if not m:
        continue
    rest = m.group(1)
    comment = ""
    if '#' in rest:
        rest, comment = rest.split('#', 1)
        comment = comment.strip()
    parts = [p.strip() for p in rest.split(',')]
    mods = parts[0].replace('$mod', 'SUPER') if parts else ''
    key = parts[1] if len(parts) > 1 else ''
    combo = (mods + ' + ' + key).strip() if mods else key
    combo = combo.strip(' +')
    action = comment or (' '.join(parts[2:]).replace('$menu', 'wofi').replace('$term', 'kitty') if len(parts) > 2 else '')
    if combo:
        rows.append(f"{combo:<24} →  {action}")
print("\n".join(rows))
PY
