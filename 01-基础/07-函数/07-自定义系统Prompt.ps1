<#
    ⏹系统默认的Prompt
        每次成功执行完一条命令,Powershell就会执行Prompt函数,提示用户进行下一步输入.
        默认设置中,prompt显示 "PS" 和当前的工作目录

    ⏹自定义Prompt
        定义一个函数作为自定义Prompt,用来覆盖系统默认的Prompt
        覆盖只对当前会话有效,重启控制台之后,又会回到系统的默认Prompt
#>
function custom_prompt {
    "$(Get-Date -Format 'HH:mm:ss') → $($(Get-Location).Path.Split('\')[-1])> "
}

# 设置自定义提示符,覆盖当前系统的提示符
$function:prompt = $function:custom_prompt
<#
    16:48:46 → Powershell_Study>
    16:49:04 → Powershell_Study>
#>

Write-Host 'Hello World!'

# 如果是控制台环境,暂停脚本执行,等待用户输入
if ($host.Name -eq "ConsoleHost") {
    $host.UI.RawUI.ReadKey()
}