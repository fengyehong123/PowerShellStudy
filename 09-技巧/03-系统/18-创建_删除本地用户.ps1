# 新建一个普通用户
function New-NormalUser {
    
    param(
        # 用户名
        [Parameter(Mandatory=$true)]
        [string]$Name,
        # 密码
        [Parameter(Mandatory=$true)]
        [string]$Passwd,
        # 用户描述
        [string]$Description = "普通用户账户"
    )

    try {

        # 检查用户是否已存在
        if (Get-LocalUser -Name $Name -ErrorAction SilentlyContinue) {
            Write-Warning "用户 [$Name] 已经存在！"
            return
        }

        # 普通明文字符串转换成安全字符串
        $securePassword = ConvertTo-SecureString $Passwd -AsPlainText -Force

        # 创建用户, 添加密码和用户描述
        New-LocalUser -Name $Name -Password $securePassword -FullName $Name -Description $Description
        # 将用户添加到【Users】组
        Add-LocalGroupMember -Group "Users" -Member $Name

        Write-Host "用户 [$Name] 已成功创建，并加入 Users 组。" -ForegroundColor Green
    }
    catch {
        Write-Error "创建用户时出错: $_"
    }
}

# 例子：新建一个普通用户
# New-NormalUser -Name "testuser" -Passwd "diannao123"

# 删除普通用户
function Remove-NormalUser {

    param(
        [Parameter(Mandatory=$true)]
        [string]$Name,
        [switch]$RemoveProfileFlg
    )

    try {

        # 检查用户是否存在
        $user = Get-LocalUser -Name $Name -ErrorAction SilentlyContinue
        if (-not $user) {
            Write-Warning "用户 [$Name] 不存在！"
            return
        }

        # 删除用户账户
        Remove-LocalUser -Name $Name
        Write-Host "用户 [$Name] 已被删除。" -ForegroundColor Green

        # 如果没有指定 -RemoveProfileFlg，则不会去尝试删除用户目录
        if (-not $RemoveProfileFlg) {
            return
        }
        
        # 如果当前用户没有用户目录的话
        $profilePath = Join-Path "C:\Users" $Name
        if (-not (Test-Path $profilePath)) {
            return
        }
        
        # 删除当前用户的个人目录
        Remove-Item -Path $profilePath -Recurse -Force
        Write-Host "用户 [$Name] 的个人目录 [$profilePath] 已删除。" -ForegroundColor Yellow

        # 删除当前用户的注册表信息
        Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList" | `
        Where-Object { (Get-ItemProperty $_.PsPath).ProfileImagePath -like "*\$Name" } | `
        Remove-Item -Recurse -Force
    }
    catch {
        Write-Error "删除用户时出错: $_"
    }
}

