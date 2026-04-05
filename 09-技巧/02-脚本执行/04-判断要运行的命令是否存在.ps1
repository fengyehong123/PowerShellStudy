# 有python已经安装到环境中, 所以并不会进入此分支
if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host "python命令并不存在"
}

if (-not (Get-Command Hello_Test -ErrorAction SilentlyContinue)) {
    Write-Host "Hello_Test命令并不存在"  # Hello_Test命令并不存在
}