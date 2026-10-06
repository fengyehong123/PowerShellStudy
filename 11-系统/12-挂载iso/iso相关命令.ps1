# 1. 挂载 ISO
Mount-DiskImage -ImagePath "C:\Users\Think\Downloads\Windows10.iso"

# 2. 找到 ISO 被挂载到哪个盘符
Get-DiskImage -ImagePath "C:\Users\Think\Downloads\Windows10.iso" | Get-Volume

# 3. 检查 EFI 启动文件
Get-ChildItem E:\EFI\BOOT\

# 4. 检查完卸载
Dismount-DiskImage -ImagePath "C:\Users\Think\Downloads\Windows10.iso"