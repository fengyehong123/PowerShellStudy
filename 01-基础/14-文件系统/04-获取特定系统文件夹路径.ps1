<#
    [Environment]::GetFolderPath()
        用来获取系统中的特定文件夹
#>
[Environment]::GetFolderPath('Desktop') | Out-Host
# C:\Users\XXX\Desktop

# GetFolderPath()目录的类型可以在枚举值SpecialFolder中找到
[Environment]::GetFolderPath([Environment+SpecialFolder]::Desktop) | Out-Host
# C:\Users\XXX\Desktop
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    在 [System.Environment+SpecialFolder] 中，+ 符号的作用是表示 SpecialFolder 是 Environment 类的内部嵌套枚举。
    这种语法指示了 SpecialFolder 枚举是定义在 Environment 类中的一个内部枚举，而不是一个独立的类或命名空间。
    在 C# 和 PowerShell 中，使用 + 来表示内部类或嵌套枚举的关系。
#>
[System.Environment+SpecialFolder] `
| Get-Member -Static -MemberType Property `
| Select-Object -ExpandProperty Name | Out-Host
<#
    AdminTools     
    ApplicationData
    CDBurning
    CommonAdminTools      
    CommonApplicationData 
    CommonDesktopDirectory
    CommonDocuments       
    CommonMusic
    CommonOemLinks        
    CommonPictures        
    CommonProgramFiles    
    CommonProgramFilesX86 
    CommonPrograms        
    CommonStartMenu       
    CommonStartup
    CommonTemplates       
    CommonVideos
    Cookies
    Desktop
    DesktopDirectory
    Favorites
    Fonts
    History
    InternetCache
    LocalApplicationData
    LocalizedResources
    MyComputer
    MyDocuments
    MyMusic
    MyPictures
    MyVideos
    NetworkShortcuts
    Personal
    PrinterShortcuts
    ProgramFiles
    ProgramFilesX86
    Programs
    Recent
    Resources
    SendTo
    StartMenu
    Startup
    System
    SystemX86
    Templates
    UserProfile
    Windows
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# ⏹预览GetFolderPath()支持的目录内容
[System.Environment+SpecialFolder] `
| Get-Member -static -memberType Property `
| ForEach-Object {
    "{0,-25}=     {1}" -f $_.name, [Environment]::GetFolderPath($_.Name) 
}
<#
    AdminTools               =     C:\Users\XXX\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Administrative Tools
    ApplicationData          =     C:\Users\XXX\AppData\Roaming
    CDBurning                =     C:\Users\XXX\AppData\Local\Microsoft\Windows\Burn\Burn
    CommonAdminTools         =     C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Administrative Tools
    CommonApplicationData    =     C:\ProgramData
    CommonDesktopDirectory   =     C:\Users\Public\Desktop
    CommonDocuments          =     C:\Users\Public\Documents
    CommonMusic              =     C:\Users\Public\Music
    CommonOemLinks           =
    CommonPictures           =     C:\Users\Public\Pictures
    CommonProgramFiles       =     C:\Program Files (x86)\Common Files
    CommonProgramFilesX86    =     C:\Program Files (x86)\Common Files
    CommonPrograms           =     C:\ProgramData\Microsoft\Windows\Start Menu\Programs
    CommonStartMenu          =     C:\ProgramData\Microsoft\Windows\Start Menu
    CommonStartup            =     C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup
    CommonTemplates          =     C:\ProgramData\Microsoft\Windows\Templates
    CommonVideos             =     C:\Users\Public\Videos
    Cookies                  =     C:\Users\XXX\AppData\Local\Microsoft\Windows\INetCookies
    Desktop                  =     C:\Users\XXX\Desktop
    DesktopDirectory         =     C:\Users\XXX\Desktop
    Favorites                =     C:\Users\XXX\Favorites
    Fonts                    =     C:\WINDOWS\Fonts
    History                  =     C:\Users\XXX\AppData\Local\Microsoft\Windows\History
    InternetCache            =     C:\Users\XXX\AppData\Local\Microsoft\Windows\INetCache
    LocalApplicationData     =     C:\Users\XXX\AppData\Local
    LocalizedResources       =
    MyComputer               =
    MyDocuments              =     C:\Users\XXX\Documents
    MyMusic                  =     C:\Users\XXX\Music
    MyPictures               =     C:\Users\XXX\Pictures
    MyVideos                 =     C:\Users\XXX\Videos
    NetworkShortcuts         =     C:\Users\XXX\AppData\Roaming\Microsoft\Windows\Network Shortcuts
    Personal                 =     C:\Users\XXX\Documents
    PrinterShortcuts         =     C:\Users\XXX\AppData\Roaming\Microsoft\Windows\Printer Shortcuts
    ProgramFiles             =     C:\Program Files (x86)
    ProgramFilesX86          =     C:\Program Files (x86)
    Programs                 =     C:\Users\XXX\AppData\Roaming\Microsoft\Windows\Start Menu\Programs
    Recent                   =     C:\Users\XXX\AppData\Roaming\Microsoft\Windows\Recent
    Resources                =     C:\WINDOWS\resources
    SendTo                   =     C:\Users\XXX\AppData\Roaming\Microsoft\Windows\SendTo
    StartMenu                =     C:\Users\XXX\AppData\Roaming\Microsoft\Windows\Start Menu
    Startup                  =     C:\Users\XXX\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
    System                   =     C:\WINDOWS\system32
    SystemX86                =     C:\WINDOWS\SysWOW64
    Templates                =     C:\Users\XXX\AppData\Roaming\Microsoft\Windows\Templates
    UserProfile              =     C:\Users\XXX
    Windows                  =     C:\WINDOWS
#>

