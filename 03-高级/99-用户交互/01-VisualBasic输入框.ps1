Add-Type -AssemblyName Microsoft.VisualBasic

$userInput = [Microsoft.VisualBasic.Interaction]::InputBox("请输入您的姓名：", "输入框", "默认值")
Write-Output "您输入的是：$userInput"

Read-Host "按 Enter 键退出..."