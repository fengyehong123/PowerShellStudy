' sprict code: ANSI
' ע��: �ű��ı����ʽӦ����ANSI, ����ִ��ʧ��
' + --------------------------------------------------------
' ֱ�ӵ���Powershell����Ļ�, ����ִ���һ�����������
' ͨ��vbs�ű��ķ�ʽ����Powershell����, ͬʱͨ��vbsָ�����ش��ڵĻ�
' ���Ա��ⴰ��һ������
' + --------------------------------------------------------

' ���մ�ע�����Ĳ���
customPath = WScript.Arguments(0)
flag = ""

' �жϲ���������, ��ֹ�±�Խ��
If WScript.Arguments.Count > 1 Then
    flag = WScript.Arguments(1)
End If

' �����ű�����
Set objShell = CreateObject("Wscript.Shell")

' ƴ������
command = "powershell.exe -NoProfile -ExecutionPolicy Bypass " & _
          "-File ""E:\My_Project\PowerShellStudy\09-����\19-ѹ���ļ�.ps1"" " & _
          "-TargetFolderPath """ & customPath & """ " & _
          "-forEachCompressFlag """ & flag & """"

' ִ��������ش��ڡ��첽ִ�У�
objShell.Run command, 0, False