Param([string]$RepoUrl = "https://github.com/jLynx/BrowSDR.git",[string]$Branch = "main")
$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot = Resolve-Path (Join-Path $ScriptDir "..")
$WorkDir = Join-Path $env:TEMP "browsdr_build_scanqc"
$OutDir = Join-Path $RepoRoot "live_sdr_vendor"
if (Test-Path $WorkDir) { Remove-Item $WorkDir -Recurse -Force }
New-Item -ItemType Directory -Path $WorkDir | Out-Null
Push-Location $WorkDir
git clone --branch $Branch $RepoUrl browsdr
Set-Location (Join-Path $WorkDir "browsdr")
npm install
Push-Location "hackrf-web"
cargo make build
Pop-Location
npm run build
if (Test-Path $OutDir) { Remove-Item $OutDir -Recurse -Force }
New-Item -ItemType Directory -Path $OutDir | Out-Null
Copy-Item ".\\dist\\*" $OutDir -Recurse -Force
Pop-Location
Write-Host "Done. BrowSDR published to $OutDir"
