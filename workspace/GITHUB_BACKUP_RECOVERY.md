# OpenClaw 故障恢复指南（WSL2 专用）

## 场景一：OpenClaw 无法启动

### 第一步：检查 Gateway 状态

在 WSL 终端执行：

```bash
openclaw gateway status
```

**期望结果：**
```
✅ Gateway is running (PID: xxxxx)
   Uptime: 2 hours
   Version: 2026.4.2
```

**如果显示 stopped：**
```bash
openclaw gateway start
```

---

### 第二步：检查日志

```bash
openclaw logs --tail 50
```

**期望结果：** 看到正常运行的日志输出

**如果看到报错信息：** 记下错误内容，常见问题：
- `port already in use` → 端口被占用
- `config error` → 配置文件格式错误
- `permission denied` → 权限问题

---

### 第三步：重启 Gateway

```bash
openclaw gateway restart
```

等待 10 秒后检查：
```bash
openclaw gateway status
```

---

### 第四步：检查端口监听

```bash
curl http://localhost:18789/health 2>/dev/null || echo "Port not responding"
```

**期望结果：** 返回 `{"status":"ok"}` 或类似健康信息

---

## 场景二：配置文件损坏导致无法启动

### 第一步：确认问题

```bash
openclaw gateway status
```

如果 status 显示 running 但无法连接，先重启：
```bash
openclaw gateway restart
```

如果完全启动不了，查看错误：
```bash
openclaw gateway start 2>&1
```

---

### 第二步：从 GitHub 恢复配置文件

**操作前先备份当前文件：**
```bash
cd ~/.openclaw
cp openclaw.json openclaw.json.broken.$(date +%Y%m%d)
```

**从 GitHub 拉取最新版本：**
```bash
cd ~/.openclaw
git fetch origin
git reset --hard origin/master
```

**期望结果：**
```
HEAD is now at xxxxxx Auto backup yyyy-mm-dd HH:MM
```

---

### 第三步：重启验证

```bash
openclaw gateway restart
openclaw gateway status
```

---

## 场景三：只想恢复特定配置文件

### 只恢复 openclaw.json

```bash
cd ~/.openclaw
git checkout origin/master -- openclaw.json
openclaw gateway restart
```

### 只恢复 config.yaml

```bash
cd ~/.openclaw
git checkout origin/master -- config.yaml
openclaw gateway restart
```

### 只恢复 workspace 配置

```bash
cd ~/.openclaw
git checkout origin/master -- workspace/SOUL.md workspace/USER.md workspace/AGENTS.md
```

---

## 场景四：查看 GitHub 上的历史版本

### 查看提交历史

```bash
cd ~/.openclaw
git log --oneline -10
```

**期望结果：**
```
a1b2c3d Auto backup 2026-04-07 23:55
e5f6g7h Auto backup 2026-04-06 23:55
i9j0k1l Auto backup 2026-04-05 23:55
...
```

### 查看某个版本的详细内容

```bash
git show abc123 --stat
```

### 恢复到指定版本

```bash
git reset --hard abc123
openclaw gateway restart
```

---

## 场景五：需要回滚（撤销错误的本地更改）

### 查看当前有哪些更改

```bash
cd ~/.openclaw
git status
```

**期望结果：**
```
On branch master
nothing to commit, working tree clean
```

**如果有未提交的更改：**
```bash
# 查看具体改了哪些文件
git diff --stat

# 丢弃所有本地更改，恢复到 GitHub 版本
git checkout -- .
git checkout origin/master
```

---

## 常用命令速查

| 操作 | 命令 |
|------|------|
| 查看 Gateway 状态 | `openclaw gateway status` |
| 启动 Gateway | `openclaw gateway start` |
| 停止 Gateway | `openclaw gateway stop` |
| 重启 Gateway | `openclaw gateway restart` |
| 查看日志 | `openclaw logs --tail 50` |
| 检查健康状态 | `curl http://localhost:18789/health` |
| 从 GitHub 完全恢复 | `git reset --hard origin/master` |
| 查看 Git 历史 | `git log --oneline -10` |
| 恢复到某版本 | `git reset --hard <commit-hash>` |
| 恢复单个文件 | `git checkout origin/master -- <文件>` |

---

## 注意事项

1. **每次操作前先备份**：`cp openclaw.json openclaw.json.bak.$(date +%Y%m%d)`

2. **恢复后必须重启**：`openclaw gateway restart`

3. **如果 Token 失效**：推送时报 `Authentication failed`，需要更新 GitHub Token

4. **GitHub 仓库地址**：`https://github.com/NemoD-Git/OpenClaw.git`

5. **备份频率**：每天 23:55 自动备份，如需立即备份执行：
   ```bash
   cd ~/.openclaw && git add openclaw.json config.yaml workspace/*.md workspace/memory/*.md && git commit -m "Manual backup" && git push origin master
   ```

---

*文档更新时间：2026-04-07*
