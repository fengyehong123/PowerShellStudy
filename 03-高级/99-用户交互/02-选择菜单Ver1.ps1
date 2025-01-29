$SwitchUser = ([System.Management.Automation.Host.ChoiceDescription]"&切换")
$LoginOff = ([System.Management.Automation.Host.ChoiceDescription]"&LoginOff")
$Lock= ([System.Management.Automation.Host.ChoiceDescription]"&Lock")
$Reboot= ([System.Management.Automation.Host.ChoiceDescription]"&Reboot")
$Sleep= ([System.Management.Automation.Host.ChoiceDescription]"&Sleep")

$selection = [System.Management.Automation.Host.ChoiceDescription[]]($SwitchUser,$LoginOff,$Lock,$Reboot,$Sleep)
$answer = $Host.UI.PromptForChoice('接下来做什么事呢？','请选择:',$selection,1)

Write-Output "您选择的是："
switch($answer)
{
    0 {"切换用户"}
    1 {"注销"}
    2 {"锁定"}
    3 {"重启"}
    4 {"休眠"}
}

Read-Host "脚本执行完毕。按 Enter 键退出..."