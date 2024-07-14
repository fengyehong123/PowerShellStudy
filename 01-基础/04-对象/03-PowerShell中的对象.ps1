# 获取指定文件绝对路径
$target_path = "$($Home)\Desktop\Java笔记\01-Java总结"
# 最终得到的变量中存储着数组,数组中的各个元素就是文件的绝对路径
$file_list = Get-ChildItem -Path $target_path -Recurse -File

# ⏹获取第一个元素上的所有属性
($file_list)[0] | Get-Member -MemberType Property | Out-Host
<#
    TypeName:System.IO.FileInfo
    
    Name              MemberType Definition
    ----              ---------- ----------
    Attributes        Property   System.IO.FileAttributes Attributes {get;set;}
    CreationTime      Property   datetime CreationTime {get;set;}
    CreationTimeUtc   Property   datetime CreationTimeUtc {get;set;}
    Directory         Property   System.IO.DirectoryInfo Directory {get;}
    DirectoryName     Property   string DirectoryName {get;}
    Exists            Property   bool Exists {get;}
    Extension         Property   string Extension {get;}
    FullName          Property   string FullName {get;}
    IsReadOnly        Property   bool IsReadOnly {get;set;}
    LastAccessTime    Property   datetime LastAccessTime {get;set;}
    LastAccessTimeUtc Property   datetime LastAccessTimeUtc {get;set;}
    LastWriteTime     Property   datetime LastWriteTime {get;set;}
    LastWriteTimeUtc  Property   datetime LastWriteTimeUtc {get;set;}
    Length            Property   long Length {get;}
    Name              Property   string Name {get;}
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# 获取第一个文件的名称
($file_list)[0].Name | Out-Host  # Java基础1.md
<#
    ⏹如果属性的定义中包含 {get;set;} 就表明该属性可以被获取和更新
#>
# 获取最后访问时间
($file_list)[0].LastAccessTime | Out-Host
($file_list)[0].Get_LastAccessTime() | Out-Host
# 设置最后访问时间后,打印到控制台上
($file_list)[0].LastAccessTime = Get-Date
($file_list)[0].LastAccessTime | Out-Host

<#
    ⏹对象中的特殊属性
        对象中的普通属性标签名为Property
        可以给对象增加属性
            NoteProperty：静态的数据
            ScriptProperty：动态数据,可通过脚本来计算获得
        增加的属性仍然可以通过 Get-Member 来获取

    ⏹MemberType包括
        AliasProperty：另外一个属性的别名
        CodeProperty：通过静态的.Net方法返回属性的内容
        Property：真正的属性
        NoteProperty：后来增加的属性
        ScriptProperty：通过脚本执行返回一个属性的值
        ParameterizedProperty：需要传递参数的属性
    
    ⏹PowerShell中的方法类型
        Method：正常的方法
        ScriptMethod：一个执行Powershell脚本的方法
        CodeMethod：映射到静态的.NET方法
#>

# 创建一个Powershell对象
$my_obj = New-Object PSObject
# 添加一个静态属性,设置后每个对象都相同
$my_obj | Add-Member -MemberType NoteProperty -Name CustomTime -Value ((Get-Date).ToString("yyyy-MM-dd HH:mm:ss.fff"))
<#
    ⏹添加一个动态属性,属性值是通过脚本计算来的,每个对象都不同
    因为是通过脚本来计算,所以 -Value 对应的是 {} 而不是 ()
#> 
$my_obj | Add-Member -MemberType ScriptProperty -Name CurrentTime -Value {(Get-Date).ToString("yyyy-MM-dd HH:mm:ss.fff")}
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹经过两次打印可以看到CustomTime属性值没有发生变化
    但是CurrentTime属性值每次都不一样
#>
$my_obj | Out-Host
<#
    CustomTime              CurrentTime
    ----------              -----------
    2024-05-25 20:42:24.380 2024-05-25 20:42:24.385
#>
$my_obj | Out-Host
<#
    CustomTime              CurrentTime
    ----------              -----------
    2024-05-25 20:42:24.380 2024-05-25 20:42:24.392
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    获取一个对象支持的所有方法后
    从中过滤出前5个方法
#>
($file_list)[0] | Get-Member -MemberType Method | Select-Object -First 5 | Out-Host
<#
    TypeName:System.IO.FileInfo

    Name         MemberType Definition
    ----         ---------- ----------
    AppendText   Method     System.IO.StreamWriter AppendText()
    CopyTo       Method     System.IO.FileInfo CopyTo(string destFileName), System.IO.FileInfo CopyTo(string destFileName, bool overwrite)
    Create       Method     System.IO.FileStream Create()
    CreateObjRef Method     System.Runtime.Remoting.ObjRef CreateObjRef(type requestedType)
    CreateText   Method     System.IO.StreamWriter CreateText()
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# 调用一个对象的方法时,省略掉()可以获取对象方法的详细定义
($file_list)[0].AppendText | Format-List * | Out-Host
<#
    MemberType          : Method
    OverloadDefinitions : {System.IO.StreamWriter AppendText()}
    TypeNameOfValue     : System.Management.Automation.PSMethod
    Value               : System.IO.StreamWriter AppendText()
    Name                : AppendText
    IsInstance          : True
#>
