param(
    [string]$originalScriptFolderPath
)

# 校验当前用户是否有管理员权限
function Test-IsAdmin {
    $id = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object System.Security.Principal.WindowsPrincipal($id)
    if ($principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) {
        return $true
    }
    return $false
}

# 若没有管理员权限
if (-not (Test-IsAdmin)) {

    Write-Host "未检测到管理员权限，正在尝试重新启动为管理员模式..." -ForegroundColor Yellow
    # 暂停1秒钟, 显示文字
    Start-Sleep -Seconds 1

    # 以管理员方式启动当前脚本
    Start-Process -FilePath "powershell.exe" `
                  -ArgumentList "-NoProfile -ExecutionPolicy RemoteSigned -File $($PSCommandPath) -originalScriptFolderPath $($PSScriptRoot)" `
                  -Verb RunAs
    # 退出当前脚本, 防止打开多个窗口
    exit
}

Write-Host "已成功以管理员权限运行PowerShell ...`n" -ForegroundColor Green

# 当以管理员权限运行脚本的时候, 作业目录默认会移动到【C:\WINDOWS\system32】下
# 我们手动将作业目录其移动到脚本所在的文件夹路径
if ($null -ne $originalScriptFolderPath) {
    Set-Location $originalScriptFolderPath
}
# ================================================================================
# 要安装的.dll库的路径, 此处设定为和脚本同一级别的目录下
[string]$dllPath = ".\03-ToolLib.dll"
# .dll库的ProgId
$ProgId = "ToolLib.ToolCom"
# ==================================================

# 获取32位和64位的RegAsm.exe的路径, 由于不知道具体版本, 所以使用了通配符
$regAsm32ExePath = "$env:WINDIR\Microsoft.NET\Framework\v4.0.*\RegAsm.exe"
$regAsm64ExePath = "$env:WINDIR\Microsoft.NET\Framework64\v4.0.*\RegAsm.exe"

# 获取RegAsm.exe的绝对路径
$regAsm32ExeFullPath = (Get-ChildItem "$regAsm32ExePath" -ErrorAction SilentlyContinue | Select-Object -First 1).FullName
$regAsm64ExeFullPath = (Get-ChildItem "$regAsm64ExePath" -ErrorAction SilentlyContinue | Select-Object -First 1).FullName

# 如果32位和64位的RegAsm.exe有任意一个不存在的话
if ((-not $regAsm32ExeFullPath) -or (-not $regAsm64ExeFullPath)) {
    Write-Host "找不到RegAsm.exe文件..."
    Pause
    exit 1
}

# 注册Com
function Register-Com {

    param (
        [string]$dllFullPath,
        [string]$regAsmExeFullPath
    )

    $versionMsg = "32位"
    if ($regAsmExeFullPath.Contains('Framework64')) {
       $versionMsg = "64位"
    }

    # 注册Com所需的参数
    #   /codebase 
    #       告诉COM：DLL文件所在的绝对路径
    #       会在注册表的指定项的InprocServer32中写入.dll文件的绝对路径
    #   /tlb
    #       给COM客户端（尤其 VBA）用的接口描述文件
    #       里面描述了接口, 方法, 参数类型
    #       非必须参数
    #           但是添加了这个参数之后, vba可以在【工具】→【引用】中找到我们自定义的.dll
    #           然后就可以进行早绑定了
    $params = "`"$dllFullPath`" /codebase /tlb"
    $result = $null
    try {
        $result = Start-Process $regAsmExeFullPath -ArgumentList $params -Wait -PassThru
        if ($result.ExitCode -eq 0) {
            Write-Host "${versionMsg}的dll注册成功"
        }
    } 
    catch {
        Write-Host "${versionMsg}的dll注册失败: $($result.ExitCode)"
        Write-Host "${versionMsg}的dll注册失败: $($_.Exception.Message)"
    }
}

# 卸载Com
function Unregister-Com {

    param (
        [string]$dllFullPath,
        [string]$regAsmExeFullPath
    )

    $versionMsg = "32位"
    if ($regAsmExeFullPath.Contains('Framework64')) {
       $versionMsg = "64位"
    }

     # 卸载Com所需的参数
    $params = "`"$dllFullPath`" /unregister"
    $result = $null
    try {
        $result = Start-Process $regAsmExeFullPath -ArgumentList $params -Wait -PassThru
        if ($result.ExitCode -eq 0) {
            Write-Host "${versionMsg}的dll卸载成功"
        }
    } 
    catch {
        Write-Host "${versionMsg}的dll卸载失败: $($result.ExitCode)"
        Write-Host "${versionMsg}的dll卸载失败: $($_.Exception.Message)"
    }
}

# 通过相对路径获取绝对路径
$fullPathObj = Resolve-Path $dllPath -ErrorAction SilentlyContinue
if (-not $fullPathObj) {
    Write-Host "找不到${dllPath}文件..."
    Pause
    exit 1
}

# 获取dll文件的绝对路径
$dllFullPath = $fullPathObj.Path

# 让用户选择要执行的操作
[string]$confirm = Read-Host "选择要执行的操作. 1. 安装依赖库 2. 卸载依赖库"
if ($confirm -eq "2") {

    # 卸载32位的com
    Unregister-Com -dllFullPath $dllFullPath -regAsmExeFullPath $regAsm32ExePath
    # 卸载64位的com
    Unregister-Com -dllFullPath $dllFullPath -regAsmExeFullPath $regAsm64ExePath

    Pause
    exit
} elseif ($confirm -ne "1") {
    Write-Host "请输入 1 或者 2"
    Pause
    exit
}

# 注册32位的com
Register-Com -dllFullPath $dllFullPath -regAsmExeFullPath $regAsm32ExePath
# 注册64位的com
Register-Com -dllFullPath $dllFullPath -regAsmExeFullPath $regAsm64ExePath

<#
    32位的PowerShell, 只能验证32位的com
    64位的PowerShell, 只能验证64位的com
    现在一般的电脑都是64位的, PowerShell也都是64位的
#>
function Test-32ComBoth {

    param (
        [string]$progId
    )

    # 32位Powershell的路径
    $powershell32 = "$env:WINDIR\SysWOW64\WindowsPowerShell\v1.0\powershell.exe"
    $script = @"
try {
    New-Object -ComObject '$progId' | Out-Null
    Write-Host '${progId}的32位COM存在'
} catch {
    Write-Host '${progId}的32位COM不存在'
}
"@
    # 测试32位com
    & $powershell32 -NoProfile -Command $script
}

function Test-64ComBoth {

    param (
        [string]$progId
    )

    # 测试64位com
    try {
        New-Object -ComObject $progId | Out-Null
        Write-Host "${progId}的64位COM存在"
    }
    catch {
        Write-Host "${progId}的64位COM不存在"
    }
}

# .dll类库中的命名空间和方法名
Test-32ComBoth "$ProgId"
Test-64ComBoth "$ProgId"

# 根据 ProgId 查询注册表路径是否存在
$RegistryProgIdPath = "Registry::HKEY_CLASSES_ROOT\$ProgId\"
if (-not (Test-Path $RegistryProgIdPath)) {
    Write-Host "找不到${RegistryProgIdPath}注册表..."
    Pause
    exit 1
}

# 获取 .dll库的Guid
# {6143FB0B-9C17-4859-860C-6DA4A466ECD1}
$dllCLSID = (Get-Item "$RegistryProgIdPath\CLSID").GetValue("")

# 查询32位.dll对应的注册表
Get-ChildItem "Registry::HKLM\Software\Classes\WOW6432Node\CLSID\$dllCLSID" -ErrorAction SilentlyContinue
# 查询64位.dll对应的注册表
Get-ChildItem "Registry::HKEY_CLASSES_ROOT\CLSID\$dllCLSID" -ErrorAction SilentlyContinue

Pause