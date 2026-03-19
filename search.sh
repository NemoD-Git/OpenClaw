#!/bin/bash
# 优先使用 Tavily，备用 Brave Search

QUERY="$1"
TAVILY_KEY="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"

# 尝试 Tavily
result=$(curl -s -X POST "https://api.tavily.com/search" \
  -H "Content-Type: application/json" \
  -d "{
    \"api_key\": \"$TAVILY_KEY\",
    \"query\": \"$QUERY\",
    \"search_depth\": \"basic\",
    \"max_results\": 10,
    \"language\": \"zh\"
  }" 2>/dev/null)

# 检查 Tavily 结果
count=$(echo "$result" | python3 -c "import json,sys; d=json.load(sys.stdin); print(len(d.get('results',[])))" 2>/dev/null)

if [ "$count" -gt 0 ]; then
    echo "$result" | python3 -c "
import json, sys
d = json.load(sys.stdin)
results = d.get('results', [])
print(f'=== Tavily 搜索结果 ({len(results)} 条) ===\n')
for i, r in enumerate(results, 1):
    print(f'{i}. {r.get(\"title\", \"N/A\")}')
    print(f'   {r.get(\"url\", \"\")}')
    print(f'   {r.get(\"content\", \"\")[:200]}')
    print()
"
else
    echo "Tavily 失败，使用 Brave Search..."
    openclaw web-search --query "$QUERY" --count 10 2>/dev/null || \
    curl -s "https://api.search.brave.com/res/v1/web/search?q=$(echo "$QUERY" | sed 's/ /+/g')" \
      -H "X-Subscription-Token: $BRAVE_API_KEY" 2>/dev/null | head -100
fi
