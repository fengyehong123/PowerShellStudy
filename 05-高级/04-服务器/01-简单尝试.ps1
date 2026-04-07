# 端口号
$port = 8080
$tool_url = "http://localhost:$port/"

# 创建 HttpListener 对象, 并监听指定的url
$listener = New-Object System.Net.HttpListener
# 监听的 URL（必须以 / 结尾）
$listener.Prefixes.Add($tool_url)

# 启动服务器
$listener.Start()
Write-Host "服务器已启动: ${tool_url}"

# 自动打开 Edge 浏览器访问服务器
Start-Process "msedge.exe" $tool_url

# 处理请求（无限循环监听）
while ($listener.IsListening) {

    # 获取简易服务器要返回的 HTML 内容
    $html = Get-Content "$($PSScriptRoot)\01-tool.html" -Encoding UTF8
    
    # 获取响应对象
    $context = $listener.GetContext()
    $response = $context.Response

    # 转换为字节数组
    $buffer = [System.Text.Encoding]::UTF8.GetBytes($html)
    $response.ContentLength64 = $buffer.Length
    $response.ContentType = "text/html; charset=utf-8"

    # 发送响应
    $response.OutputStream.Write($buffer, 0, $buffer.Length)
    $response.OutputStream.Close()
}

# 停止监听（不会执行，除非手动终止）
$listener.Stop()
$listener.Close()
