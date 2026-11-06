# Build BrowSDR and publish static assets into .\live_sdr_vendor\
# Script lives at the repository root.
Param(
  [string]$RepoUrl = "https://github.com/jLynx/BrowSDR.git",
  [string]$Branch = "main"
)
$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$WorkDir = Join-Path $env:TEMP "browsdr_build_scanqc"
$OutDir = Join-Path $RepoRoot "live_sdr_vendor"

foreach ($cmd in @("git", "npm", "cargo")) {
  if (-not (Get-Command $cmd -ErrorAction SilentlyContinue)) {
    throw "$cmd is required"
  }
}

if (Test-Path $WorkDir) { Remove-Item $WorkDir -Recurse -Force }
New-Item -ItemType Directory -Path $WorkDir | Out-Null
Push-Location $WorkDir
try {
  git clone --depth 1 --branch $Branch $RepoUrl browsdr
  Set-Location (Join-Path $WorkDir "browsdr")
  npm install
  if (Test-Path "hackrf-web") {
    Push-Location "hackrf-web"
    cargo make build
    Pop-Location
  }
  npm run build
  if (-not (Test-Path "dist")) { throw "Build failed: dist/ not found" }
  if (Test-Path $OutDir) { Remove-Item $OutDir -Recurse -Force }
  New-Item -ItemType Directory -Path $OutDir | Out-Null
  Copy-Item ".\dist\*" $OutDir -Recurse -Force
  Write-Host "Done. BrowSDR published to $OutDir"
  Write-Host "Open live_sdr.html — it will prefer live_sdr_vendor/ when present."
}
finally {
  Pop-Location
}
