# 指定pom文件的路径
$xmlFilePath = "$($PSScriptRoot)\00-pom.xml"
if (-not (Test-Path $xmlFilePath)) {
    return
}

# PowerShell原生支持对xml文件的解析
# 获取pom文件内容, 指定获取获取到的是xml数据
[xml]$pomFile = Get-Content -Path $xmlFilePath -Raw
# 获取pom文件中的所有依赖
$dependencyArray = $pomFile.project.dependencies.dependency

$dependencyArray | ForEach-Object {
    [PSCustomObject]@{
        GroupId    = $_.groupId
        ArtifactId = $_.artifactId
        Version    = $_.version
    }
} | Out-Host
<#
    GroupId                  ArtifactId                     Version
    -------                  ----------                     -------
    org.springframework.boot spring-boot-starter-thymeleaf
    org.springframework.boot spring-boot-starter-web
    org.mybatis.spring.boot  mybatis-spring-boot-starter    2.2.2
    org.springframework.boot spring-boot-starter-validation
    org.springframework.boot spring-boot-starter-mail
    org.springframework.boot spring-boot-starter-aop
    org.springframework.boot spring-boot-devtools
    org.apache.commons       commons-lang3                  3.9
    mysql                    mysql-connector-java
    org.projectlombok        lombok                         1.18.30
    org.springframework.boot spring-boot-starter-test
    org.apache.poi           poi                            3.17
    org.apache.poi           poi-ooxml                      3.17
    commons-beanutils        commons-beanutils              1.9.1
#>