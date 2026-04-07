$jsonPath = "$($PSScriptRoot)\00-data.json"

# 添加 -Raw 保证整文件读取, 而不是按行读取;
[Object[]]$jsonObjArray  = Get-Content -Path $jsonPath `
                                  -Raw `
                                  -Encoding UTF8 | ConvertFrom-Json

# 遍历获取到的json对象
foreach ($jsonOb in $jsonObjArray) {
    
    Write-Host "$($jsonOb.Id)"
    Write-Host "$($jsonOb.Name)"
    Write-Host "$($jsonOb.Age)"
    Write-Host "$($jsonOb.Hobbies)"
    Write-Host '+ -------------------------------- +'
}
Write-Host '==========================================================' -ForegroundColor Red

[PSCustomObject]$person = @{
    Id = 1000
    Name = "张三"
    Age = 100
    Addrss = @("地球", "月球")
}

# 对象转换为json字符串
$person | ConvertTo-Json | Out-Host
<#
    {
        "Age":  100,
        "Name":  "张三",
        "Id":  1000,
        "Addrss":  [
                    "地球",
                    "月球"
                ]
    }
#>
Write-Host '==========================================================' -ForegroundColor Red