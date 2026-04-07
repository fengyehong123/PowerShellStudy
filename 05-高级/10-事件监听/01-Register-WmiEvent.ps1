using namespace System.Windows.Forms
Add-Type -AssemblyName System.Windows.Forms

<#
    Win32_VolumeChangeEvent
        EventType = 2  设备插入
        EventType = 3  设备移除
#>
Register-WmiEvent `
    -Query "SELECT * FROM Win32_VolumeChangeEvent WHERE EventType = 2" `
    -SourceIdentifier "USBPopup" `
    -Action {

        # 获取设备ID
        $eventData = $Event.SourceEventArgs.NewEvent
        $driveID = $eventData.DriveName
        if (-not $driveID) {
            return
        }

        # 获取所有的盘符之后, 根据设备ID进行过滤
        $disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='$driveID'"
        if (-not $disk) {
            return
        }

        # 如果当前设备类型不是可移动磁盘的话
        if ($disk.DriveType -ne 2) {
            return
        }

        [MessageBox]::Show(
            "检测到U盘插入: $driveID",
            "USB 提示",
            "OK",
            "Information"
        )
    }

while ($true) {
    Start-Sleep 5
}