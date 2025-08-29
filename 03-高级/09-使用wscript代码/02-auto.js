// 获取桌面的路径
var shell = WScript.CreateObject("WScript.Shell");
var desktopPath = shell.SpecialFolders("Desktop");

// 创建 FileSystemObject 用于文件操作, 如果文件夹不存在就创建
var fso = WScript.CreateObject("Scripting.FileSystemObject");
if (!fso.FolderExists(desktopPath)) {
    fso.CreateFolder(desktopPath);
    WScript.Echo("已创建文件夹: " + desktopPath);
}

// 要写入的文件的路径
var filePath = desktopPath + "\\hello.txt";

// 打开文件（2 = ForWriting，true = 自动创建）
var ts = fso.OpenTextFile(filePath, 2, true);
ts.WriteLine("Hello World from JScript + WSH!");
ts.Close();
WScript.Echo("已写入文件: " + filePath);

// 用 WScript.Shell 打开记事本显示文件
shell.Run("notepad.exe " + filePath);
