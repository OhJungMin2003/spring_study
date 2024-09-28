package org.myweb.first.test.model.dto;

public class Test implements java.io.Serializable {
	private static final long serialVersionUID = 4708397828141028895L;

	private String name;  	//NAME	VARCHAR2(30 BYTE)
	private int age;		//AGE	NUMBER
	
	public Test() {
		super();
	}

	public Test(String name, int age) {
		super();
		this.name = name;
		this.age = age;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Test [name=" + name + ", age=" + age + "]";
	}
}
