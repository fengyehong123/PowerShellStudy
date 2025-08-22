[IO.DirectoryInfo]$user_path = Get-Item "$env:LocalAppData"
Write-Host "$user_path"

# 提取书签的函数
function Get-EdgeBookmarks {
    param (
        [Parameter(Mandatory)]
        [pscustomobject]$Node
    )

    if ($Node.type -eq "url") {
        [PSCustomObject]@{
            Name = $Node.name
            URL  = $Node.url
        }
    } elseif ($Node.children) {
        foreach ($child in $Node.children) {
            Get-EdgeBookmarks -Node $child
        }
    }
}

# Edge浏览器的书签默认保存在下面这个路径中
$bookmarkPath = "$env:LocalAppData\Microsoft\Edge\User Data\Default\Bookmarks"

# 将书签的内容读取为json
$bookmarksJson = Get-Content -Path $bookmarkPath -Raw -Encoding UTF8 | ConvertFrom-Json

# 将书签json中的网址部分解析出来
$bookmarkBar = $bookmarksJson.roots.bookmark_bar
Get-EdgeBookmarks -Node $bookmarkBar | Out-Host

Pause