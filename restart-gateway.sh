#!/bin/bash
# 1. 设置正确模型
openclaw config set agents.defaults.model "minimax-portal/MiniMax-M2.7-highspeed" 2>/dev/null | grep -v "^\[" | grep -v "^$"
# 2. 解锁文件
chmod 644 ~/.openclaw/openclaw.json
# 3. Kill旧进程
pkill -f openclaw-gateway 2>/dev/null
sleep 2
# 4. 锁文件（防止后续覆盖）
chmod 444 ~/.openclaw/openclaw.json
# 5. 启动
nohup openclaw gateway > /dev/null 2>&1 &
sleep 3
echo "Gateway已重启，当前模型:"
python3 -c "import json; c=json.load(open('$HOME/.openclaw/openclaw.json')); print(c.get('agents',{}).get('defaults',{}).get('model',''))"
