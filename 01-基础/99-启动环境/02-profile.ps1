# 配置别名
function ll {
    # 若当前环境中安装了SCOOP, 且使用scoop安装了eza命令
    $eza = Join-Path $env:SCOOP 'shims\eza.exe'
    & $eza `
        -lah `
        --group-directories-first `
        @args
}

# ===============================
# 设置提示符 Powershell7.x版本使用
#   ↓↓↓↓
# PS [FENGYEHONG-HP] Desktop $
# ===============================
function prompt {
    
    # 获取当前主机名
    $hostname = $env:COMPUTERNAME
    # 获取当前的文件夹名称
    $folder   = Split-Path (Get-Location) -Leaf

    return "PS `e[32;1m[$hostname]`e[0m `e[36;1m$folder`e[0m $ "
}

# ===========================================
# 设置提示符 Powershell5.x 和 7.x版本都可使用
#   ↓↓↓↓
# PS [FENGYEHONG-HP] Desktop $
# ===========================================
function prompt {

    # PowerShell 7 才支持的 ANSI 转义序列 (e)
    # 而 PowerShell 5.1 中需要使用 [char]27（ESC 字符）来代替
    $esc = [char]27

    $hostname = $env:COMPUTERNAME
    $folder   = Split-Path (Get-Location) -Leaf

    return "PS ${esc}[32;1m[$hostname]${esc}[0m ${esc}[36;1m$folder${esc}[0m $ "
}

<#
    每次 PowerShell 等待用户输入命令时, 都会执行 prompt
    然后
        1. 函数中所有 Write-Host 输出会立即显示。
        2. 函数返回的字符串会作为最后的提示符显示。
#>
function prompt {

    $hostname = $env:COMPUTERNAME
    $folder   = Split-Path (Get-Location) -Leaf

    # 拼接信息
    Write-Host "PS " -NoNewline
    Write-Host "[$hostname]" -ForegroundColor Green -NoNewline
    Write-Host " " -NoNewline
    Write-Host "$folder" -ForegroundColor Cyan -NoNewline
    Write-Host " " -NoNewline

    return '$ '
}