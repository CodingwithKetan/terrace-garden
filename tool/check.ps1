# Runs the quality gate (docs/quality/testing-strategy.md). Stops at the first
# failure. Usage: powershell -File tool/check.ps1
$ErrorActionPreference = 'Stop'
Set-Location (Join-Path $PSScriptRoot '..')

function Invoke-Step([string]$name, [scriptblock]$command) {
  Write-Host "== $name"
  & $command
  if ($LASTEXITCODE -ne 0) { throw "$name failed (exit $LASTEXITCODE)" }
}

Invoke-Step 'codegen' { dart run build_runner build -d }
Invoke-Step 'format' { dart format --output=none --set-exit-if-changed . }
Invoke-Step 'analyze' { flutter analyze }
Invoke-Step 'test' { flutter test }
Write-Host 'All checks passed.'
