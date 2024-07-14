$ddl_path = "$($HOME)\Desktop\Powershell_Study\01-基础\04-对象\file\Test.dll";
Test-Path $ddl_path  # True
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    [Reflection.Assembly]::LoadFile() 方法用于加载一个程序集（assembly）文件到当前会话中。
    这个方法通常用于加载外部的 .NET 程序集，比如 DLL 文件。
#>

<#
    ⏹加载DDL文件方式1:
        # 先读取ddl文件的字节码数据
        $dllByte = [System.IO.File]::ReadAllBytes($ddl_path)
        # 在将字节码数据加载到内存中
        [System.AppDomain]::CurrentDomain.Load($dllByte) | Out-Null
#>
<#
    ⏹加载DDL文件方式2:
        # 从ddl文件加载到当前脚本中
#>
[reflection.assembly]::LoadFile($ddl_path)

# 加载了DDL的程序集之后,就可以使用程序集中的对象
$stu = New-Object Test.Student('贾飞天', 30)
Write-Output $stu | Out-Host
<#
    Name : 贾飞天
    Age  : 30
#>
$stu.ToString() | Out-Host  # Name=贾飞天;Age=30