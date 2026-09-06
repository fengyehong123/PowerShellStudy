<#
    🔷判断当前 PowerShell 会话是否以 管理员权限 （Elevated） 运行
        True → 当前是管理员权限运行
        False → 普通用户权限
#>
function Test-Elevated {

    [CmdletBinding()]
    [OutputType([bool])]
    param ()

    # 返回当前用户所属的所有安全组的SID
    # S-1-5-32-544 = Administrators 组（管理员组）
    return (([Security.Principal.WindowsIdentity]::GetCurrent()).Groups -contains "S-1-5-32-544")
}