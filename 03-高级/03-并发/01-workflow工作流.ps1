# 用法示例参考 爬虫

workflow Get-WebContent {
    param (
        [string[]] $urls
    )
  
    foreach -parallel ($url in $urls) {
        $response = InlineScript {
            Invoke-WebRequest -Uri $using:url
        }
        [PSCustomObject]@{
            Url = $url
            Content = $response.Links.outerHTML
        }
    }
  }
  
  # 调用工作流
Get-WebContent -urls $urls | Out-Host