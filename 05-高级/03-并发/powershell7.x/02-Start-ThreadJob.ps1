<#
    💥Start-ThreadJob 是 powershell7 支持的功能
#>

$temp = "Test"
$jobs = 1..5 | ForEach-Object {

    # 使用 -ArgumentList 向脚本块中传递参数
    Start-ThreadJob -ScriptBlock {
        param($num1, $num2)
        Start-Sleep 2
        # 也可以使用 $using: 来使用外部的变量
        "完成 $num1 $num2 $using:temp"
    } -ArgumentList $_,10
}

# 等待完成
$jobs | Wait-Job

# 获取结果
$jobs | Receive-Job

# 🔷参数哈希表
$paramHash = @{
    Name = "张三"
    Age  = 20
    City = "Tokyo"
}

$job = Start-ThreadJob -ScriptBlock {
    param($data)

    "姓名: $($data.Name)"
    "年龄: $($data.Age)"
    "城市: $($data.City)"
} -ArgumentList $paramHash

$job | Wait-Job
$job | Receive-Job