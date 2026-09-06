using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

public class FileUtils
{
    public static void CreateFile()
    {
        // 定义一个List
        List<string> msgList = new List<string>()
        {
            "内容1",
            "内容2",
            "内容3"
        };

        // 获取当前用户的桌面路径
        string desktopPath = Environment.GetFolderPath(Environment.SpecialFolder.Desktop);

        // 拼接文件路径
        string filePath1 = Path.Combine(desktopPath, "aaaa.txt");
        string filePath2 = Path.Combine(desktopPath, "bbbb.txt");
        string filePath3 = Path.Combine(desktopPath, "cccc.txt");

        // 🔴方式1
        if (!File.Exists(filePath1))
        {
            string msg = "Hello World!\n你好, 世界\n";

            // 将整个字符串写入文件
            File.WriteAllText(filePath1, msg, Encoding.UTF8);

            // 将所有的行写入文件
            File.WriteAllLines(filePath2, msgList, Encoding.UTF8);

            // 追加内容到文件中
            File.AppendAllText(filePath2, "追加的内容1\r\n", Encoding.UTF8);

            // 一次追加多行
            File.AppendAllLines(filePath2, new List<string> { "追加的内容2", "追加的内容3" }, Encoding.UTF8);
        }

        // 🔴方式2
        if (!File.Exists(filePath3))
        {
            using (FileStream fs = new FileStream(filePath3, FileMode.Create))
            using (StreamWriter wr = new StreamWriter(fs, Encoding.UTF8))
            {
                foreach (string msg in msgList)
                {
                    wr.Write("--- ");
                    wr.WriteLine(msg);
                }
            }
        }

        Console.WriteLine("文件写入完成！");
    }
}
