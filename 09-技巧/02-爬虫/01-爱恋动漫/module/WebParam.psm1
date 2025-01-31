function New-WebSession {

    # 创建 WebRequestSession
    $session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
    $session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36"

    # 添加固定的 Cookies
    $session.Cookies.Add((New-Object System.Net.Cookie("user_script_url", "%2F%2F1.acgscript.com%2Fscript%2Fmiobt%2F4.js%3F3", "/", "www.kisssub.org")))
    $session.Cookies.Add((New-Object System.Net.Cookie("user_script_rev", "20181120.2", "/", "www.kisssub.org")))
    $session.Cookies.Add((New-Object System.Net.Cookie("visitor_test", "human", "/", "www.kisssub.org")))

    # 处理 `Hm_lvt_bab0ae65b49b7efd4fde9bf6858ec60b` Cookie
    $cookieValues = "1717296243", "1717901135", "1718526665", "1718624754"
    foreach ($value in $cookieValues) {
        $session.Cookies.Add((New-Object System.Net.Cookie("Hm_lvt_bab0ae65b49b7efd4fde9bf6858ec60b", $value, "/", ".kisssub.org")))
    }

    return $session
}

# 请求头
function New-RequestHeader {
    return @{
        "authority"="www.kisssub.org"
        "method"="GET"
        "scheme"="https"
        "accept"="text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7"
        "accept-encoding"="gzip, deflate, br"
        "accept-language"="zh-CN,zh;q=0.9,ja;q=0.8,en;q=0.7,zh-TW;q=0.6"
        "cache-control"="max-age=0"
        "sec-ch-ua"="`"Not=A?Brand`";v=`"99`", `"Chromium`";v=`"118`""
        "sec-ch-ua-mobile"="?0"
        "sec-ch-ua-platform"="`"Windows`""
        "sec-fetch-dest"="document"
        "sec-fetch-mode"="navigate"
        "sec-fetch-site"="none"
        "sec-fetch-user"="?1"
        "upgrade-insecure-requests"="1"
    }
}

# 导出函数，使其可以被外部调用
Export-ModuleMember -Function New-WebSession, New-RequestHeader