using namespace System.Windows.Forms
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

Add-Type @"
using System;
using System.Runtime.InteropServices;

public class PowerHelper {
    [DllImport("kernel32.dll")]
    public static extern uint SetThreadExecutionState(uint esFlags);
}
"@

# 常量
$ES_CONTINUOUS       = [uint32]1 -shl 31
$ES_SYSTEM_REQUIRED  = [uint32]0x00000001
$ES_DISPLAY_REQUIRED = [uint32]0x00000002

# 提示文字
$SystemOnlyAwake_MSG = "防止休眠,但不防止息屏"
$SystemAndDisplayAwake_MSG = "防止休眠,且防止息屏"
$DisableKeepAwake_MSG = "关闭保持唤醒功能"
$Exist_Shell_MSG = "退出程序"

# 当前的模式
$global:KeepMode = "Off"

function Enable-SystemOnlyAwake {

    param(
        [string]$msg
    )

    [PowerHelper]::SetThreadExecutionState($ES_CONTINUOUS -bor $ES_SYSTEM_REQUIRED) | Out-Null
    Update-ConsoleTitle -title $msg

    Write-Host "【$msg】功能执行中..." -ForegroundColor Red
    $global:KeepMode = "System"
}

function Enable-SystemAndDisplayAwake {

    param(
        [string]$msg
    )

    [PowerHelper]::SetThreadExecutionState($ES_CONTINUOUS -bor $ES_SYSTEM_REQUIRED -bor $ES_DISPLAY_REQUIRED) | Out-Null
    Update-ConsoleTitle -title $msg

    Write-Host "【$msg】功能执行中..." -ForegroundColor Red
    $global:KeepMode = "System+Display"
}

function Disable-KeepAwake {
    param(
        [string]$msg = "退出程序"
    )

    [PowerHelper]::SetThreadExecutionState($ES_CONTINUOUS) | Out-Null
    Update-ConsoleTitle -title $msg

    Write-Host "【$msg】功能执行中..." -ForegroundColor Red
    $global:KeepMode = "Off"
}

# 修改控制台的标题
function Update-ConsoleTitle {
    param(
        [string]$title
    )
    # 清空控制台打印的消息
    Clear-Host
    # 修改控制台的标题
    [Console]::Title = $title
}

# ---------------------------------------------------------------
# 默认开启：防止休眠, 且防止息屏
Enable-SystemAndDisplayAwake -msg $SystemAndDisplayAwake_MSG
# ---------------------------------------------------------------

# 创建托盘图标
$notifyIcon = New-Object System.Windows.Forms.NotifyIcon
# 托盘图标的样式
$notifyIcon.Icon = [System.Drawing.SystemIcons]::Information
# 托盘图标可见
$notifyIcon.Visible = $true
# 托盘图标上的提示文字
$notifyIcon.Text = $SystemAndDisplayAwake_MSG 

# 创建图标的菜单
$contextMenu = New-Object System.Windows.Forms.ContextMenuStrip
# 添加图标右键右键菜单项目
$menuSystemOnly = $contextMenu.Items.Add($SystemOnlyAwake_MSG)
$menuSystemDisplay = $contextMenu.Items.Add($SystemAndDisplayAwake_MSG)
$menuDisable = $contextMenu.Items.Add($DisableKeepAwake_MSG)
$contextMenu.Items.Add("-") | Out-Null  # 分割线
$menuExit = $contextMenu.Items.Add($Exist_Shell_MSG)

# --------
# 绑定事件
# --------
$menuSystemOnly.Add_Click({
    Enable-SystemOnlyAwake -msg $SystemOnlyAwake_MSG
    $notifyIcon.Text = $SystemOnlyAwake_MSG
})

$menuSystemDisplay.Add_Click({
    Enable-SystemAndDisplayAwake -msg $SystemAndDisplayAwake_MSG
    $notifyIcon.Text = $SystemAndDisplayAwake_MSG
})

$menuDisable.Add_Click({
    Disable-KeepAwake -msg $DisableKeepAwake_MSG
    $notifyIcon.Text = $DisableKeepAwake_MSG
})

# 退出当前脚本
$menuExit.Add_Click({
    Disable-KeepAwake
    $notifyIcon.Visible = $false
    $notifyIcon.Dispose()
    [Application]::Exit()
})

$notifyIcon.ContextMenuStrip = $contextMenu

# ------------------------------------
# 双击切换模式
# ------------------------------------
$notifyIcon.Add_DoubleClick({
    if ($global:KeepMode -eq "Off") {
        Enable-SystemAndDisplayAwake -msg $SystemAndDisplayAwake_MSG
        $notifyIcon.Text = $SystemAndDisplayAwake_MSG
    }
    else {
        Disable-KeepAwake -msg $DisableKeepAwake_MSG
        $notifyIcon.Text = $DisableKeepAwake_MSG
    }
})

# 保持消息循环
[Application]::Run()