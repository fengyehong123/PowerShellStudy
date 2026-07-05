@echo off
cd /d %~dp0

:INPUT_CHECK_USERNAME
SET username=
SET /P username=请输入用户名: 
IF "%username%"=="" GOTO :INPUT_CHECK_USERNAME

:INPUT_CHECK_PASSWORD
SET password=
SET /P password=请输入密码: 
IF "%password%"=="" GOTO :INPUT_CHECK_PASSWORD

echo 用户输入的用户名为: %username%
echo 用户输入的密码为: %password%
:: echo( 的作用是用来换行
echo(

:: 执行当前目录下的java文件, java需要配置环境变量
java Hello.java
echo(

echo 运行成功!
pause