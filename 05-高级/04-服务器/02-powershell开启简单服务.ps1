# powershell需要允许本地的脚本执行
# Set-ExecutionPolicy RemoteSigned

# 允许系统里的所有用户(包括当前账户), 监听 8080 端口的 HTTP 请求
# netsh http add urlacl url=http://+:8080/ user=Everyone

# 防火墙需要开启8080端口入站访问

# 创建监听器对象
$listener = New-Object System.Net.HttpListener

# 监听所有 IP 的 8080 端口
$listener.Prefixes.Add("http://+:8080/")
$listener.Start()
Write-Host "服务已启动，正在监听 8080 端口..."

while ($listener.IsListening) {
	
	# 响应对象
    $context = $listener.GetContext()
    $response = $context.Response
	
	# 返回的消息
    $content = [System.Text.Encoding]::UTF8.GetBytes("Hello from VM!")
	
	# 将要返回的消息添加到响应对象中
    $response.ContentLength64 = $content.Length
    $response.OutputStream.Write($content, 0, $content.Length)
    $response.Close()
	
}