#!/bin/bash
# OpenClaw 会话清理脚本
# 删除过期的会话文件，释放磁盘空间

SESSIONS_DIR="$HOME/.openclaw/agents/main/sessions"
LOG_FILE="/tmp/openclaw-cleanup.log"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# 清理7天前的会话文件
MAX_AGE=7

log "=== 开始会话清理 ==="
BEFORE=$(df -h / | tail -1 | awk '{print $4}')

# 找到并删除旧会话（保留sessions.json）
find "$SESSIONS_DIR" -name "*.jsonl" -mtime +$MAX_AGE -type f 2>/dev/null | while read f; do
    SIZE=$(du -h "$f" | cut -f1)
    rm -f "$f" 2>/dev/null
    log "已删除: $f ($SIZE)"
done

# 清理deleted文件
find "$SESSIONS_DIR" -name "*.deleted*" -mtime +1 -type f 2>/dev/null | while read f; do
    rm -f "$f" 2>/dev/null
    log "已删除临时文件: $f"
done

AFTER=$(df -h / | tail -1 | awk '{print $4}')
log "磁盘空间: $BEFORE -> $AFTER"
log "=== 清理完成 ==="

echo "✅ 清理完成: $BEFORE -> $AFTER"
