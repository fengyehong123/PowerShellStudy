# 来源
# https://www.pstips.net/navigating-the-file-system.html

$my_path = "$HOME\Desktop\Powershell_Study"
Set-Location $my_path

# ⏹获取当前路径,相当于linux中的 pwd
Get-Location | Out-Host
# C:\Users\xxx\Desktop\Powershell_Study

# ⏹$PWD变量 和 Get-Location 作用相同
$PWD | Out-Host
# C:\Users\xxx\Desktop\Powershell_Study

# ⏹相当于cd命令,切换工作目录
Set-Location $env:APPDATA
Get-Location | Out-Host
# C:\Users\xxx\AppData\Roaming
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red
Set-Location $my_path

<#
    ⏹相对路径转换为绝对路径(支持使用通配符)
       文件一定要存在,否则不会转换成功
#>
(Get-ChildItem ".\笔记.md").FullName  # C:\Users\XXX\Desktop\Powershell_Study\笔记.md
(Resolve-Path ".\笔记.md").Path  # C:\Users\XXX\Desktop\Powershell_Study\笔记.md

# 暂停1秒钟
Start-Sleep -Seconds 1


function Edit_File {

    param(
        [string]$path = $(Throw "请输入相对路径!")
    )

    $files = Resolve-Path $path -ErrorAction SilentlyContinue
    if (!$?) {
        # 如果发生了错误,说明文件不存在,给出提醒并停止
        '没有找到符合要求的文件!'
        return
    }

    # 如果是数组,说明有多个文件
    if ($files -is [array]) {
        Write-Host '你想打开下面这些文件吗?' -ForegroundColor Red -BackgroundColor White
        Write-Host ''
        foreach ($file in $files) {
            "→ " + $file.Path
        }
        Write-Host ''
    }

    # 确认是否是用户想要打开的
    $options = [System.Management.Automation.Host.ChoiceDescription[]] @(
        # & 用于定义快捷键, &Yes 表示用户可以按下 Y 键 来选择这个选项
        # 参数2 是用户选择选中的描述或者提示信息
        [System.Management.Automation.Host.ChoiceDescription]::new("&Yes", "选择是")
        , [System.Management.Automation.Host.ChoiceDescription]::new("&No", "选择否")
    )

    $result = $host.ui.PromptForChoice('要执行上面的这些文件吗？','请选择...', $options, 1)
    if ($result -eq 0) {
        $files | ForEach-Object {
            & $_
        }
        return
    } 

    Write-Host '程序退出...' -ForegroundColor Red -BackgroundColor White
}



Edit_File('.\01-基础\14-文本处理实例\*.ps1')