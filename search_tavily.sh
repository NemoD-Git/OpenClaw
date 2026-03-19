#!/bin/bash
# 使用 Tavily 搜索

QUERY="$1"
DEPTH="${2:-basic}"
MAX="${3:-5}"

curl -s -X POST "https://api.tavily.com/search" \
  -H "Content-Type: application/json" \
  -d "{
    \"api_key\": \"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\",
    \"query\": \"$QUERY\",
    \"search_depth\": \"$DEPTH\",
    \"max_results\": $MAX
  }"
