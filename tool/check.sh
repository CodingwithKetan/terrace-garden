#!/usr/bin/env bash
# Runs the quality gate (docs/quality/testing-strategy.md). Exits non-zero on
# the first failure. Usage: tool/check.sh
set -euo pipefail
cd "$(dirname "$0")/.."

echo "== codegen"
dart run build_runner build -d
echo "== format"
dart format --output=none --set-exit-if-changed .
echo "== analyze"
flutter analyze
echo "== test"
flutter test
echo "All checks passed."
