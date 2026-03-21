#!/bin/bash
# 模型配置守护脚本
# 确保模型始终为 M2.7-highspeed
TARGET_MODEL="minimax-portal/MiniMax-M2.7-highspeed"
CONFIG_FILE="$HOME/.openclaw/openclaw.json"
INTERVAL=30  # 每30秒检查一次

echo "[model-watchdog] 启动，目标模型: $TARGET_MODEL"
echo "[model-watchdog] PID: $$"

while true; do
    CURRENT=$(python3 -c "import json; c=json.load(open('$CONFIG_FILE')); print(c.get('agents',{}).get('defaults',{}).get('model',''))" 2>/dev/null)
    
    if [ "$CURRENT" != "$TARGET_MODEL" ]; then
        echo "[$(date '+%H:%M:%S')] 配置被覆盖！修复中: $CURRENT -> $TARGET_MODEL"
        openclaw config set agents.defaults.model "$TARGET_MODEL" 2>/dev/null | grep -v "^\[" | grep -v "^$"
        chmod 444 "$CONFIG_FILE" 2>/dev/null
    fi
    
    sleep $INTERVAL
done
