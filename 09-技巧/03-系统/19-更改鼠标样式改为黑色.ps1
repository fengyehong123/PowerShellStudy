# 注册表文件
$regPath = "HKCU:\Control Panel\Cursors"
# windows鼠标指针资源文件
$cursorPath = "$env:SystemRoot\Cursors"

# 黑色指针文件的资源映射表
$scheme = @{
    AppStarting = "$cursorPath\wait_r.cur"
    Arrow       = "$cursorPath\arrow_r.cur"
    Crosshair   = "$cursorPath\cross_r.cur"
    Help        = "$cursorPath\help_r.cur"
    IBeam       = "$cursorPath\beam_r.cur"
    No          = "$cursorPath\no_r.cur"
    NWPen       = "$cursorPath\pen_r.cur"
    SizeAll     = "$cursorPath\move_r.cur"
    SizeNESW    = "$cursorPath\size1_r.cur"
    SizeNS      = "$cursorPath\size4_r.cur"
    SizeNWSE    = "$cursorPath\size2_r.cur"
    SizeWE      = "$cursorPath\size3_r.cur"
    UpArrow     = "$cursorPath\up_r.cur"
    Wait        = "$cursorPath\busy_r.cur"
}

# 修改注册表中关于鼠标指针的资源文件路径
foreach ($key in $scheme.Keys) {
    Set-ItemProperty -Path $regPath -Name $key -Value $scheme[$key]
}

# 修改注册表中的鼠标指针颜色
Set-ItemProperty -Path $regPath -Name "(Default)" -Value "Windows Black"
Set-ItemProperty -Path $regPath -Name "Scheme Source" -Value 2

# 调用 SystemParametersInfo , 让修改立即生效
Add-Type @"
using System;
using System.Runtime.InteropServices;
public class NativeMethods {
    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool SystemParametersInfo(int uAction, int uParam, IntPtr lpvParam, int fuWinIni);
}
"@

<#
    0x57
        SPI_SETCURSORS
    0x02
       SPIF_SENDCHANGE 
#>
[NativeMethods]::SystemParametersInfo(0x57, 0, [IntPtr]::Zero, 0x02)
