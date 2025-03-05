# 搜索关键词: 重返青春+猎户发布组+简日
param(
    # 参数必须输入
    [Parameter(Mandatory)]
    [string]$搜索关键词
)

# 通过模块的方式导入session和head对象
Import-Module "$($PSScriptRoot)\module\WebParam.psm1" -Function New-WebSession, New-RequestHeader

# 域名
$domain = 'http://www.kisssub.org'
# 搜索关键字,通过 [System.Uri]::EscapeDataString 对汉字进行编码
$enCoded_search_keyword = [System.Uri]::EscapeDataString($搜索关键词)
# 请求地址
$request_url = "$($domain)/search.php?keyword=$($enCoded_search_keyword)"

# 获取磁力链接所在页面的URL
function Get-WebURL {

    param (
        [string]$url
    )

    # 发送网络请求
    $response = Invoke-WebRequest -UseBasicParsing -Uri $url `
                                  -Headers $(New-RequestHeader) `
                                  -WebSession $(New-WebSession)

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
$target_web_urls = Get-WebURL -url $request_url
$target_web_urls | Out-Host

function Get-WebContent {

    param (
        [string[]]$urls
    )

    # 存储所有 Jobs 的引用
    $jobs = @()

    foreach ($url in $urls) {

        # 使用 Start-Job 启动异步任务（Job）
        $jobs += Start-Job -ScriptBlock {

            param (
                $url,
                $PSScriptPath
            )

            # 脚本块内部无法通过 $PSScriptRoot 变量来获取到当前脚本执行的路径，因此只能通过传递参数的方式
            Import-Module "$PSScriptPath\module\WebParam.psm1" -Function New-WebSession, New-RequestHeader

            # 发送网络请求
            $response = Invoke-WebRequest -UseBasicParsing -Uri $url `
                                          -WebSession $(New-WebSession) `
                                          -Headers $(New-RequestHeader)

            # 获取页面上的所有url连接
            $response.Links.outerHTML

        } -ArgumentList $url, $PSScriptRoot
    }

    # 等待所有 Jobs 完成并收集结果
    return $jobs | ForEach-Object {

        # 等待job执行完成获取job的执行结果
        $result = Receive-Job -Job $_ -Wait
        # 删除job
        Remove-Job -Job $_ -Force -ErrorAction SilentlyContinue

        # 处理 Job 的结果
        [PSCustomObject]@{
            Content = $result
        }
    }
}

Write-Host "`n开始提取磁力链接...`n" -ForegroundColor Green

<#
    github地址
        https://github.com/zzzprojects/html-agility-pack/releases/tag/v1.11.61

    下载源码后,手动编译 HtmlAgilityPack.Net40 ,得到 HtmlAgilityPack.dll
    引入 HtmlAgilityPack.dll 依赖库
#>
Add-Type -Path ".\module\HtmlAgilityPack.dll"
# 创建 HtmlDocument对象 用于解析html文本
$htmlDoc = New-Object HtmlAgilityPack.HtmlDocument

try {

    # 调用函数,获取包含各个磁力链接页面的内容
    $results = Get-WebContent -urls $target_web_urls -header $request_header

    Write-Host "⇓⇓⇓⇓⇓⇓⇓⇓⇓⇓⇓⇓提取到的磁力链接如下⇓⇓⇓⇓⇓⇓⇓⇓⇓⇓⇓⇓" -ForegroundColor Red

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

}
catch {
    Write-Host "脚本运行时发生异常: $_" -ForegroundColor Red
    Write-Host "详细信息: $($_.Exception.Message)" -ForegroundColor Yellow
    Write-Host "堆栈跟踪: $($_.Exception.StackTrace)" -ForegroundColor Gray
}

# 暂停
Pause