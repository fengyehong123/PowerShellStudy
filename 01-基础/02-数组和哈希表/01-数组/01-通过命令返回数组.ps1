# 来源
# https://www.pstips.net/powershell-commands-return-arrays.html

<#
    ⏹将一个命令(ipconfig)的执行结果保存到一个变量中时,此时变量中存储的不是纯文本
    Powershell会把文本按每一行作为元素存为数组
    如果一个命令的返回值不止一个结果时,Powershell也会自动把结果存储为数组
#>
ipconfig
Write-Host '----------------------------------------------'

$result = ipconfig
Write-Host $result
Write-Host '----------------------------------------------'

# ⏹判断是否是数组
if ($result -is [array]) {
    # ⏹获取数组的长度
    Write-Host ("数组的长度为: $($result.Count)")
    Write-Host '----------------------------------------------'
}

"Hello World" -is [array]  # False
"Hello World" -is [string]  # True
"Hello World".ToCharArray() -is [array]  # True
Write-Host '----------------------------------------------'

# ⏹获取数组的第2个元素(数组的下标从0开始)
Write-Host ("数组的第2个元素是: $($result[1])")  # Windows IP 配置
Write-Host '----------------------------------------------'

<#
    ⏹通过管道对数组进一步处理
    ↓
    Select-String
        在文本中查找指定字符串模式的命令
    Select-String "IP"
        从输入的文本中选择包含 "IP" 字符串的行
#>
ipconfig | Select-String "IP"
Write-Host '----------------------------------------------'

<#
    ⏹Where-Object { $_ -notmatch "Windows IP 配置" }
        保留除了 "Windows IP 配置" 外的所有内容
#>
ipconfig | Select-String "IP" | Where-Object { $_ -notmatch "Windows IP 配置" }
Write-Host '----------------------------------------------'

<#
    ⏹获取 01-变量 文件夹中的所有文件
    最终得到的是一个数组,数组中的元素是 System.IO.FileInfo 类型的
    可以通过
        [System.IO.FileInfo[]]变量
    来表示强制类型的数组
#>
[System.IO.FileInfo[]]$res = Get-ChildItem ..\01-变量
# 选取一个元素,获取类型
$res[0].GetType().FullName  # System.IO.FileInfo
Write-Host '----------------------------------------------'

<#
    ⏹当我们打印数组中的元素时,Powershell会自动帮我们把它转换成友好的文本格式
#>
Write-Host $res[0]  # 01-定义变量.ps1
Write-Output $res[0]
<#
    LastWriteTime : 2024/5/10 8:08:02
    Length        : 3503
    Name          : 01-定义变量.ps1
#>
Write-Host '----------------------------------------------'

# 对于任何一个对象都可以使用Format-List * 查看它所有的属性和方法
Write-Output $res[0] | Format-List *
<#
    PSPath            : Microsoft.PowerShell.Core\FileSystem::C:\Users\XXX\Desktop\Powershell_Study\01-基础\01-变量\01-定义变量.ps1
    PSParentPath      : Microsoft.PowerShell.Core\FileSystem::C:\Users\XXX\Desktop\Powershell_Study\01-基础\01-变量
    PSChildName       : 01-定义变量.ps1
    PSDrive           : C
    PSProvider        : Microsoft.PowerShell.Core\FileSystem
    PSIsContainer     : False
    Mode              : -a----
    VersionInfo       : File:             C:\Users\XXX\Desktop\Powershell_Study\01-基础\01-变量\01-定义变量.ps1
                        InternalName:
                        OriginalFilename:
                        FileVersion:
                        FileDescription:
                        Product:
                        ProductVersion:
                        Debug:            False
                        Patched:          False
                        PreRelease:       False
                        PrivateBuild:     False
                        SpecialBuild:     False
                        Language:

    BaseName          : 01-定义变量
    Target            : {}
    LinkType          :
    Name              : 01-定义变量.ps1
    Length            : 3503
    DirectoryName     : C:\Users\XXX\Desktop\Powershell_Study\01-基础\01-变量
    Directory         : C:\Users\XXX\Desktop\Powershell_Study\01-基础\01-变量
    IsReadOnly        : False
    Exists            : True
    FullName          : C:\Users\XXX\Desktop\Powershell_Study\01-基础\01-变量\01-定义变量.ps1
    Extension         : .ps1
    CreationTime      : 2024/5/9 21:27:04
    CreationTimeUtc   : 2024/5/9 12:27:04
    LastAccessTime    : 2024/5/13 19:51:48
    LastAccessTimeUtc : 2024/5/13 10:51:48
    LastWriteTime     : 2024/5/10 8:08:02
    LastWriteTimeUtc  : 2024/5/9 23:08:02
    Attributes        : Archive
#>