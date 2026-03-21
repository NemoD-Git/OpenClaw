#!/bin/bash
# OpenClaw 改配置前备份脚本
# 用法: ./pre-change-backup.sh [备注]
# 示例: ./pre-change-backup.sh "尝试改成2.7"

BACKUP_DIR="$HOME/.openclaw/backup"
CONFIG_FILE="$HOME/.openclaw/openclaw.json"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
NOTE="${1:-无备注}"

mkdir -p "$BACKUP_DIR"

# 创建带时间戳的备份
BACKUP_FILE="$BACKUP_DIR/openclaw_${TIMESTAMP}.json"
cp "$CONFIG_FILE" "$BACKUP_FILE"

# 记录版本信息
echo "[$TIMESTAMP] $NOTE" >> "$BACKUP_DIR/版本记录.txt"

echo "✅ 备份已创建: $BACKUP_FILE"
echo "   备注: $NOTE"
echo ""
echo "现在可以安全地改配置了"
