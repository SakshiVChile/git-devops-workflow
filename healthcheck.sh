#!/bin/bash
# healthcheck.sh - checks whether a URL responds with HTTP 200.
# Usage: ./healthcheck.sh [URL]

URL="${1:-https://sakshivchile.github.io/github-pages-static-website/}"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$URL")

if [ "$STATUS" = "200" ]; then
  echo "OK: $URL returned $STATUS"
  exit 0
else
  echo "FAIL: $URL returned $STATUS"
  exit 1
fi