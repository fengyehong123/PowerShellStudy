# 来源
# https://www.pstips.net/powershell-using-static-methods.html

<#
    ⏹Powershell将信息存储在对象中，每个对象都会有一个具体的类型
        简单的文本会以System.String类型存储
        日期会以System.DateTime类型存储
    任何.NET对象都可以通过GetType()方法返回它的类型，该类型中有一个FullName属性，可以查看类型的完整名称。
#>
(Get-Date).GetType().FullName | Out-Host
# System.DateTime
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹每一种类型都 可以包含一些静态的方法，
    可以通过方括号和类型名称得到类型对象本身，
    然后通过 Get-Memeber 命令查看该类型支持的所有静态方法。
#>
Get-Date | Get-Member -Static -MemberType *Method | Select-Object -First 5 | Out-Host
<#
    TypeName:System.DateTime

    Name         MemberType Definition
    ----         ---------- ----------
    Compare      Method     static int Compare(datetime t1, datetime t2)
    DaysInMonth  Method     static int DaysInMonth(int year, int month)
    Equals       Method     static bool Equals(datetime t1, datetime t2), static bool Equals(System.Object objA, System.Object objB)
    FromBinary   Method     static datetime FromBinary(long dateData)
    Parse        Method     static datetime Parse(string s), static datetime Parse(string s, System.IFormatProvider provider), static datetime Parse(string s, System.IFormatProvider provider, System.Globalization.DateTimeStyles styles)
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹Get-Date 命令得到的类型为 System.DateTime 类型
    我们可以使用静态方法将字符串转换为 DateTime 类
#>
[System.DateTime]::Parse("2024-10-13 23:42:55") | Out-Host  # 2024年10月13日 23:42:55
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# ⏹判断是否为闰年
[System.DateTime]::IsLeapYear(2000) | Out-Host  # True
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# ⏹打印2008年到2024年的所有闰年
for ($year = 2008; $year -le 2024; $year++) {
    if ([System.DateTime]::IsLeapYear($year)) {
        $year | Out-Host
    }
}
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# ⏹只获取整数部分
[Math]::Truncate(2012.7765) | Out-Host  # 2012
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# ⏹将IP字符串转换为System.Net.IPAddress实例
$ip_instance = [Net.IPAddress]'10.3.129.71'
$ip_instance | Out-Host
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# ⏹根据IP地址查看域名
[system.Net.Dns]::GetHostByAddress('8.8.8.8') | Format-List * 
<#
    HostName    : dns.google
    Aliases     : {}
    AddressList : {8.8.8.8}
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# ⏹根据域名查看IP地址
[System.Net.Dns]::GetHostAddresses('www.pstips.net') | Out-Host
<#
    Address            : 1514094196
    AddressFamily      : InterNetwork
    ScopeId            :
    IsIPv6Multicast    : False
    IsIPv6LinkLocal    : False
    IsIPv6SiteLocal    : False
    IsIPv6Teredo       : False
    IsIPv4MappedToIPv6 : False
    IPAddressToString  : 116.62.63.90
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹查看程序集
        .NET中的类型定义在不同的程序集中，首先得知道当前程序已经加载了那些程序集。
        使用AppDomain类可以完成这个需求
        该类中有一个静态成员CurrentDomain
        而CurrentDomain中有一个GetAssemblies()方法
#>
[AppDomain]::CurrentDomain.GetAssemblies() | Select-Object -First 5 | Out-Host
<#
    GAC    Version        Location
    ---    -------        --------
    True   v4.0.30319     C:\Windows\Microsoft.NET\Framework\v4.0.30319\mscorlib.dll
    True   v4.0.30319     C:\WINDOWS\Microsoft.Net\assembly\GAC_MSIL\Microsoft.PowerShell.ConsoleHost\v4.0_3.0.0.0__31bf3856ad364e35\Microsoft.PowerShell.ConsoleHost.dll
    True   v4.0.30319     C:\WINDOWS\Microsoft.Net\assembly\GAC_MSIL\System\v4.0_4.0.0.0__b77a5c561934e089\System.dll
    True   v4.0.30319     C:\WINDOWS\Microsoft.Net\assembly\GAC_MSIL\System.Core\v4.0_4.0.0.0__b77a5c561934e089\System.Core.dll
    True   v4.0.30319     C:\WINDOWS\Microsoft.Net\assembly\GAC_MSIL\System.Management.Automation\v4.0_3.0.0.0__31bf3856ad364e35\System.Management.Automation.dll
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹搜索程序集中的指定类型
        → 使用 GetExportedTypes() 方法

    ⏹查找包含 environment 关键字的类型
    部分对象的 Location 属性为空,因此需要进行排除
#>
[AppDomain]::CurrentDomain.GetAssemblies() | ForEach-Object {
    if ($_.Location -ne $null) {
        $_.GetExportedTypes()
    }
} | Where-Object {$_ -like '*environment*'} |
ForEach-Object {$_.FullName} | Out-Host

<#
    新版的.NET 中有动态类型, 不能直接通过GetExportedTypes()调用
    通过 -not $_.IsDynamic 来过滤掉就好
    和 $_.Location -ne $null 的目的相同
#>
[AppDomain]::CurrentDomain.GetAssemblies() |
Where-Object {-not $_.IsDynamic} | ForEach-Object {$_.GetExportedTypes()} |
Where-Object {$_ -like '*environment*'} | ForEach-Object {$_.FullName} | Out-Null
<#
    System.EnvironmentVariableTarget
    ⭕System.Environment
    System.Security.Permissions.EnvironmentPermissionAccess
    System.Security.Permissions.EnvironmentPermission
    System.Security.Permissions.EnvironmentPermissionAttribute
    System.Runtime.InteropServices.RuntimeEnvironment
    System.Environment+SpecialFolderOption
    System.Environment+SpecialFolder
    Microsoft.PowerShell.Commands.EnvironmentProvider
    System.Web.Configuration.HostingEnvironmentSection
    System.Web.Hosting.HostingEnvironment
    System.ServiceModel.Configuration.ServiceHostingEnvironmentSection
    System.ServiceModel.ServiceHostingEnvironment
    Microsoft.PowerShell.DesiredStateConfiguration.Internal.DotNet.Environment
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹我们通过 environment 关键字,在加载的程序集中找到了System.Environment类
    这个类可以做很多事情,我们可以先查看一下该类的所有的静态方法
#>
[System.Environment] | Get-Member -Static | Out-Host
<#
    TypeName:System.Environment

    Name                       MemberType Definition
    ----                       ---------- ----------
    Equals                     Method     static bool Equals(System.Object objA, System.Object objB)
    Exit                       Method     static void Exit(int exitCode)
    ExpandEnvironmentVariables Method     static string ExpandEnvironmentVariables(string name)
    FailFast                   Method     static void FailFast(string message), static void FailFast(string message, System.Exception exception)
    GetCommandLineArgs         Method     static string[] GetCommandLineArgs()
    GetEnvironmentVariable     Method     static string GetEnvironmentVariable(string variable), static string GetEnvironmentVariable(string variable, System.EnvironmentVariableTarget target)
    GetEnvironmentVariables    Method     static System.Collections.IDictionary GetEnvironmentVariables(), static System.Collections.IDictionary GetEnvironmentVariables(System.EnvironmentVariableTarget target)
    GetFolderPath              Method     static string GetFolderPath(System.Environment+SpecialFolder folder), static string GetFolderPath(System.Environment+SpecialFolder folder, System.Environment+SpecialFolderOption option)
    GetLogicalDrives           Method     static string[] GetLogicalDrives()
    ReferenceEquals            Method     static bool ReferenceEquals(System.Object objA, System.Object objB)
    SetEnvironmentVariable     Method     static void SetEnvironmentVariable(string variable, string value), static void SetEnvironmentVariable(string variable, string value, System.EnvironmentVariableTarget target)
    CommandLine                Property   static string CommandLine {get;}
    CurrentDirectory           Property   static string CurrentDirectory {get;set;}
    CurrentManagedThreadId     Property   static int CurrentManagedThreadId {get;}
    ExitCode                   Property   static int ExitCode {get;set;}
    HasShutdownStarted         Property   static bool HasShutdownStarted {get;}
    Is64BitOperatingSystem     Property   static bool Is64BitOperatingSystem {get;}
    Is64BitProcess             Property   static bool Is64BitProcess {get;}
    MachineName                Property   static string MachineName {get;}
    NewLine                    Property   static string NewLine {get;}
    OSVersion                  Property   static System.OperatingSystem OSVersion {get;}
    ProcessorCount             Property   static int ProcessorCount {get;}
    StackTrace                 Property   static string StackTrace {get;}
    SystemDirectory            Property   static string SystemDirectory {get;}
    SystemPageSize             Property   static int SystemPageSize {get;}
    TickCount                  Property   static int TickCount {get;}
    UserDomainName             Property   static string UserDomainName {get;}
    UserInteractive            Property   static bool UserInteractive {get;}
    UserName                   Property   static string UserName {get;}
    Version                    Property   static version Version {get;}
    WorkingSet                 Property   static long WorkingSet {get;}
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹根据System.Environment中的属性输出
        当前登录域
        用户名
        机器名
#>
# 多行字符串配合变量的方式组成字符串
Write-Host @"
当前的登录域为: $([System.Environment]::UserDomainName)
当前的用户名为: $([System.Environment]::UserName)
当前的机器名为: $([System.Environment]::MachineName)
"@


