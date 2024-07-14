param(
    # 参数必须输入
    [Parameter(Mandatory)]
    # 当未添加 -name 参数时,脚本会报错
    [string]$搜索关键词
)

# 域名
$domain = 'http://www.kisssub.org'
# 搜索关键字,通过 [System.Uri]::EscapeDataString 对汉字进行编码
$enCoded_search_keyword = [System.Uri]::EscapeDataString($搜索关键词)
# 请求地址
$request_url = "$($domain)/search.php?keyword=$($enCoded_search_keyword)"

# session
$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.0.0 Safari/537.36"
$session.Cookies.Add((New-Object System.Net.Cookie("user_script_url", "%2F%2F1.acgscript.com%2Fscript%2Fmiobt%2F4.js%3F3", "/", "www.kisssub.org")))
$session.Cookies.Add((New-Object System.Net.Cookie("user_script_rev", "20181120.2", "/", "www.kisssub.org")))

# 请求头
$request_header = @{
    "Accept"="text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"
    "Accept-Encoding"="gzip, deflate"
    "Accept-Language"="zh-CN,zh;q=0.9,ja;q=0.8,en;q=0.7,zh-TW;q=0.6"
    "Cache-Control"="no-cache"
    "Pragma"="no-cache"
    "Upgrade-Insecure-Requests"="1"
}

# 获取磁力链接所在页面的URL
function Get_WEB_URL {

    param (
        [string]$url
        , [Microsoft.PowerShell.Commands.WebRequestSession]$session
        , [PSCustomObject]$header
    )

    # 发送网络请求
    $response = Invoke-WebRequest -UseBasicParsing `
    -Uri $url `
    -WebSession $session `
    -Headers $header

    # 若响应code不是200,则证明网络连接失败
    if ($response.StatusCode -ne 200) {
        Write-Host "网络请求失败..."
        return 
    }

    # 提取磁力链接所在页面的url
    $target_web_urls = $response.Links.outerHTML | ForEach-Object {

        if (-not ($_ -match ".*show.*.html")) {
            return
        }

        # 提取出目标页面的url
        $_.split(" ")[1].replace("href=`"", "$($domain)/").replace("`"", "")
    }
    return $target_web_urls
}

# 指定url,session,header 发送网络请求
$target_web_urls = Get_WEB_URL -url $request_url -session $session -header $request_header
$target_web_urls | Out-Host

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

        # 睡眠1秒
        # Start-Sleep -Seconds 1

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
    }
}

Write-Host "⇓⇓⇓⇓⇓⇓⇓⇓⇓⇓⇓⇓提取到的磁力链接如下⇓⇓⇓⇓⇓⇓⇓⇓⇓⇓⇓⇓" -ForegroundColor Red

<#
    github地址
        https://github.com/zzzprojects/html-agility-pack/releases/tag/v1.11.61

    下载源码后,手动编译 HtmlAgilityPack.Net40 ,得到 HtmlAgilityPack.dll
    引入 HtmlAgilityPack.dll 依赖库
#>
Add-Type -Path ".\HtmlAgilityPack.dll"
# 创建 HtmlDocument对象 用于解析html文本
$htmlDoc = New-Object HtmlAgilityPack.HtmlDocument

# 调用workflow,获取响应
$results = Get-WebContent -urls $target_web_urls
$results.Content | ForEach-Object {

    # 如果不是磁力链接的url,就跳过
    if (-not ($_ -match ".*ref=`"magnet.*")) {
        return
    }

    # 将含有磁力链接的html文本放到 HtmlDocument对象 中
    $htmlDoc.LoadHtml($_)

    <#
        ⏹通过xpath语法提取到a标签对象
        SelectSingleNode
            只能提取单节点
        SelectNodes
            可以提取多个节点
    #>
    $aEelement = $htmlDoc.DocumentNode.SelectSingleNode("//a[@id='magnet']")

    <#
        ⏹根据id获取href属性(磁力链接内容)
        第2个参数是默认参数
    #>
    $aEelement.GetAttributeValue("href", "")
} | Get-Unique

# 暂停
Pause