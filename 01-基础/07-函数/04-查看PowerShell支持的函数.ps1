# 来源
# https://www.pstips.net/powershell-inspect-available-func.html

<#
    ⏹PowerShell给用户提供了很多的能使用的预制函数
    这些函数可以通过 Function:PSDrive 虚拟驱动器查看
#>
Get-ChildItem function: | 
Select-Object -First 10 | 
Format-Table -AutoSize
<#
    CommandType Name                     Version Source
    ----------- ----                     ------- ------
    Function    __VSCode-Escape-Value
    Function    A:
    Function    B:
    Function    C:
    Function    cd..
    Function    cd\
    Function    Clear-Host               0.2.0   PowerShellEditorServices.Commands
    Function    ConvertFrom-ScriptExtent 0.2.0   PowerShellEditorServices.Commands
    Function    ConvertFrom-SddlString   3.1.0.0 Microsoft.PowerShell.Utility
    Function    ConvertTo-ScriptExtent   0.2.0   PowerShellEditorServices.Commands
#>