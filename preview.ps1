$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$localHugo = Join-Path $root ".tools\hugo\hugo.exe"
$cacheDir = Join-Path $root ".hugo_cache"

if (-not (Test-Path $localHugo)) {
  Write-Host "Local Hugo binary not found at $localHugo" -ForegroundColor Red
  Write-Host "Please make sure .tools\\hugo\\hugo.exe exists first." -ForegroundColor Yellow
  exit 1
}

Set-Location $root
New-Item -ItemType Directory -Force -Path $cacheDir | Out-Null

Write-Host "Starting Hugo server at http://127.0.0.1:1313/" -ForegroundColor Green
Write-Host "Press Ctrl+C to stop." -ForegroundColor DarkGray

& $localHugo server --bind 127.0.0.1 --port 1313 --baseURL http://127.0.0.1:1313/ --cacheDir $cacheDir --disableFastRender
