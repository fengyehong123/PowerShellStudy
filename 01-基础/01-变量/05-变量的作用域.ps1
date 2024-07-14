# 来源
# https://www.pstips.net/powershell-scope-of-variables.html

<#
    Powershell所有的变量都有一个决定变量是否可用的作用域
    Powershell支持四个作用域：
        全局($global)
            在所有的作用域中有效，如果你在脚本或者函数中设置了全局变量，即使脚本和函数都运行结束，这个变量也任然有效。
        默认($local)
            可以省略修饰符，在当前作用域有效，其它作用域只对它有只读权限。
        私有($private)
            只会在当前作用域有效，不能贯穿到其他作用域。
        脚本($script)
            只会在脚本内部有效，包括脚本中的函数，一旦脚本运行结束，这个变量就会被回收。
    有了这些作用域就可以限制变量的可见性了,尤其是在函数和脚本中
#>

# 我们在脚本中定义了一个名为 $windows的变量
$windows = 'Hello World!'
# 打印
Write-Host "Windows 文件夹：$($windows)"
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    通过控制台的方式运行 05-变量的作用域.ps1 这个脚本
    ⏹方式一
        PS> $windows="控制台定义的变量"
        PS> .\05-变量的作用域.ps1
        Windows 文件夹：Hello World!
        PS> $windows
        控制台定义的变量
    ⇒⇒⇒ 可以看到
            通过 .\脚本名称.ps1 的方式来运行脚本之后,在控制台中定义的 $windows 变量的值不发生改变

    ⏹方式二
        PS> $windows="控制台定义的变量"
        PS> . .\05-变量的作用域.ps1
        Windows 文件夹：Hello World!
        PS> $windows
        Hello World!
    ⇒⇒⇒ 可以看到
            通过 . .\脚本名称.ps1 的方式来运行脚本之后,在控制台中定义的 $windows 变量的值会受到影响,发生改变
            这种方式执行脚本,Powershell解释器就不会为脚本本身创建自己的变量作用域,它会共享当前控制台的作用域
            使用的时候一定要小心
#>

# 定义一个函数,在函数内部设置一个全局变量
function set_custom_var() {
    $Global:var1 = '全局变量1'
}

# 试图访问全局变量
if ($null -eq $Global:var1) {
    Write-Host '试图访问全局变量失败!'
}

# 调用函数,设置全局变量
set_custom_var
# 再一次尝试获取全局变量
$Global:var1 | Out-Host  # 全局变量1
