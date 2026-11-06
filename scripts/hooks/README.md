# Git hooks：主站文件双源守卫

`index.html` / `site.css` 同时存在于两处：

- 本仓库（**唯一真源**，线上部署直接来自这里）
- 旧生成目录 `~/Desktop/口袋/软件开发/Leon德语学习包网站/`（主题/新闻脚本的工作区，部分一次性脚本会整份上传这里的副本）

2026-11-02 第 58 期发布时，旧副本停在 10/22 之前，整份覆盖线上，导致学生入口等一批功能消失。

## 装了哪些

- `post-commit` / `post-merge` / `post-checkout` → `_sync-site-copy.sh`：把本仓库的 `index.html`、`site.css` 同步到旧目录（旧文件备份为 `*.bak-sync`）
- `pre-commit`：提交 `index.html` 时校验关键区块（`student-portal-v1`、`id="hr-sec1"`、`b1s8Gate`、`window.deepLinkTo`），缺任一即拒绝提交

## 新机器 / 重新 clone 后启用

```bash
cd ~/Desktop/口袋/软件开发/german-learning
git config core.hooksPath scripts/hooks
```
