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
# 设置提示符
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