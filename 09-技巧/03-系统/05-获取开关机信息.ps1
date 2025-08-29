# 获取开机信息
function Get-StartupInfo {

    # 6005 事件 ID（表示事件日志服务启动，通常意味着开机）
    return Get-WinEvent -LogName System | Where-Object { $_.Id -eq 6005 } | ForEach-Object {

        [PSCustomObject]@{
            # 电脑名称
            ComputerName = $_.MachineName
            # 事件事件
            TimeWritten = $_.TimeCreated  
            # 事件 ID (6005)
            EventID = $_.Id
            # 详细日志信息
            Message = $_.Message
        }
    }
}

# 获取关机信息
function Get-ShutdownInfo {

    return Get-WinEvent -LogName System | Where-Object { $_.Id -eq 6006 } | ForEach-Object {
        [PSCustomObject]@{
            ComputerName = $_.MachineName
            TimeWritten = $_.TimeCreated
            EventID = $_.Id
            Message = $_.Message
        }
    }
}

# 获取开机信息
Get-StartupInfo | Out-GridView

# 获取关机信息
Get-ShutdownInfo | Out-GridView


