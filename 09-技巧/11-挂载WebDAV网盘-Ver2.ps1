$WebDavUrl = "https://jike.teracloud.jp/dav/"

# 显示凭据输入框，显示UI让用户输入账号密码
$Credential = Get-Credential

try {

    # 提取用户名
    $username = $Credential.UserName
    # 提取密码(此时的密码是被加密的密码对象)
    $secureString = $Credential.Password

    <#
        SecureString
            PowerShell 和 .NET Framework 提供的一种用于安全存储敏感信息（例如密码）的数据类型。
            其内容以加密形式存储在内存中，且内容不可直接查看。
        [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR()
            通过 SecureStringToBSTR 方法，将 SecureString 的加密内容解密并存储在内存中的 BSTR（Binary String） 格式。
            BSTR 是 Windows 系统中常用的字符串格式，支持 Unicode 编码，适合与系统 API 或外部工具交互。
            返回值是一个指针，指向解密后的明文密码的内存地址。
        [System.Runtime.InteropServices.Marshal]::PtrToStringAuto()
            从指定的内存地址中读取字符串（BSTR 格式）并转换为 .NET 的 String 类型。
            PtrToStringAuto 会自动根据系统的编码（ANSI 或 Unicode）处理字符串内容。
    #>
    $bstrAddress = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secureString)
    $password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstrAddress)

    # 使用 net use 挂载 WebDAV
    net use W: $WebDavUrl /user:$username $password /persistent:yes

    # 立即触发垃圾回收，清理未引用的内存
    $password = $null
    [System.GC]::Collect()

} catch {
    Write-Host "脚本运行时发生异常:"
    Write-Host "$_" -ForegroundColor Red
    Write-Host "堆栈跟踪: $($_.Exception.StackTrace)" -ForegroundColor Gray
}

Read-Host "按 Enter 键退出..."

