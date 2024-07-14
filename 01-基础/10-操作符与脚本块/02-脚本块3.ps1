<#
    ⏹Begin, Process, End 管道语句块
    可以按照上述结构定义函数来实时处理管道数据
    也可以通过脚本块的方式来定义,并通过 & 操作符来调用执行
#>
Get-Process | Select-Object -Last 5 | & {
    Begin {
        '~~~~~~~~~开始准备环境~~~~~~~~~'
    }
    Process {
        $_.Name
    }
    End {
        '=========开始清理环境========='
    }
}
<#
    ~~~~~~~~~开始准备环境~~~~~~~~~
    WmiPrvSE
    wsctrlsvc
    WUDFHost
    WUDFHost
    ZeroConfigService
    =========开始清理环境=========
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red