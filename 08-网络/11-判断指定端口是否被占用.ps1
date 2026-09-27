# 方式一
netstat -ano | findstr :9096

# 方式二
Get-NetTCPConnection -LocalPort 9096 -State Listen
