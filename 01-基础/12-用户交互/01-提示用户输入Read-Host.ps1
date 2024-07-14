$input_name = Read-Host '请输入您的姓名'
"用户输入的姓名为: $($input_name)" | Out-Host
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹如果想通过Read-Host接受敏感数据,比如密码
    可以使用 -AsSecureString 选项,这样用户输入的密码不会展示在控制台上
    不过读取到的数据是加密后的数据
#>
$input_pwd = Read-Host -AsSecureString '请输入您的密码'
"用户输入的密码为: $($input_pwd)" | Out-Host

# 可以使用下面的方法将加密之后的密码转换为普通的文本
$temp = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($input_pwd)
[Runtime.InteropServices.Marshal]::PtrToStringAuto($temp) | Out-Host
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹如果想授权一个用户需要提供用户凭据,可以使用Get-Credential命令
    该命令会弹出一个安全对话框,一旦用户输入完毕,就会返回一个Credential对象包含用户名和密码
#>
$cre = Get-Credential 贾飞天
$cre | Out-Host
<#
    UserName   Password        
    --------   --------        
    贾飞天      System.Security.SecureString
#>
