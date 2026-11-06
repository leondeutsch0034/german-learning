#!/bin/bash
# 把 git 工作副本的 index.html / site.css 同步到旧生成目录。
# 旧目录里的一次性部署脚本会整份上传 index.html，副本过期就会覆盖线上（11/02 事故）。
ROOT="$(git rev-parse --show-toplevel 2>/dev/null)" || exit 0
OLD="$HOME/Desktop/口袋/软件开发/Leon德语学习包网站"
[ -d "$OLD" ] || exit 0
changed=0
for f in index.html site.css; do
  [ -f "$ROOT/$f" ] || continue
  if ! cmp -s "$ROOT/$f" "$OLD/$f"; then
    [ -f "$OLD/$f" ] && cp -p "$OLD/$f" "$OLD/$f.bak-sync" 2>/dev/null
    cp -p "$ROOT/$f" "$OLD/$f" || { echo "[sync] 复制 $f 失败" >&2; continue; }
    changed=1
  fi
done
[ "$changed" = 1 ] && echo "[sync] index.html/site.css → 旧生成目录"
exit 0
