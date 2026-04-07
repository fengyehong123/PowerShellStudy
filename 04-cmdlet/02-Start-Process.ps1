<#
    ⏹参数说明
        Start-Process
            用于启动一个进程（程序或脚本）
        -ArgumentList
            允许你传递一组参数到被启动的进程
        -NoProfile
            不加载用户的 PowerShell 配置文件（profile.ps1）
            可以确保以一个干净的环境运行，避免加载个性化配置
        -ExecutionPolicy RemoteSigned
            允许本地脚本运行，但远程脚本需要数字签名。
        -Verb RunAs
            -Verb 参数指定启动进程时的动作或方式。
            RunAs 是一个特殊的动词，表示以管理员权限运行程序。

    ⏹脚本说明
        用管理员的权限，在新窗口执行 Get-Process 命令获取全部进程，然后暂停窗口
#>
Start-Process -FilePath "powershell.exe" -ArgumentList "-NoProfile -ExecutionPolicy RemoteSigned -Command Get-Process;Pause" -Verb RunAs

# 打开谷歌浏览器
Start-Process -FilePath "$home\AppData\Local\Google\Chrome\Application\chrome.exe"

Pause