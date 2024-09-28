package org.myweb.first.member.model.dto;

//MVC 패턴에서 Model 은 도메인 모델과 비즈니스로직 처리용 모델로 구분이 됨
//dto(data transfer object : 데이터 이동용 객체) == do(domain object : 한개 행의 정보 저장용 객체)
//vo(value object : 값 저장용 객체) == entity
//db 테이블의 각 컬럼값을 저장할 목적의 클래스임 => 도메인 모델이 됨
//테스트웹 계정의 users 테이블의 한 행의 정보를 저장할 클래스임 => 컬럼과 자료형 맞춰서 필드 구성함
public class User implements java.io.Serializable {
	private static final long serialVersionUID = 7282020889404361736L;
	
	private String userId; //USERID	VARCHAR2(15 BYTE)
	private String userPwd; //USERPWD	VARCHAR2(100 BYTE)
	private String userName; //USERNAME	VARCHAR2(20 BYTE)
	
	public User() {
		super();
	}

	public User(String userId, String userPwd, String userName) {
		super();
		this.userId = userId;
		this.userPwd = userPwd;
		this.userName = userName;
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

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "User [userId=" + userId + ", userPwd=" + userPwd + ", userName=" + userName + "]";
	}	
}
