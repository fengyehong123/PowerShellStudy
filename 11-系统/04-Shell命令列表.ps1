<#
    Shell 命令是另一种更直观的快捷方式，直接在【运行】对话框或资源管理器地址栏输入 shell:命令名 即可,
    比 CLSID 更好记。
#>

# 通过 Start-Process 的方式进行调用
Start-Process "shell:Personal"

# 通过资源管理器的参数进行调用
explorer.exe "shell:Personal"

##############################
# 常用用户文件夹
##############################
# shell:Profile	    当前用户的根目录
# shell:Personal	当前用户的“文档”文件夹
# shell:Downloads	当前用户的“下载”文件夹
# shell:Desktop	    当前用户的“桌面”
# shell:My Pictures	当前用户的“图片”
# shell:My Music	当前用户的“音乐”
# shell:My Video	当前用户的“视频”
# shell:Favorites	当前用户的IE收藏夹
# shell:Contacts	当前用户的联系人文件夹
# shell:Links	    当前用户的链接文件夹

##############################
# 系统与隐藏文件夹
##############################
# shell:Startup	            用户启动文件夹（管理开机自启程序）
# shell:Common Startup	    系统启动文件夹（对所有用户生效）
# shell:AppData	            漫游应用数据文件夹（Roaming AppData）
# shell:Local AppData	    本地应用数据文件夹（Local AppData）
# shell:SendTo	            “发送到”菜单文件夹
# shell:Recent	            最近使用的文件历史记录
# shell:Programs	        开始菜单中的程序文件夹
# shell:Common Programs	    系统级开始菜单程序文件夹
# shell:Cookies	            IE Cookies 文件夹
# shell:Cache	            IE 缓存文件夹
# shell:ConnectionsFolder	网络连接
# shell:Public	            公用共享文件夹
# shell:Common Desktop	    共享用户桌面
# shell:Common Documents	共享用户“文档”
# shell:CommonDownloads	    共享用户“下载”