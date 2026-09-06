# 判断dll文件是否存在
$ddl_path = "$($PSScriptRoot)\02-1-C#代码编译而成的dll文件.dll"
if (-not (Test-Path $ddl_path)) {
    exit 1;
}

# 添加dll文件到当前脚本中
Add-Type -Path "$ddl_path"

# 2. 使用dll文件内置的类, 需要添加命名空间
$student = New-Object Test.Student('贾飞天', 30)
$student | Out-Host

# 3. 调用类方法
$student.ToString()
Write-Host '-------------------------------------------------' -ForegroundColor Red

# 也可以通过下面这种方式创建dll文件中的类对象, 也需要加命名空间
$tom = [Test.Student]::new("Tom", 20)
$tom | Out-Host
