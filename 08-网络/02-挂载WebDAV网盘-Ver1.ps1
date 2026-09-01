$WebDavUrl = "https://jike.teracloud.jp/dav/"

# 提示用户输入
$Username = Read-Host "请输入用户名"
$SecurePassword = Read-Host "请输入密码" -AsSecureString

# 将加密输入的密码转换为明文密码
$bstrAddress = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePassword)
$Password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstrAddress)

try {
    # 使用传统的 net use 挂载 WebDAV 到Z盘
    net use Z: $WebDavUrl /user:$Username $Password /persistent:yes
    
    $Password = $null
    # 立即触发垃圾回收，清理未引用的内存
    [System.GC]::Collect() 
} catch {
    Write-Host "脚本运行时发生异常:"
    Write-Host "$_" -ForegroundColor Red
    Write-Host "堆栈跟踪: $($_.Exception.StackTrace)" -ForegroundColor Gray
}

Read-Host "按 Enter 键退出..."
