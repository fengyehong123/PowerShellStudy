# 直接把C#的代码通过字符串的方式写到PowerShell代码中
Add-Type @"
using System;
using System.Runtime.InteropServices;

public class NativeMethods {
    [DllImport("user32.dll", CharSet=CharSet.Auto)]
    public static extern int MessageBox(IntPtr hWnd, String text, String caption, int options);
}
"@

# 调用C#代码中的方法
[NativeMethods]::MessageBox([IntPtr]::Zero, "弹出的消息: Hello from DLL", "左上角的标题", 0) | Out-Null
Write-Host '--------------------------------------------------------------------' -ForegroundColor Red

# 将C#文件中的代码导入到Powershell代码中
Add-Type -Path "$($PSScriptRoot)\00-C#_Source.cs"

# 使用C#代码中导入的类创建对象
[Student]$stu = [Student]::new("李四", 22)

# 调用C#代码中类的实例方法
$msg1 = $stu.ToString()
Write-Host $msg1

# 调用C#代码中类的静态方法
[string]$msg2 = [Student]::getInfo("这是从 PowerShell 传入的消息")
Write-Host $msg2
Write-Host '--------------------------------------------------------------------' -ForegroundColor Red

# 也可以通过 New-Object 的方式创建对象
$stu2 = New-Object Student('张三', 300)
$stu2.ToString() | Out-Host
