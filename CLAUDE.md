# 仓库说明

个人 skill 集合，每个 skill 一个同名子目录，`SKILL.md` 是唯一入口。

## 语言与文风

- 中文优先：README、说明、提交信息默认简体中文；代码、文件路径、命令名、API 名和约定俗成的技术术语保持原文。
- 文风直接、具体、低套路，不带翻译腔。

## 结构约定

- 仓库只放 skill 源文件：`SKILL.md`、`references/`、安装脚本和说明。评测工作区、草稿、临时产物不进仓库。
- 改动装到本机走 `install.sh`，或按 README 的链接方式；改源不会自动生效到已复制的安装。
- 从 GitHub 安装外部 skill 的流程以 `install-skill/SKILL.md` 为准，不在别处重复。

## 协作

- 提交一律以仓库所有者名义，不加 AI 署名行（不写 `Co-Authored-By`），这是既定约定。
- 发版流程：更新 `.claude-plugin/marketplace.json` 里的 `version`，提交后打 tag（`v0.1.0` 风格）并推送，再在 GitHub 上发 Release，用中文写本版变化。
