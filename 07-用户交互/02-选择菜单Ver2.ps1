<#
    参考资料
    1. https://qiita.com/yumura_s/items/274e8e49c975cce3a2ce
#>

# 定义选项描述和对应操作
$options = @{
    "重启电脑(&R)" = { Write-Host "重启电脑..." }
    "电脑休眠(&S)" = { Write-Host "电脑休眠..." }
    "切换用户(&C)" = { Write-Host "切换用户..." }
    "锁定屏幕(&L)" = { Write-Host "锁定屏幕..." }
}

$title = "接下来做什么事呢？"
$msg = "请选择:"
# 默认选项索引
$defaultIndex = 1

# 构建 ChoiceDescription 对象数组
$choiceDescriptions = $options.Keys | ForEach-Object {
    <#
        构建ChoiceDescription对象
        参数1：
            标签名称
        参数2:
            帮助信息
    #>
    New-Object System.Management.Automation.Host.ChoiceDescription ($_, $_.Split('(')[0])
}

# 显示交互菜单并获取用户选择
$userChoice = $Host.UI.PromptForChoice(
    $title, 
    $msg, 
    $choiceDescriptions, 
    $defaultIndex
)

# 执行用户选择的操作
$selectedOption = @($options.Keys)[$userChoice]
if ($selectedOption) {
    # 执行标签所对应的脚本块
    $options[$selectedOption].Invoke()
}

Read-Host "脚本执行完毕。按 Enter 键退出..."