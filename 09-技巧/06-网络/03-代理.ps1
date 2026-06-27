<#
    Windows 里实际上有两套代理配置
        1. IE / Internet Options 代理：Edge、Chrome（默认）、Office 等
        2. WinHTTP 代理              ：Windows Update、部分系统服务、PowerShell 某些场景
#>


# 读取IE代理
Get-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings'

# 查看当前 WinHTTP 配置
netsh winhttp show proxy
netsh winhttp reset proxy

# 将当前用户在Internet Explorer(实际上是 Windows Internet Options 中配置的代理) 导入到 WinHTTP 代理配置中
netsh winhttp import proxy source=ie
netsh winhttp set proxy proxy-server="proxy.company.com:8080"