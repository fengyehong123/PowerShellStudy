using System;

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

	public static string getInfo(string msg)
    {
        return string.Format("输入的消息是: {0}", msg);
    }
}
