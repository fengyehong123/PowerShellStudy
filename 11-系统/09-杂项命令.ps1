# 更新策略
gpupdate /force

# 查看当前用户所拥有的策略
whoami /priv

# 事件查看器
eventvwr

# 查看任务计划程序
taskschd.msc

# 打开凭证管理器
control /name Microsoft.CredentialManager

# 打开Internet属性
control /name Microsoft.InternetOptions

# 打开网络代理
Start-Process ms-settings:network-proxy

# 打开环境变量
rundll32.exe sysdm.cpl,EditEnvironmentVariables