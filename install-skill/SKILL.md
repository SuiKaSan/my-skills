---
name: install-skill
description: 用户说"请帮我安装 xxx"并附上 GitHub 链接时使用。把外部 skill 装进本地 skill 仓库（C:\code\my-skills）再安装到 Claude Code 的 skills 目录。
---

# 安装外部 skill

用户给出 GitHub 链接要求安装 skill 时按此流程执行。skill 仓库在 `C:\code\my-skills`（Git Bash 里是 `/c/code/my-skills`），不存在时先问用户是 clone 还是怎么处理，不要自作主张新建。

1. **clone 到临时目录**，用完删掉：
   ```sh
   git clone --depth 1 <链接> /tmp/skill-src
   ```
2. **找到 skill**：定位含 `SKILL.md` 的目录。
   - 仓库根目录就有 `SKILL.md`，用根目录。
   - 只有一个子目录含 `SKILL.md`，用那个子目录。
   - 多个子目录都含 `SKILL.md`，列出来让用户挑，用户点名了除外。
   - 没有 `SKILL.md`，不是 skill 仓库，如实说明并停，不要硬装。
3. **复制进仓库**：目标目录名用 frontmatter 里的 `name`，没有就问。同名目录已存在时问覆盖还是跳过。`SKILL.md`、`references/`、LICENSE、README 一起复制；`.git` 和源仓库里与 skill 无关的文件不进。
4. **安装到本机**：在仓库里跑 `./install.sh <名字>`（复制安装），或按仓库 README 的方式建目录联接（Windows）／软链接（Unix），改源即时生效。
5. **登记**：在仓库 README 的"收录"里加一行说明，git 提交（中文消息，不加 AI 署名）。
6. **报告**：装了什么、装到哪、怎么调用。提醒用户新开对话验证 skill 已被识别。
