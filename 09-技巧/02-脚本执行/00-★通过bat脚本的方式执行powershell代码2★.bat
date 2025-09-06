@echo off
setlocal enabledelayedexpansion

:: 设置变量,用来将powershell脚本存储到临时目录中
:: 给脚本名中设置随机数,可防止文件冲突
set "psScript=%temp%\temp_ps_script_%random%.ps1"

:: 读取次脚本中【:: PowerShellStart】之后的powershell代码, 将其添加到临时存储用的powershell脚本中
for /f " delims=:" %%i in ('findstr /n "^:: PowerShellStart$" "%~f0"') do (
    more +%%i "%~f0" > "%psScript%"
)

:: 在bat批处理脚本中调用powershell
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%psScript%"

:: 删除存储脚本用的临时文件
if exist "%psScript%" del "%psScript%"

:: 退出bat批处理脚本
exit /b

:: PowerShellStart
Add-Type -AssemblyName Microsoft.VisualBasic

$userInput = [Microsoft.VisualBasic.Interaction]::InputBox("请输入您的姓名：", "输入框", "默认值")
Write-Output "您输入的是：$userInput"

Read-Host "按 Enter 键退出..."