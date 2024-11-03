Function New-RandomChineseChars {
    
    Param([int]$Count = 1)

    if($Count -lt 0){
        return ''
    }
    
    $rand = New-Object Random
    1..$Count | ForEach-Object {
        #0x4e00 -> 0x9fa5+1
        [Convert]::ToChar($rand.Next(19968,40870))
    }
}

# 调用函数，生成10个随机中文字符
(New-RandomChineseChars -Count 10) -join ''