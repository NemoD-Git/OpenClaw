#!/bin/bash
# 自动修复 cron delivery 配置

BACKUP_FILE="$HOME/.openclaw/cron/jobs_backup.json"
TARGET_FILE="$HOME/.openclaw/cron/jobs.json"

if [ ! -f "$BACKUP_FILE" ]; then
    echo "No backup file found"
    exit 1
fi

# 比较备份和当前文件的 delivery 配置
backup_count=$(python3 -c "
import json
with open('$BACKUP_FILE') as f:
    data = json.load(f)
count = 0
for job in data['jobs']:
    delivery = job.get('delivery', {})
    if isinstance(delivery, list) and any(d.get('channel') for d in delivery):
        count += 1
print(count)
")

current_count=$(python3 -c "
import json
with open('$TARGET_FILE') as f:
    data = json.load(f)
count = 0
for job in data['jobs']:
    delivery = job.get('delivery', {})
    if isinstance(delivery, list) and any(d.get('channel') for d in delivery):
        count += 1
print(count)
")

if [ "$backup_count" != "$current_count" ]; then
    echo "Fixing delivery config: $current_count -> $backup_count"
    cp "$BACKUP_FILE" "$TARGET_FILE"
    # Restart gateway to reload config
    openclaw gateway restart 2>/dev/null || true
else
    echo "Delivery config OK ($backup_count jobs with proper delivery)"
fi
