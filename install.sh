#!/usr/bin/env bash
# 安装本仓库里的 skill 到 Claude Code 的 skills 目录。
# 用法：./install.sh          安装全部
#       ./install.sh shuohua  只装指定的
set -eo pipefail

repo="$(cd "$(dirname "$0")" && pwd)"
dest_root="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
mkdir -p "$dest_root"

# 无参数时，收集仓库下所有含 SKILL.md 的子目录
if [ $# -eq 0 ]; then
  for d in "$repo"/*/; do
    [ -f "${d}SKILL.md" ] && set -- "$@" "$(basename "$d")"
  done
fi

if [ $# -eq 0 ]; then
  echo "仓库里没有可安装的 skill"
  exit 1
fi

for name in "$@"; do
  src="$repo/$name"
  if [ ! -f "$src/SKILL.md" ]; then
    echo "跳过 $name：没有 SKILL.md"
    continue
  fi
  rm -rf "$dest_root/$name"
  cp -r "$src" "$dest_root/$name"
  echo "已安装 $name"
done
