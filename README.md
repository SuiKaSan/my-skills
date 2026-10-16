# my-skills

个人的 AI 助手 skill 集合。每个子目录是一个 skill，`SKILL.md` 是入口。

## 收录

| Skill | 用途 |
|---|---|
| [human-like-conversation](human-like-conversation/) | 对话全程的表达与保真准则：直接说内容、照实说、不用套话句式。新对话开始时 `/human-like-conversation` 调用一次，全程生效 |
| [install-skill](install-skill/) | 在任何对话里说"请帮我安装 xxx"并附上 GitHub 链接，自动 clone、安装到本机，本地有集合仓库时顺便收编 |

## 安装

三种方式，都不需要先 clone 本仓库。

### 对话式（最省事）

直接对 Claude Code 说（链接换成实际地址）：

> 请帮我安装 install-skill：https://github.com/SuiKaSan/my-skills

装过一次后，以后装任何 GitHub 上的 skill 都只要一句"请帮我安装 xxx"+ 链接。

### Plugin marketplace（Claude Code 官方入口）

```
/plugin marketplace add SuiKaSan/my-skills
/plugin install human-like-conversation@my-skills
/plugin install install-skill@my-skills
```

### clone 后用安装脚本（要改源或想统一管理）

```sh
git clone https://github.com/SuiKaSan/my-skills.git
cd my-skills
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

`./install.sh` 是复制安装，目标目录默认 `~/.claude/skills`（环境变量 `CLAUDE_SKILLS_DIR` 覆盖）。对已经用链接安装的 skill 重跑，会把链接换回复制版。

## 从 GitHub 安装别的 skill

装好 install-skill 后，在任何对话里说"请帮我安装 xxx"并贴上 GitHub 链接即可。详细流程见 [install-skill/SKILL.md](install-skill/SKILL.md)。

## 添加新 skill

1. 新建同名子目录，里面放 `SKILL.md`（frontmatter 带 `name` 和 `description`；只手动触发的加 `disable-model-invocation: true`），参考资料放该子目录的 `references/`。
2. 跑 `./install.sh <名字>`，并在上面的"收录"里加一行。
