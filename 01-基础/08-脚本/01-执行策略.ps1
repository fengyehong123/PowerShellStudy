# 来源
# https://www.pstips.net/powershell-create-and-start-scripts.html

<#
    ⏹执行策略限制
        Powershell一般初始化情况下都会禁止脚本执行。
        脚本能否执行取决于Powershell的执行策略。
#>

# ⏹查看所有支持的执行策略
[System.Enum]::GetNames([Microsoft.PowerShell.ExecutionPolicy]) | Out-Host
<#
    Unrestricted
        描述：运行所有脚本，不受限制，但会警告你从互联网下载的脚本。
        安全性：最低安全级别。允许执行任何脚本，但在执行从互联网下载的脚本时，会显示一个警告提示。
        用途：用于需要完全访问脚本执行功能的开发和测试环境。
    RemoteSigned
        描述：本地创建的脚本可以运行，下载的脚本需要经过有效的签名。
        安全性：中等安全级别。确保从互联网下载的脚本经过签名，以防止运行恶意脚本。
        用途：适用于需要运行下载脚本但希望保持一定程度安全性的环境。
    AllSigned
        描述：所有脚本都必须由可信发行者签名，无论是本地创建的还是下载的。
        安全性：高安全级别。要求所有脚本和配置文件都经过签名，确保脚本来自可信来源。
        用途：用于高安全性的环境，如生产系统或涉及敏感数据的系统。
    Restricted
        描述：禁止所有脚本运行，仅允许交互式命令。
        安全性：最高安全级别。不允许任何脚本运行，防止运行任何潜在的恶意脚本。
        用途：适用于不需要脚本执行功能的环境。
    Default
        描述：默认的执行策略，通常与操作系统版本相关联。
        安全性：取决于系统的默认设置。Windows 10 默认使用 Restricted，限制最严格。
        用途：用于遵循系统默认安全设置的环境。
    Bypass
        描述：不阻止任何脚本运行，不显示任何警告或提示。
        安全性：最低安全级别。允许执行任何脚本，无任何限制或警告。
        用途：用于需要完全跳过执行策略检查的自动化任务或特殊情况。
    Undefined
        描述：没有设置执行策略。如果未设置执行策略，PowerShell 使用默认执行策略。
        安全性：取决于默认执行策略的设置。如果未定义，系统将使用默认策略（如 Restricted）。
        用途：用于不明确设置执行策略的环境。
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# ⏹查看脚本的执行策略
# 1. 查看当前用户的执行策略
Get-ExecutionPolicy -Scope CurrentUser # Bypass
# 2. 查看当前系统的执行策略
Get-ExecutionPolicy -Scope LocalMachine

# ⏹更改脚本的执行策略(仅更新当前用户的脚本执行策略)
# 1. 不阻止任何脚本运行，不显示任何警告或提示。
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass
# 2. 本地创建的脚本可以运行，下载的脚本需要经过有效的签名。
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned

# ⏹查看整台机器的脚本执行策略
Get-ExecutionPolicy -List | Format-Table -AutoSize
<#
                Scope ExecutionPolicy
                ----- ---------------
        MachinePolicy       Undefined
           UserPolicy       Undefined
              Process       Undefined
          CurrentUser      Restricted
         LocalMachine    RemoteSigned
#>