# my-skills

个人的 AI 助手 skill 集合。每个子目录是一个 skill，`SKILL.md` 是入口，Windows、macOS、Linux 都能装。

## 收录

| Skill | 用途 |
|---|---|
| [human-like-conversation](human-like-conversation/) | 对话全程的表达与保真准则：直接说内容、照实说、不用套话句式。新对话开始时 `/human-like-conversation` 调用一次，全程生效 |
| [install-skill](install-skill/) | 在任何对话里说"请帮我安装 xxx"并附上 GitHub 链接，自动把该 skill 装进本仓库并安装到本机 |

## 安装

先 clone 本仓库，然后二选一。

复制安装（改了仓库里的源要重跑一次）：

```sh
./install.sh                          # 装全部
./install.sh human-like-conversation  # 只装指定的
```

链接安装，改仓库里的源即时生效（先删掉 skills 目录下的同名目录）：

```sh
# Linux / macOS
ln -s "$(pwd)/human-like-conversation" ~/.claude/skills/human-like-conversation
```

```powershell
# Windows（PowerShell，目录联接，不需要管理员权限）
New-Item -ItemType Junction -Path "$env:USERPROFILE\.claude\skills\human-like-conversation" -Target "$(pwd)\human-like-conversation"
```

目标目录默认 `~/.claude/skills`，可用环境变量 `CLAUDE_SKILLS_DIR` 覆盖。对已经用链接安装的 skill 重跑 `install.sh`，会把链接换回复制版。

## 从 GitHub 安装别的 skill

装好 install-skill 后，在任何对话里说"请帮我安装 xxx"并贴上 GitHub 链接，它会自动完成：clone、找到 skill、装进本仓库、安装到本机。详细流程见 [install-skill/SKILL.md](install-skill/SKILL.md)。

## 添加新 skill

1. 新建同名子目录，里面放 `SKILL.md`（frontmatter 带 `name` 和 `description`；只手动触发的加 `disable-model-invocation: true`），参考资料放该子目录的 `references/`。
2. 跑 `./install.sh <名字>`，并在上面的"收录"里加一行。
