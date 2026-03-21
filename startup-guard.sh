#!/bin/bash
# OpenClaw Gateway 启动守护脚本
# 防止重复启动，确保只有一个Gateway实例运行

GATEWAY_PORT=18789
LOG_FILE="/tmp/openclaw-startup-guard.log"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# 检查Gateway进程数量
GATEWAY_PIDS=$(pgrep -f "openclaw-gateway" 2>/dev/null | wc -l)
log "检查Gateway进程数量: $GATEWAY_PIDS"

if [ "$GATEWAY_PIDS" -gt 1 ]; then
    log "⚠️ 检测到多个Gateway实例，正在清理..."
    pkill -f "openclaw-gateway" 2>/dev/null
    sleep 3
    log "已杀掉所有Gateway进程"
elif [ "$GATEWAY_PIDS" -eq 1 ]; then
    GATEWAY_PID=$(pgrep -f "openclaw-gateway" | head -1)
    # 检查进程是否真的在运行
    if kill -0 "$GATEWAY_PID" 2>/dev/null; then
        log "✅ Gateway运行正常 (PID: $GATEWAY_PID)，无需启动"
        exit 0
    else
        log "⚠️ Gateway进程存在但不响应，正在重启..."
        pkill -f "openclaw-gateway" 2>/dev/null
        sleep 2
    fi
fi

# 清理僵尸进程
pkill -9 -f "openclaw-gateway" 2>/dev/null
sleep 2

# 启动Gateway
log "🚀 启动Gateway..."
nohup openclaw gateway > /dev/null 2>&1 &
sleep 5

# 验证
NEW_PID=$(pgrep -f "openclaw-gateway" 2>/dev/null | head -1)
if [ -n "$NEW_PID" ]; then
    log "✅ Gateway已启动 (PID: $NEW_PID)"
    echo "✅ Gateway已启动 (PID: $NEW_PID)"
else
    log "❌ Gateway启动失败"
    echo "❌ Gateway启动失败"
fi
