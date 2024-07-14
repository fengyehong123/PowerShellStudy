# 来源
# https://www.pstips.net/powershell-specify-return-value-from-function.html

<#
    ⏹Write-Debug cmdlet 在 PowerShell 中用于生成调试消息
    这些消息在调试模式下
        即 $DebugPreference 变量不为 'SilentlyContinue' 时
    会显示在控制台中
#>
function getRandomNum() {

    # 直接执行函数下面的Debug信息不会被打印到控制台上
    Write-Debug "函数开始运行..."
    "本次函数执行获得的随机数是: $(Get-Random -Minimum 1 -Maximum 15)"
    Write-Debug "函数结束运行..."
}

getRandomNum | Out-Host
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹修改 $DebugPreference 变量的值,开启调试模式
#>
if ($DebugPreference -eq 'SilentlyContinue') {
    $DebugPreference = 'Continue'
}
getRandomNum | Out-Host
<#
    调试: 函数开始运行...
    本次函数执行获得的随机数是: 11
    调试: 函数结束运行...
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    函数中的错误信息,会直接输出到控制台
    因为对调试程序很重要,一般情况下不应该隐藏
    如果就是要隐藏
    可以使用 ⇓⇓⇓⇓⇓⇓
        $ErrorActionPreference
    进行设置
#>
function test() {

    #从这里开始隐藏所有的错误信息
    $ErrorActionPreference = 'SilentlyContinue'

    # 停止一个不存在的进程
    Stop-Process -Name 'www.jiafeitian.com'

    <# 
        但是不能隐藏所有的错误,否则会错过重要的提示
        恢复$ErrorActionPreference,错误开始输出
    #>
    $ErrorActionPreference = 'Continue'
    2 / 0
}
# 调用函数,可以看到只有一个错误出现在控制台上
. test

