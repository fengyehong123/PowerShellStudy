# 域名
$domain = 'http://www.kisssub.org'
# 搜索关键字,通过 [System.Uri]::EscapeDataString 对汉字进行编码
$enCoded_search_keyword = [System.Uri]::EscapeDataString("重返青春+猎户发布组+简日")
# 请求地址
$my_url = "$($domain)/search.php?keyword=$($enCoded_search_keyword)"

# session
$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.0.0 Safari/537.36"
$session.Cookies.Add((New-Object System.Net.Cookie("user_script_url", "%2F%2F1.acgscript.com%2Fscript%2Fmiobt%2F4.js%3F3", "/", "www.kisssub.org")))
$session.Cookies.Add((New-Object System.Net.Cookie("user_script_rev", "20181120.2", "/", "www.kisssub.org")))

# 请求头
$my_header = @{
    "Accept"="text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"
    "Accept-Encoding"="gzip, deflate"
    "Accept-Language"="zh-CN,zh;q=0.9,ja;q=0.8,en;q=0.7,zh-TW;q=0.6"
    "Cache-Control"="no-cache"
    "Pragma"="no-cache"
    "Upgrade-Insecure-Requests"="1"
}

# 发送网络请求
$response = Invoke-WebRequest -UseBasicParsing `
-Uri $my_url `
-WebSession $session `
-Headers $my_header

# 提取磁力链接所在页面的url
$target_web_urls = $response.Links.outerHTML | ForEach-Object {

    if (-not ($_ -match ".*show.*.html")) {
        return
    }

    # 提取出目标页面的url
    $_.split(" ")[1].replace("href=`"", "$($domain)/").replace("`"", "")
}
$target_web_urls | Out-Host
<#
    http://www.kisssub.org/show-1856d8521c4d0e69c8533aad207d5e4e95d69fdf.html
    ......
#>

<#
    ⏹创建一个workflow,用于并发处理多任务
#>
workflow Get-WebContent {

    param (
        [string[]] $urls
    )

    <#
        ⏹foreach -parallel 是 Workflow 中用来并行处理迭代集合的语法
        每个 $url 都会并行处理，即同时发送多个请求以提高效率
    #>
    foreach -parallel ($url in $urls) {

        # ⏹InlineScript 块允许在 Workflow 中执行本地的 PowerShell 脚本或命令
        $web_response = InlineScript {
            # 发送网络请求
            $webRequest = Invoke-WebRequest -UseBasicParsing -Uri $using:url -Headers $my_header
            # 获取页面上的所有url连接
            $webRequest.Links.outerHTML
        }

        # PSCustomObject 是自定义对象的数据类型
        [PSCustomObject]@{
            Content = $web_response
        }

        # 每次请求后等待一秒
        Start-Sleep -Seconds 1
    }
}

Write-Host "⇓⇓⇓⇓⇓⇓⇓⇓⇓⇓⇓⇓提取到的磁力链接如下⇓⇓⇓⇓⇓⇓⇓⇓⇓⇓⇓⇓" -ForegroundColor Red

<#
    创建HTMLFile对象
    该 COM 对象依赖于系统中安装的 Internet Explorer(IE)
#>
$doc = New-Object -ComObject "HTMLFile"

# 调用workflow,获取响应
$results = Get-WebContent -urls $target_web_urls
$results.Content | ForEach-Object {

    # 如果不是磁力链接的url,就跳过
    if (-not ($_ -match ".*ref=`"magnet.*")) {
        return
    }

    # 将网页tag文本解析为document对象
    $doc.IHTMLDocument2_write($_)
    # 根据id获取href属性(磁力链接内容)
    $doc.getElementById("magnet").href
}

# 释放doc对象
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($doc) | Out-Null

# 暂停
Pause