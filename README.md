# my-skills

我自己用的 skill 集合，仓库在 `C:\code\my-skills`。每个子目录是一个 skill，`SKILL.md` 是入口。

## 安装本仓库的 skill

复制安装（仓库里的源改了要重跑一次）：

```sh
./install.sh                          # 装全部
./install.sh human-like-conversation  # 只装指定的
```

或者链接安装，改仓库里的源即时生效（以 human-like-conversation 为例，换成别的名字一样；先删掉 skills 下的同名目录）：

```sh
# Windows（目录联接，不需要管理员权限）
powershell -NoProfile -Command "New-Item -ItemType Junction -Path 'C:\Users\Chen\.claude\skills\human-like-conversation' -Target 'C:\code\my-skills\human-like-conversation'"

# Linux / macOS
ln -s ~/code/my-skills/human-like-conversation ~/.claude/skills/human-like-conversation
```

目标目录默认 `~/.claude/skills`，可用环境变量 `CLAUDE_SKILLS_DIR` 覆盖。

注意：对已经用链接安装的 skill 重跑 `install.sh`，会把链接换回复制版。

## 从 GitHub 安装别人的 skill

任何对话里说"请帮我安装 xxx"并附上 GitHub 链接即可，install-skill 会自动触发，把 skill 装进本仓库再安装到本机。想手动做的话：clone、找到含 `SKILL.md` 的目录、复制进仓库、跑 `./install.sh`。

## 收录

- **human-like-conversation** — 对话全程的表达与保真准则。新对话开始时 `/human-like-conversation` 调用一次，全程生效。
- **install-skill** — "请帮我安装 xxx"+ GitHub 链接时自动触发，把外部 skill 装进本仓库并安装。

## 添加新 skill

1. 新建同名子目录，里面放 `SKILL.md`（frontmatter 带 `name` 和 `description`；只手动触发的加 `disable-model-invocation: true`），参考资料放该子目录的 `references/`。
2. 跑 `./install.sh <名字>`，或在"收录"里加一行说明。
