#!/bin/bash
# OpenClaw 安全回滚脚本
# 用法: ./rollback.sh 或 ./rollback.sh 备份文件名

BACKUP_DIR="$HOME/.openclaw/backup"
CONFIG_FILE="$HOME/.openclaw/openclaw.json"

mkdir -p "$BACKUP_DIR"

if [ -z "$1" ]; then
    # 无参数：列出所有备份
    echo "=== 可用的备份 ==="
    ls -lt "$BACKUP_DIR"/openclaw_*.json 2>/dev/null | head -10
    echo ""
    echo "用法: $0 [备份文件名]"
    echo "示例: $0 openclaw_20260319_120000.json"
    exit 0
fi

BACKUP_FILE="$BACKUP_DIR/$1"
if [ ! -f "$BACKUP_FILE" ]; then
    echo "错误: 找不到备份文件 $BACKUP_FILE"
    exit 1
fi

# 备份当前配置（万一还能救）
cp "$CONFIG_FILE" "$BACKUP_DIR/emergency_$(date +%Y%m%d_%H%M%S).json"

# 恢复指定备份
cp "$BACKUP_FILE" "$CONFIG_FILE"
echo "✅ 已恢复到: $BACKUP_FILE"

# 重启Gateway
echo "正在重启Gateway..."
pkill -f openclaw-gateway 2>/dev/null
sleep 3
nohup openclaw gateway > /dev/null 2>&1 &
sleep 5

# 验证
STATUS=$(python3 -c "import json; c=json.load(open('$CONFIG_FILE')); print(c.get('agents',{}).get('defaults',{}).get('model','未设置'))" 2>/dev/null)
echo "✅ Gateway已重启，当前模型: $STATUS"
