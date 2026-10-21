# 🔷所有动词是 Get、名词含 Process 的命令
Get-Command -Verb Get -Noun "*Process*"
<#
    CommandType     Name                      Version        Source
    -----------     ----                      -------        ------
    Function        Get-AppvVirtualProcess    1.0.0.0        AppvClient
    Cmdlet          Get-Process               7.0.0.0        Microsoft.PowerShell.Management
    Cmdlet          Get-ProcessMitigation     1.0.12         ProcessMitigations
    Cmdlet          Get-PSHostProcessInfo     7.6.0.500      Microsoft.PowerShell.Core
    Cmdlet          Get-VMProcessor           2.0.0.0        Hyper-V
#>

# 🔷对于 Item 能干哪些事？全部列出来
Get-Command -Noun Item
<#
    CommandType     Name             Version    Source
    -----------     ----             -------    ------
    Cmdlet          Clear-Item       7.0.0.0    Microsoft.PowerShell.Management
    Cmdlet          Copy-Item        7.0.0.0    Microsoft.PowerShell.Management
    Cmdlet          Get-Item         7.0.0.0    Microsoft.PowerShell.Management
    Cmdlet          Invoke-Item      7.0.0.0    Microsoft.PowerShell.Management
    Cmdlet          Move-Item        7.0.0.0    Microsoft.PowerShell.Management
    Cmdlet          New-Item         7.0.0.0    Microsoft.PowerShell.Management
    Cmdlet          Remove-Item      7.0.0.0    Microsoft.PowerShell.Management
    Cmdlet          Rename-Item      7.0.0.0    Microsoft.PowerShell.Management
    Cmdlet          Set-Item         7.0.0.0    Microsoft.PowerShell.Management
#>