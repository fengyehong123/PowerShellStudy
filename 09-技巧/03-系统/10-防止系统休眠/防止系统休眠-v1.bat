@(echo '> NUL
echo off)

setlocal ENABLEDELAYEDEXPANSION

set ARGV0=%~f0
set ARGS=%*
set ARGC=0

for %%V in (%*) do (
    set /a ARGC=!ARGC!+1
    set ARGV!ARGC!=%%V
)

PowerShell.exe -Command "Invoke-Expression -Command ((Get-Content \"%ARGV0: `=` `%\") -join \"`n\")"
exit /b %errorlevel%
') | Out-Null

# + ______________________                     ______________________ +
# + ______________________ 以下为PowerShell代码 ______________________ +    

$argc=$ENV:ARGC
$argv=@()
for($i=0;$i -le $argc;$i++){
    $argv += (Get-ChildItem "ENV:ARGV$i").Value
}

# + ______ 代码本体部分 ______ +    
$source = @"
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

Add-Type -Language CSharp -TypeDefinition $source

$interval = $argv[1] -as [int]
if(!$interval) {
    $interval = 60
}
Write-Output "interval time: $interval sec"

while(1) {
    $d = Get-Date
    Write-Output "[$d] MoveMouse"
    [Win32]::MoveMouse()
    Start-Sleep -Seconds $interval
}