' sprict code: ANSI
' ע��: �ű��ı����ʽӦ����ANSI, ����ִ��ʧ��
' + --------------------------------------------------------
' ֱ�ӵ���Powershell����Ļ�, ����ִ���һ�����������
' ͨ��vbs�ű��ķ�ʽ����Powershell����, ͬʱͨ��vbsָ�����ش��ڵĻ�
' ���Ա��ⴰ��һ������
' + --------------------------------------------------------

' �����ű�����
Set objShell = CreateObject("Wscript.Shell")

' ƴ������
command = "powershell.exe -NoProfile -ExecutionPolicy Bypass " & _
          "-File ""E:\My_Project\PowerShellStudy\09-����\19-ѹ���ļ�.ps1"" " & _
          "-TargetFolderPath """ & WScript.Arguments(0) & """"

' ִ��������ش��ڡ��첽ִ�У�
objShell.Run command, 0, False