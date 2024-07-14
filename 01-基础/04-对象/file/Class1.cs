using System;
using System.Collections.Generic;
using System.Text;
using System.Net;

// 使用该C#代码编译为 Test.ddl 文件
namespace Test
{
	public class Student
	{
		public string Name { set; get; }
		public int Age { set; get; }
		public Student(string name, int age)
		{
			this.Name = name;
			this.Age = age;
		}
		public override string ToString()
		{
			return string.Format("Name={0};Age={1}", this.Name, this.Age);
		}
	}
}
