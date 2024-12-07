#!/bin/sh

curl -X POST \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
        "query": "mutation { changeUserStatus(input: { emoji: \"\", message: \"\" }) { status { emoji message } } }"
      }' \
  https://api.github.com/graphql
