param(
    [Parameter(Mandatory=$true)]
    [string]$JsonPath,
    [string]$CsvPath = "output.csv"
)

# 判断路径是否存在
if (-not (Test-Path -Path $JsonPath)) {
    Write-Error "错误: 文件不存在 -> $JsonPath"
    exit 1
}

# 判断是否是文件
if (-not (Test-Path -Path $JsonPath -PathType Leaf)) {
    Write-Error "错误: 指定路径不是文件 -> $JsonPath"
    exit 1
}

# 读取 JSON
try {
    # 指定 utf-8 编码读取文件内容
    $json = Get-Content $JsonPath -Raw -Encoding UTF8 -ErrorAction Stop | ConvertFrom-Json
} catch {
    Write-Error "错误: JSON 解析失败。可能格式不合法。"
    exit 1
}
Write-Host "JSON 文件验证成功，开始处理..."
# -----------------------------------------------------------------------------

function Expand-Json {
    param(
        $InputObject,
        $Prefix = "",
        $BaseRow = [ordered]@{}
    )

    $rows = @($BaseRow)

    if ($InputObject -is [psobject]) {

        foreach ($prop in $InputObject.PSObject.Properties) {

            $propName = if ($Prefix) {
                "$Prefix.$($prop.Name)"
            } else {
                $prop.Name
            }

            $value = $prop.Value

            # ---------- 数组 ----------
            if ($value -is [System.Collections.IEnumerable] -and -not ($value -is [string])) {

                $newRows = @()

                foreach ($item in $value) {

                    foreach ($row in $rows) {

                        $clone = [ordered]@{}
                        foreach ($k in $row.Keys) {
                            $clone[$k] = $row[$k]
                        }

                        if ($item -is [psobject]) {
                            $expanded = Expand-Json -InputObject $item -Prefix $propName -BaseRow $clone
                            $newRows += $expanded
                        }
                        else {
                            $clone[$propName] = $item
                            $newRows += $clone
                        }
                    }
                }

                $rows = $newRows
            }
            # ---------- 子对象 ----------
            elseif ($value -is [psobject]) {

                $newRows = @()

                foreach ($row in $rows) {

                    $clone = [ordered]@{}
                    foreach ($k in $row.Keys) {
                        $clone[$k] = $row[$k]
                    }

                    $expanded = Expand-Json -InputObject $value -Prefix $propName -BaseRow $clone
                    $newRows += $expanded
                }

                $rows = $newRows
            }
            # ---------- 标量 ----------
            else {
                foreach ($row in $rows) {
                    $row[$propName] = $value
                }
            }
        }
    }

    return $rows
}

# 顶层数据
$final = @()

if ($json -is [System.Collections.IEnumerable] -and -not ($json -is [string])) {
    foreach ($item in $json) {
        $final += Expand-Json -InputObject $item
    }
} else {
    $final = Expand-Json -InputObject $json
}

$finalObjects = $final | ForEach-Object {
    [pscustomobject]$_
}

# 导出为csv文件
$finalObjects | Export-Csv -Path $CsvPath -NoTypeInformation -Encoding UTF8

Write-Host "数据库风格 JSON 扁平化完成 -> $CsvPath"