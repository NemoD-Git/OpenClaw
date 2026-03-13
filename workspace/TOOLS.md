# TOOLS.md - Local Notes

Skills define _how_ tools work. This file is for _your_ specifics — the stuff that's unique to your setup.

## What Goes Here

Things like:

- Camera names and locations
- SSH hosts and aliases
- Preferred voices for TTS
- Speaker/room names
- Device nicknames
- Anything environment-specific

## Skills Sources (技能来源)

当需要使用技能时，我会根据任务类型从以下来源选择：

### 已配置的技能
- **本地 workspace**: `~/.openclaw/workspace/skills/`
- **官方技能**: `~/.nvm/.../openclaw/skills/`
- **ClawHub**: 通过 `clawhub install` 安装

### 可搜索的技能市场
| 来源 | 说明 | 使用方式 |
|------|------|----------|
| **ClawHub** | OpenClaw官方技能市场，5400+技能 | `clawhub install <name>` |
| **skills.sh** | Vercel Claude Code技能市场 | 手动克隆到skills目录 |
| **awesome-openclaws** | GitHub精选技能列表 | 参考: https://github.com/VoltAgent/awesome-openclaw-skills |

### 技能选择逻辑
当我需要执行任务时，会：
1. 先检查本地已安装的技能
2. 根据任务类型匹配合适的技能
3. 如需新技能，从ClawHub搜索安装

## Why Separate?

Skills are shared. Your setup is yours. Keeping them apart means you can update skills without losing your notes, and share skills without leaking your infrastructure.

---

Add whatever helps you do your job. This is your cheat sheet.
