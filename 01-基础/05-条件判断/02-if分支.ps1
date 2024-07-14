$num = 8

if ($num -gt 15) {
    "$($num)大于15" | Out-Host
} elseif ($num -lt 15) {
    "$($num)小于15" | Out-Host
} else {
    "$($num)等于15" | Out-Host
}

# 8小于15