#!/bin/bash
# 模型版本守护脚本
# 持续监控配置文件，被覆盖后立即修复
TARGET="minimax-portal/MiniMax-M2.7-highspeed"
CONFIG="$HOME/.openclaw/openclaw.json"

while true; do
    CURRENT=$(python3 -c "import json; c=json.load(open('$CONFIG')); print(c.get('agents',{}).get('defaults',{}).get('model',''))" 2>/dev/null)
    if [ "$CURRENT" != "$TARGET" ]; then
        echo "[$(date '+%H:%M:%S')] 修复模型: $CURRENT -> $TARGET"
        openclaw config set agents.defaults.model "$TARGET" 2>/dev/null | grep -v "^\[" | grep -v "^$"
    fi
    sleep 60
done
