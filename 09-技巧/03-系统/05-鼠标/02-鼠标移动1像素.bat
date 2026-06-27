@echo off
setlocal enabledelayedexpansion

:: 设置变量,用来将powershell脚本存储到临时目录中
:: 给脚本名中设置随机数,可防止文件冲突
set "psScript=%temp%\temp_ps_script_%random%.ps1"

:: 读取次脚本中【:: PowerShellStart】之后的powershell代码, 将其添加到临时存储用的powershell脚本中
for /f " delims=:" %%i in ('findstr /n "^:: PowerShellStart$" "%~f0"') do (
    more +%%i "%~f0" > "%psScript%"
)

:: 在bat批处理脚本中调用powershell
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%psScript%"

:: 删除存储脚本用的临时文件
if exist "%psScript%" del "%psScript%"

:: 退出bat批处理脚本
exit /b

:: PowerShellStart
# + ______________________                     ______________________ +
# + ______________________ 以下为PowerShell代码 ______________________ +               

# 使用字符串的方式在powershell代码中写C#代码
$MoveMouseSource = @"
using System;
using System.Runtime.InteropServices;

public class Win32 {
    [DllImport("user32.dll")]
    extern static uint SendInput(
        uint nInputs,
        INPUT[] pInputs,
        int cbSize
    );
    [StructLayout(LayoutKind.Sequential)]
    struct INPUT
    {
        public int type;
        public MOUSEINPUT mi;
    }
    [StructLayout(LayoutKind.Sequential)]
    struct MOUSEINPUT
    {
        public int dx;
        public int dy;
        public int mouseData;
        public int dwFlags;
        public int time;
        public IntPtr dwExtraInfo;
    }
    public static void MoveMouse() {
        INPUT[] inp = new INPUT[2];
        inp[0].mi.dx = 1;
        inp[0].mi.dwFlags = 1;
        inp[1].mi.dx = -1;
        inp[1].mi.dwFlags = -1;
        SendInput(2, inp, Marshal.SizeOf(inp[0]));
    }
}
"@
Add-Type -Language CSharp -TypeDefinition $MoveMouseSource

# 设置鼠标移动的间隔
$interval = 60
Write-Output "interval time: $interval sec"

while($true) {
    Write-Output "[$(Get-Date)] MoveMouse"
    [Win32]::MoveMouse()
    Start-Sleep -Seconds $interval
}