// ��ȡ�����·��
var shell = WScript.CreateObject("WScript.Shell");
var desktopPath = shell.SpecialFolders("Desktop");

// ���� FileSystemObject �����ļ�����, ����ļ��в����ھʹ���
var fso = WScript.CreateObject("Scripting.FileSystemObject");
if (!fso.FolderExists(desktopPath)) {
    fso.CreateFolder(desktopPath);
    WScript.Echo("�Ѵ����ļ���: " + desktopPath);
}

// Ҫд����ļ���·��
var filePath = desktopPath + "\\hello.txt";

// ���ļ���2 = ForWriting��true = �Զ�������
var ts = fso.OpenTextFile(filePath, 2, true);
ts.WriteLine("Hello World from JScript + WSH!");
ts.Close();
WScript.Echo("��д���ļ�: " + filePath);

// �� WScript.Shell �򿪼��±���ʾ�ļ�
shell.Run("notepad.exe " + filePath);
