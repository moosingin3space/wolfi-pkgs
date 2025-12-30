#!/bin/bash
set -e

# Generate JSON arrays for packages and tests

packages=$(ls melange/*.yaml | sed 's|melange/||g' | sed 's|\.yaml||g' | jq -R -s -c 'split("\n")[:-1]')
tests=$(ls tests/*.Dockerfile | sed 's|tests/||g' | sed 's|\.Dockerfile||g' | jq -R -s -c 'split("\n")[:-1]')

echo "packages=$packages" >> "$GITHUB_OUTPUT"
echo "tests=$tests" >> "$GITHUB_OUTPUT"
