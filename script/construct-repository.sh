#!/bin/bash
set -e

# Construct the final repository structure

echo "=== Packages directory structure ==="
find packages -type f | sort || true

echo ""
echo "=== APKIndex directory structure ==="
find apkindex -type f | sort || true

mkdir -p repository
for arch in x86_64 aarch64; do
  mkdir -p repository/$arch
  cp packages/$arch/*.apk repository/$arch/ 2>/dev/null || true
  
  if [ -f "apkindex/apkindex-$arch/APKINDEX.tar.gz" ]; then
    cp apkindex/apkindex-$arch/APKINDEX.tar.gz repository/$arch/
  else
    echo "WARNING: APKINDEX.tar.gz not found for $arch at apkindex/apkindex-$arch/APKINDEX.tar.gz"
  fi
done
cp melange.rsa.pub repository/
