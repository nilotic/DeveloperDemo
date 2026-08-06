#!/bin/bash
# 앱 소스 전체를 타입체크한다 (xcodeproj 빌드 없이 빠르게 반복하기 위한 용도).
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SDK="$(xcrun --sdk iphonesimulator --show-sdk-path)"
OUT="$ROOT/.build"
TARGET="arm64-apple-ios17.0-simulator"

mkdir -p "$OUT"
find "$ROOT/DeveloperDemo" -name "*.swift" -type f | sort > "$OUT/files.txt"
echo "== $(wc -l < "$OUT/files.txt" | tr -d ' ') files =="

xcrun swiftc -typecheck \
    -sdk "$SDK" -target "$TARGET" \
    -swift-version 5 -D DEBUG \
    @"$OUT/files.txt" 2>&1
