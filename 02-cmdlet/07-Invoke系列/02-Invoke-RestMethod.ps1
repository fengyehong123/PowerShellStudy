$apiUrl = 'https://api.github.com/users/fengyehong123';

<#
    Invoke-RestMethod 适用于访问 REST API，它会自动解析 JSON / XML 并转换为 PowerShell 对象

    Invoke-WebRequest 主要用来处理 HTML 页面、文件下载等，可以用作爬虫
#>
[PSCustomObject]$response = Invoke-RestMethod -Uri $apiUrl -Method Get

Write-Host $response
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

Write-Host $response.avatar_url

Pause