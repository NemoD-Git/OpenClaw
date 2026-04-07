# OpenClaw GitHub 备份与恢复操作指南

## 📋 目录

1. [日常备份机制](#1-日常备份机制)
2. [验证备份状态](#2-验证备份状态)
3. [手动触发备份](#3-手动触发备份)
4. [从 GitHub 恢复](#4-从-github-恢复)
5. [故障排查](#5-故障排查)
6. [紧急情况处理](#6-紧急情况处理)

---

## 1. 日常备份机制

### 定时任务配置

| 任务名称 | 执行时间 | 备份内容 | 状态 |
|---------|---------|---------|------|
| GitHub备份 | 每天 23:55 | 配置文件 + workspace | ✅ 已启用 |

### 备份内容

```
~/.openclaw/
├── openclaw.json          # 主配置文件
├── config.yaml            # 配置文件
├── workspace/SOUL.md      # 灵魂配置
├── workspace/USER.md      # 用户配置
├── workspace/AGENTS.md    # Agent配置
├── workspace/TOOLS.md     # 工具配置
└── workspace/memory/*.md  # 每日记忆
```

---

## 2. 验证备份状态

### 2.1 通过 Bash 检查

```bash
# 查看所有定时任务状态
openclaw cron list

# 查看 GitHub 备份任务详情
cat ~/.openclaw/cron/jobs.json | python3 -c "
import json, sys
data = json.load(sys.stdin)
for job in data.get('jobs', []):
    if 'GitHub' in job.get('name', '') or 'backup' in job.get('name', '').lower():
        print(json.dumps(job, indent=2, ensure_ascii=False))
"

# 查看 Git 状态
cd ~/.openclaw && git status

# 查看最近一次提交
cd ~/.openclaw && git log --oneline -5
```

### 2.2 通过 PowerShell 检查

```powershell
# 查看所有定时任务状态
openclaw cron list

# 查看 Git 状态
cd ~/.openclaw; git status

# 查看最近提交
cd ~/.openclaw; git log --oneline -5
```

### 2.3 通过 Telegram 检查

发送命令给机器人：
```
/status
```

回复会显示所有定时任务状态，包括 GitHub 备份。

### 2.4 通过飞书检查

直接在飞书对话框发送：
```
/status
```

---

## 3. 手动触发备份

### 3.1 通过 Bash 手动备份

```bash
# 进入目录
cd ~/.openclaw

# 添加文件到暂存区
git add openclaw.json config.yaml workspace/SOUL.md workspace/USER.md workspace/AGENTS.md workspace/TOOLS.md workspace/memory/*.md .gitignore

# 提交（自动带时间戳）
git commit -m "Manual backup $(date '+%Y-%m-%d %H:%M')"

# 推送到 GitHub
git push origin master
```

**完整一键命令：**
```bash
cd ~/.openclaw && git add openclaw.json config.yaml workspace/SOUL.md workspace/USER.md workspace/AGENTS.md workspace/TOOLS.md workspace/memory/*.md .gitignore && git commit -m "Manual backup $(date '+%Y-%m-%d %H:%M')" && git push origin master
```

### 3.2 通过 PowerShell 手动备份

```powershell
cd ~/.openclaw
git add openclaw.json config.yaml workspace/SOUL.md workspace/USER.md workspace/AGENTS.md workspace/TOOLS.md workspace/memory/*.md .gitignore
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm"
git commit -m "Manual backup $timestamp"
git push origin master
```

### 3.3 通过 Telegram 手动触发

发送命令给机器人：
```
/cron run <任务ID>
```

任务ID可以通过 `/cron list` 获取。

### 3.4 通过飞书手动触发

在飞书发送：
```
/cron run <任务ID>
```

或发送：
```
帮我备份到 GitHub
```

---

## 4. 从 GitHub 恢复

### 4.1 通过 Bash 恢复

#### 方法一：完全恢复（覆盖本地所有文件）

```bash
# 进入目录
cd ~/.openclaw

# 先确认本地是否有未提交的更改（会被覆盖！）
git status

# 如果有未提交的更改，先stash
git stash

# 从 GitHub 拉取最新版本
git fetch origin
git reset --hard origin/master

# 查看恢复后的状态
git log --oneline -3
```

#### 方法二：仅恢复特定文件

```bash
cd ~/.openclaw

# 仅恢复配置文件
git checkout origin/master -- openclaw.json config.yaml

# 仅恢复 workspace
git checkout origin/master -- workspace/

# 仅恢复特定文件
git checkout origin/master -- workspace/SOUL.md workspace/USER.md
```

#### 方法三：查看历史版本再恢复

```bash
cd ~/.openclaw

# 查看提交历史
git log --oneline -10

# 查看某个提交的详细内容
git show abc123 --stat

# 恢复到某个特定提交
git reset --hard abc123

# 或者恢复到某个特定时间点的版本
git log --since="2026-04-01" --oneline
git reset --hard <commit-hash>
```

### 4.2 通过 PowerShell 恢复

```powershell
cd ~/.openclaw

# 查看状态
git status

# 暂存本地更改（可选）
git stash

# 完全恢复
git fetch origin
git reset --hard origin/master
```

### 4.3 通过 Telegram 恢复

⚠️ **Telegram 无法直接执行恢复操作**

需要通过其他方式（SSH/Bash）连接执行。

### 4.4 通过飞书恢复

⚠️ **飞书终端无法执行 git 恢复操作**

需要通过其他方式连接执行。

---

## 5. 故障排查

### 5.1 GitHub Token 失效

**症状：** `git push` 报错 `Authentication failed`

**解决方法：**

1. 在 GitHub 生成新的 Personal Access Token：
   - 进入 https://github.com/settings/tokens
   - 生成新 token（需要 repo 权限）
   - 复制 token

2. 更新 git remote URL：
   ```bash
   cd ~/.openclaw
   git remote set-url origin https://YOUR_NEW_TOKEN@github.com/NemoD-Git/OpenClaw.git
   ```

3. 验证连接：
   ```bash
   git fetch origin
   ```

### 5.2 定时任务未执行

**症状：** 23:55 没有备份

**排查步骤：**

1. 检查任务是否启用：
   ```bash
   openclaw cron list
   ```

2. 检查任务状态：
   ```bash
   openclaw cron runs --id <任务ID> --limit 10
   ```

3. 查看日志：
   ```bash
   openclaw logs | tail -100
   ```

**解决方法：**

1. 启用任务：
   ```bash
   openclaw cron edit <任务ID> --enable
   ```

2. 手动执行一次：
   ```bash
   openclaw cron run <任务ID> --force
   ```

### 5.3 推送失败但本地有备份

**症状：** GitHub 没有更新，但本地 commit 成功

**解决方法：**

```bash
cd ~/.openclaw

# 检查 git remote
git remote -v

# 重新设置 push URL
git remote set-url --push origin https://NemoD-Git:<YOUR_TOKEN>@github.com/NemoD-Git/OpenClaw.git

# 手动推送
git push origin master
```

### 5.4 本地文件损坏

**症状：** 配置文件损坏导致 OpenClaw 无法启动

**解决方法：**

```bash
cd ~/.openclaw

# 删除损坏的文件
rm openclaw.json

# 从 GitHub 恢复
git checkout origin/master -- openclaw.json

# 重启 OpenClaw
openclaw gateway restart
```

---

## 6. 紧急情况处理

### 6.1 OpenClaw 完全无法启动

**原因：** 配置文件严重损坏

**恢复步骤：**

1. **通过 SSH 连接到服务器**
   ```bash
   ssh user@your-server
   ```

2. **恢复配置文件**
   ```bash
   cd ~/.openclaw
   git checkout origin/master -- openclaw.json config.yaml
   ```

3. **重启 OpenClaw**
   ```bash
   openclaw gateway restart
   ```

### 6.2 GitHub 仓库被删除

**预防：** 定期在本地保留备份

**恢复步骤：**

1. **联系 GitHub 支持恢复仓库**（30天内可恢复）

2. **或者从头创建新仓库：**
   ```bash
   cd ~/.openclaw
   
   # 创建新仓库（如果在 GitHub 上手动创建了）
   git remote set-url origin https://github.com/NemoD-Git/OpenClaw.git
   
   # 推送现有代码
   git push -u origin master --force
   ```

### 6.3 需要回滚到特定版本

**场景：** 新配置导致问题，需要退回旧版本

```bash
cd ~/.openclaw

# 查看版本历史
git log --oneline -20

# 选择要回滚的版本
git reset --hard <good-commit-hash>

# 强制推送到 GitHub（谨慎操作！）
git push origin master --force
```

⚠️ **警告：** `--force` 会覆盖远程历史，请确认操作后再执行。

---

## 7. 常用命令速查

| 操作 | Bash | PowerShell | Telegram | 飞书 |
|------|------|------------|----------|------|
| 查看备份状态 | `git status` | `git status` | `/cron list` | `/cron list` |
| 手动备份 | `git add && git commit && git push` | 同左 | `/cron run <ID>` | `/cron run <ID>` |
| 查看历史 | `git log` | `git log` | ❌ | ❌ |
| 恢复文件 | `git checkout` | `git checkout` | ❌ | ❌ |
| 完全恢复 | `git reset --hard` | `git reset --hard` | ❌ | ❌ |
| 检查定时任务 | `openclaw cron list` | `openclaw cron list` | `/cron list` | `/cron list` |

---

## 8. 联系方式

- **GitHub 仓库：** https://github.com/NemoD-Git/OpenClaw
- **备份执行用户：** Nemo
- **备份远程：** origin/master

---

*文档更新时间：2026-04-07*
