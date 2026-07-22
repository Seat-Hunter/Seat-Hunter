# Seat-Hunter-front 실행 스크립트
Set-Location (Join-Path $PSScriptRoot "frontend")

if (-not (Test-Path "package.json")) {
    Write-Error "frontend/package.json 을 찾을 수 없습니다."
    exit 1
}

if (-not (Test-Path "node_modules")) {
    Write-Host "node_modules 없음 -> npm install 실행"
    npm install
}

Write-Host "Frontend: http://localhost:5173"
Write-Host "Backend 가 필요하면 Seat-Hunter-back 에서 .\run.ps1 실행"
Write-Host ""

npm run dev
