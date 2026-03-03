<#
    💥ForEach-Object -Parallel 是 powershell7 支持的功能
#>

# 开启5个线程去执行任务
1..5 | ForEach-Object -Parallel {

    Start-Sleep -Seconds 2
    Write-Host "任务 $_ 完成 - 线程ID: $([System.Threading.Thread]::CurrentThread.ManagedThreadId)"
    <#
        任务 2 完成 - 线程ID: 27
        任务 3 完成 - 线程ID: 20
        任务 1 完成 - 线程ID: 33
        任务 5 完成 - 线程ID: 15
        任务 4 完成 - 线程ID: 19
    #>
}
Write-Host '---------------------------------------------'

# 控制并发的数量, 同时最多运行 3 个线程
1..5 | ForEach-Object -Parallel {
    Start-Sleep -Seconds 3
    "任务 $_ 完成"
} -ThrottleLimit 3
Write-Host '---------------------------------------------'

# 并行块里不能直接访问外部变量，要用 $using: 来访问
$delay = 2
$prefix = "任务"
$names = @("张三","李四","王五")
1..3 | ForEach-Object -Parallel {

    Start-Sleep $using:delay
    Write-Host "$using:prefix $_"

    $using:names | ForEach-Object {
        Write-Host "$_"
    }
}