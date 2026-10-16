---
name: install-skill
description: 用户说"请帮我安装 xxx"并附上 GitHub 链接时使用。clone 该仓库、找到 skill、安装到 Claude Code 的 skills 目录；本地有 skill 集合仓库时顺便收编管理。
---

# 安装外部 skill

用户给出 GitHub 链接要求安装 skill 时按此流程执行，不需要预先拉取任何仓库。

1. **clone 到临时目录**，用完删掉：
   ```sh
   git clone --depth 1 <链接> /tmp/skill-src
   ```
2. **找到 skill**：定位含 `SKILL.md` 的目录。
   - 仓库根目录就有 `SKILL.md`，用根目录。
   - 只有一个子目录含 `SKILL.md`，用那个子目录。
   - 多个子目录都含 `SKILL.md`，列出来让用户挑，用户点名了除外。
   - 没有 `SKILL.md`，不是 skill 仓库，如实说明并停，不要硬装。
3. **看本地有没有 skill 集合仓库**，按顺序找：环境变量 `MY_SKILLS_REPO`；`C:\code\my-skills`（Git Bash 里是 `/c/code/my-skills`）；`~/code/my-skills`。都找不到就当作没有。
4. **安装**。skill 的名字用 frontmatter 里的 `name`，没有就问。`~/.claude/skills` 下已有同名目录时，问覆盖还是跳过。
   - 有集合仓库：把 skill 目录复制进仓库（`SKILL.md`、`references/`、LICENSE、README 一起；`.git` 和源仓库里与 skill 无关的文件不进），再从仓库位置链接安装，改源即时生效：
     - Windows：删掉 `~/.claude/skills/<名字>` 后 `powershell -NoProfile -Command "New-Item -ItemType Junction -Path '<skills目录>\<名字>' -Target '<仓库路径>\<名字>'"`
     - Linux / macOS：`ln -s <仓库路径>/<名字> ~/.claude/skills/<名字>`
   - 没有集合仓库：直接复制到 `~/.claude/skills`（可用环境变量 `CLAUDE_SKILLS_DIR` 覆盖）。
5. **登记**（有集合仓库时）：在仓库 README 的"收录"里加一行说明，git 提交（中文消息，不加 AI 署名）。
6. **报告**：装了什么、装到哪、怎么调用。提醒用户新开对话验证 skill 已被识别。
