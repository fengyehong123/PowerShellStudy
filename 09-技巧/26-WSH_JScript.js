// 输出到控制台
WScript.Echo("Hello from JScript");

var argList = WScript.Arguments;
for (var i = 0; i < argList.length; i++) {
    var argVal = argList(i);
    WScript.Echo(argVal);
}

// 获取当前脚本的全路径
var jsPath = WScript.ScriptFullName;
WScript.Echo(jsPath);  // E:\My_Project\PowerShellStudy\09-技巧\26-WSH_JScript.js

// 获取js文件的名称
var jsFileName = WScript.ScriptName;
WScript.Echo(jsFileName);  // 26-WSH_JScript.js
WScript.Echo("-------------------------------------------------");

// 创建一个 WshShell 对象，用于系统级别的操作
// 在Powershell脚本中, 也可以通过 【$shell = New-Object -ComObject WScript.Shell】 的方式来创建
var shell = WScript.CreateObject("WScript.Shell");

// 执行一个cmd脚本命令
WScript.Echo("-------------------------------------------------");
var cmd = "cmd.exe /c dir";
var exec = shell.Exec(cmd);
var result = exec.StdOut.ReadAll();
WScript.Echo(result);
WScript.Echo("-------------------------------------------------");
