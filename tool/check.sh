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
flutter test --exclude-tags perf
echo "== perf (on its own, KI-045)"
flutter test --tags perf
echo "All checks passed."
