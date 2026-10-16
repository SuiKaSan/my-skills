# human-like-conversation

我自己用的 skill 集合。每个子目录是一个 skill，`SKILL.md` 是入口。

## 安装

复制安装（仓库里的源改了要重跑一次）：

```sh
./install.sh            # 装全部
./install.sh shuohua    # 只装指定的
```

或者链接安装，改仓库里的源即时生效（以 shuohua 为例，换成别的名字一样）：

```sh
# Windows（目录联接，不需要管理员权限；先删掉 skills 下的同名目录）
powershell -NoProfile -Command "New-Item -ItemType Junction -Path 'C:\Users\Chen\.claude\skills\shuohua' -Target 'C:\Users\Chen\human-like-conversation\shuohua'"

# Linux / macOS
ln -s ~/human-like-conversation/shuohua ~/.claude/skills/shuohua
```

目标目录默认 `~/.claude/skills`，可用环境变量 `CLAUDE_SKILLS_DIR` 覆盖。

注意：对已经用链接安装的 skill 重跑 `install.sh`，会把链接换回复制版。

## 收录

- **shuohua** — 对话全程的表达与保真准则。新对话开始时 `/shuohua` 调用一次，全程生效。

## 添加新 skill

1. 新建同名子目录，里面放 `SKILL.md`（frontmatter 带 `name` 和 `description`；只手动触发的加 `disable-model-invocation: true`），参考资料放该子目录的 `references/`。
2. 跑 `./install.sh <名字>`，或在 README 的"收录"里加一行说明。
