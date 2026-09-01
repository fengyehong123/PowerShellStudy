Write-Host '脚本执行开始...' -ForegroundColor Red

# 获取出所有的wifi名称
$wifi_name_list = netsh wlan show profiles | Select-String "所有用户配置文件" | ForEach-Object {
    # 过滤出所有wifi名称(将wifi名之外的部分替换为空字符串)
    $_ -replace ".*:\s+", ""
}

# 获取wifi名称的总数量
$wifi_list_count = ($wifi_name_list | Measure-Object).Count
# 存放wifi信息的数组
$wifi_object_array = @()

# 根基wifi名称获取wifi信息
for ($i = 0; $i -le $wifi_list_count; $i++) {

    # 创建一个Powershell自定义对象,并添加到数组中
    $wifi_object_array += [PSCustomObject]@{
        wifi名称 = $wifi_name_list[$i]
        # 根据wifi名称获取wifi密码
        wifi密码 = netsh wlan show profile name="$($wifi_name_list[$i])" key=clear | Select-String "关键内容" | ForEach-Object { $_ -replace ".*:\s+", "" }
    }

    # 计算当前进度
    $progress = [math]::Round(($i / $wifi_list_count) * 100)
    # 更新进度条
    Write-Progress -Activity "ヾ(•ω•`)oWiFi密码获取ヾ(•ω•`)o" -Status "当前进度: $progress%" -PercentComplete $progress
}

# 完成时清除进度条
Write-Progress -Activity "ヾ(•ω•`)oWiFi密码获取ヾ(•ω•`)o" -Status "Completed!" -Completed

# 打印wifi对象信息
$wifi_object_array | Format-Table -AutoSize

Write-Host '脚本执行结束...' -ForegroundColor Red

# 暂停脚本执行
Pause