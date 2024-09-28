package org.myweb.first.member.model.dto;

import java.sql.Date;

//dto (vo, entity, bean) 작성 규칙
//1. 반드시 직렬화할 것
//2. 모든 필드(멤버변수, property) 반드시 private : 캡슐화할 것
//3. 기본생성자, 매개변수 있는 생성자 작성할 것
//4. 모든 필드에 대한 getter and setter 작성할 것
//5. toString() 오버라이딩
//선택 : equals(), clone(), hashCode() 오버라이딩
public class Member implements java.io.Serializable {
	private static final long serialVersionUID = -4190375229839038309L;

	private String userId;  //USERID	VARCHAR2(50 BYTE)
	private String userPwd; //USERPWD	VARCHAR2(100 BYTE)
	private String userName; //USERNAME	VARCHAR2(20 BYTE)
	private String gender;  //GENDER	CHAR(1 BYTE)
	private int age;   //AGE	NUMBER(3,0)
	private String phone;  //PHONE	VARCHAR2(13 BYTE)
	private String email;   //EMAIL	VARCHAR2(30 BYTE)
	private java.sql.Date enrollDate;  //ENROLL_DATE	DATE
	private java.sql.Date lastModified;  //LASTMODIFIED	DATE
	private String signType;  //SIGNTYPE	VARCHAR2(10 BYTE)
	private String adminYN;  //ADMIN_YN	CHAR(1 BYTE)
	private String loginOk;  //LOGIN_OK	CHAR(1 BYTE)
	private String photoFileName;  //PHOTO_FILENAME	VARCHAR2(100 BYTE)
	
	public Member() {
		super();
	}

	public Member(String userId, String userPwd, String userName, String gender, int age, 
			String phone, String email) {
		super();
		this.userId = userId;
		this.userPwd = userPwd;
		this.userName = userName;
		this.gender = gender;
		this.age = age;
		this.phone = phone;
		this.email = email;
	}

	public Member(String userId, String userPwd, String userName, String gender, int age, 
			String phone, String email,
			Date enrollDate, Date lastModified, String signType, String adminYN, String loginOk, 
			String photoFileName) {
		super();
		this.userId = userId;
		this.userPwd = userPwd;
		this.userName = userName;
		this.gender = gender;
		this.age = age;
		this.phone = phone;
		this.email = email;
		this.enrollDate = enrollDate;
		this.lastModified = lastModified;
		this.signType = signType;
		this.adminYN = adminYN;
		this.loginOk = loginOk;
		this.photoFileName = photoFileName;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public java.sql.Date getEnrollDate() {
		return enrollDate;
	}

	public void setEnrollDate(java.sql.Date enrollDate) {
		this.enrollDate = enrollDate;
	}

	public java.sql.Date getLastModified() {
		return lastModified;
	}

	public void setLastModified(java.sql.Date lastModified) {
		this.lastModified = lastModified;
	}

	public String getSignType() {
		return signType;
	}

	public void setSignType(String signType) {
		this.signType = signType;
	}

	public String getAdminYN() {
		return adminYN;
	}

	public void setAdminYN(String adminYN) {
		this.adminYN = adminYN;
	}

	public String getLoginOk() {
		return loginOk;
	}

	public void setLoginOk(String loginOk) {
		this.loginOk = loginOk;
	}

	public String getPhotoFileName() {
		return photoFileName;
	}

	public void setPhotoFileName(String photoFileName) {
		this.photoFileName = photoFileName;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Member [userId=" + userId + ", userPwd=" + userPwd + ", userName=" + userName + ", gender=" + gender
				+ ", age=" + age + ", phone=" + phone + ", email=" + email + ", enrollDate=" + enrollDate
				+ ", lastModified=" + lastModified + ", signType=" + signType + ", adminYN=" + adminYN + ", loginOk="
				+ loginOk + ", photoFileName=" + photoFileName + "]";
	}
}
