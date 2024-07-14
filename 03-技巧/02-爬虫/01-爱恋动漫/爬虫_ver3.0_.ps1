param(
    [string]$key = "青春"
)

# 域名
$domain = 'http://www.kisssub.org'
# 搜索关键字,通过 [System.Uri]::EscapeDataString 对汉字进行编码
$enCoded_search_keyword = [System.Uri]::EscapeDataString($key)
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

# 引入创建html解析库,解析整个网页
Add-Type -Path ".\HtmlAgilityPack.dll"
$htmlDoc = New-Object HtmlAgilityPack.HtmlDocument
$htmlDoc.LoadHtml($response.Content)

# 通过XPath选择器选中最后一页的元素
$xPath_Selecter = "//div[@class='pages clear']/a[@class='nextprev']/preceding-sibling::a[1]"
$last_page_tag = $htmlDoc.DocumentNode.SelectSingleNode($xPath_Selecter)

# 打印当前网页的总页码
Write-Host "当前网页的总页码为: $($last_page_tag.InnerText) 页"

# 暂停
Pause