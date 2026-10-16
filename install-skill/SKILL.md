---
name: install-skill
description: 用户说"请帮我安装 xxx"并附上 GitHub 链接，或说"请帮我更新 skill 到最新版"时使用。安装：clone 该仓库、找到 skill、装到 Claude Code 的 skills 目录；更新：按版本号比对 GitHub latest release，落后的重装。
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
   - 有集合仓库：把 skill 目录复制进仓库（`SKILL.md`、`VERSION`、`references/`、LICENSE、README 一起；`.git` 和源仓库里与 skill 无关的文件不进），再从仓库位置链接安装，改源即时生效：
     - Windows：删掉 `~/.claude/skills/<名字>` 后 `powershell -NoProfile -Command "New-Item -ItemType Junction -Path '<skills目录>\<名字>' -Target '<仓库路径>\<名字>'"`
     - Linux / macOS：`ln -s <仓库路径>/<名字> ~/.claude/skills/<名字>`
   - 没有集合仓库：直接复制到 `~/.claude/skills`（可用环境变量 `CLAUDE_SKILLS_DIR` 覆盖）。
5. **登记**（有集合仓库时）：在仓库 README 的"收录"里加一行说明，git 提交（中文消息，不加 AI 署名）。
6. **报告**：装了什么、装到哪、怎么调用。提醒用户新开对话验证 skill 已被识别。

# 更新已装的 skill

用户要求把 skill 更新到最新版时执行。只管本仓库（SuiKaSan/my-skills）的 skill；外部 skill 没有版本来源，重新给一次链接走安装流程即可。

1. **找本地集合仓库**（顺序同上）。
   - 有：在仓库里 `git pull`（工作区不干净就如实报告，让用户决定，不要强拉）。链接安装的 skill 到此已是最新，接着报告版本（仓库里各 skill 的 `VERSION` 文件）。
   - 没有：跳到第 2 步。
2. **对复制安装的 skill 逐个比对版本**：
   - 最新版查 `curl -s https://api.github.com/repos/SuiKaSan/my-skills/releases/latest` 里的 `tag_name`（公开仓库直接查；私有或限流时用 `git credential fill` 里的 token 加 `Authorization` 头）。
   - 本地版本读 `~/.claude/skills/<名字>/VERSION`。没有 `VERSION` 就视为版本未知，问用户要不要直接重装最新。
3. **落后的按上面的安装流程重装**（clone 的是默认分支最新内容，`VERSION` 随源一起更新）；已是最新就不动。
4. **plugin 方式装的**（装在 plugin 目录，不在 `~/.claude/skills`）由 `/plugin` 系统管理，提示用户在 plugin 界面更新。
5. **报告**：每个 skill 的本地版本、最新版本、做了什么（拉取／重装／无需更新）。
