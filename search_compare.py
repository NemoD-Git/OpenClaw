#!/usr/bin/env python3
import sys
import json
import subprocess
import argparse

TAVILY_KEY = "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"

def search_tavily(query, max_results=5):
    import urllib.request
    data = json.dumps({
        "api_key": TAVILY_KEY,
        "query": query,
        "search_depth": "basic",
        "max_results": max_results
    }).encode()
    
    req = urllib.request.Request(
        "https://api.tavily.com/search",
        data=data,
        headers={"Content-Type": "application/json"}
    )
    
    with urllib.request.urlopen(req) as resp:
        return json.loads(resp.read())

def main():
    parser = argparse.ArgumentParser(description="Search using Tavily")
    parser.add_argument("query", nargs="+")
    parser.add_argument("--max", type=int, default=5)
    args = parser.parse_args()
    
    query = " ".join(args.query)
    results = search_tavily(query, args.max)
    
    print(f"\n=== Tavily 搜索结果 ({len(results.get('results',[]))} 条) ===\n")
    for i, r in enumerate(results.get('results', []), 1):
        print(f"{i}. {r.get('title', 'N/A')}")
        print(f"   {r.get('url', '')}")
        print(f"   {r.get('content', '')[:200]}...")
        print()

if __name__ == "__main__":
    main()
