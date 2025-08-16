@(echo '> NUL
echo off)
:: ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
:: @ → 防止批处理自身输出
:: 上面的代码写了点无关紧要的东西（可以理解为伪装成注释）
:: 主要是保证脚本一旦被双击运行时，不会弹出多余内容。
:: ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

REM 开启 延迟变量扩展，允许用 !VAR! 在循环里动态获取值。
setlocal ENABLEDELAYEDEXPANSION

:: ARGV0 
::      保存当前批处理脚本的 绝对路径
:: %~f0
::      获取当前脚本文件的完整路径
set ARGV0=%~f0
: 保存整个命令行参数
set ARGS=%*
: 参数计数器
set ARGC=0

:: 遍历所有传入的参数，把它们存储成类似数组的形式
::     ARGV1=第一个参数
::     ARGV2=第二个参数
:: ARGC 最终就是参数总个数
for %%V in (%*) do (
    set /a ARGC=!ARGC!+1
    set ARGV!ARGC!=%%V
)

REM 启动 PowerShell, 并执行命令
REM      (Get-Content "%ARGV0: = %") -join "`n"
REM           把当前脚本文件完整读入, 拼接成一段 PowerShell 代码 (以换行符连接)
REM      Invoke-Expression
REM           执行读取到的 PowerShell 代码
PowerShell.exe -Command "Invoke-Expression -Command ((Get-Content \"%ARGV0: `=` `%\") -join \"`n\")"
exit /b %errorlevel%
') | Out-Null

# + ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑以上为bat批处理代码部分↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ +
<#
    ★★★脚本简介★★★
        1. 这段脚本使用了 【Bat + PowerShell 】的混合脚本写法
        2. 前半段【.bat 部分】是为了 自举 (bootstrap),
           让一个文件既能当作 批处理文件双击运行, 又能在里面写 PowerShell 脚本

    ★★★核心思想★★★
       1. 在【.bat批处理】的内部调用【PowerShell.exe】执行 PowerShell 脚本
       2. 读取【.bat批处理】脚本内部的 PowerShell 代码然后执行
    
    ★★★这样写的好处是★★★
       1. 可以直接双击脚本文件就执行 PowerShell 代码
       2. 可以在【.bat批处理】内部写 PowerShell 代码进行业务处理
       3. 可以避免使用晦涩难懂的【.bat批处理】
#>

# + -------------------以下为PowerShell代码部分------------------- +
# + ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ +
$argc=$ENV:ARGC
$argv=@()
for($i=0;$i -le $argc;$i++){
    $argv += (Get-ChildItem "ENV:ARGV$i").Value
}

# + -------------------PowerShell代码处理的主体部分--------------- + 
# + ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ +

# 定义一个类, 类里面有静态方法
class Project {

    # 静态方法
    static [PSCustomObject]GetCategoryInfo() {
        return [PSCustomObject]@{
            mpl = [string[]]@(
                "mpl_rt_net",
                "mpl_rt_api",
                "mpl_eu_net",
                "mpl_eu_api"
            );
            ang = @(
                "ang_rt_net",
                "ang_rt_api",
                "ang_eu_net"
            );
            qch = @(
                "qch_rt_net",
                "qch_rt_api"
            );
        }
    }
}

# 用来获取值的key
$key = "mpl"

# ■获取map映射
[PSCustomObject]$categoryInfoMap = [Project]::GetCategoryInfo()

# ■通过key获取到value
$categoryInfoList = $categoryInfoMap.$key
foreach ($categoryInfo in $categoryInfoList) {
    Write-Host "$categoryInfo" -ForegroundColor Green
}
Write-Host "+ -----------------------------------------" -ForegroundColor Red

# ■像java的HashMap那样去遍历
foreach ($entry in $categoryInfoMap.PSObject.Properties) {

    # $entry.Name 就是键
    #                 mpl qch ang
    Write-Host "Key → $($entry.Name)" -ForegroundColor Yellow

    # $entry.Value 就是数组
    foreach ($v in $entry.Value) {
        Write-Host "  Value → $v"
    }
}
Write-Host "+ -----------------------------------------" -ForegroundColor Red

# ■像 Java map.keySet() 那样 只遍历key
$categoryInfoMap.PSObject.Properties.Name | ForEach-Object {
    # 其中 _ 就代表当前被遍历的元素
    Write-Host "key的值 → ${_}"
}
Write-Host "+ -----------------------------------------" -ForegroundColor Red

# ■像 Java map.values() 那样 只遍历值
foreach ($values in $categoryInfoMap.PSObject.Properties.Value) {
    foreach ($v in $values) {
        Write-Host $v
    }
}

# 暂停脚本执行
Pause
