<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="org.myweb.first.member.model.dto.Member"%>
<% 
	Member member = (Member)request.getAttribute("member");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>first</title>
<style type="text/css">
	table th{ background-color: #9ff, }
	table#outer { border: 2px solid navy; }
</style>
<script type="text/javascript">
	function dupIdCheck(){
		// 입력한 사용자 아아디가 사용 가능한지 확인하는 함수
		// ajax 기술 사용
		
		return false; // 버튼 클릭이벤트 취소 (submit 버튼에 클릭이벤트 전달을 막기 위함)
	}
</script>
</head>
<body>
	<h1 align="center">내 정보 보기 페이지</h1>
	<br>
	<form action="" method="post">
		<table id="outer" align="center" width="700" cellspacing="5px" cellpadding="0">
			<tr>
				<th width="120">아이디</th>
				<td>
					<input type="text" name="userId" id="userId" value="<%=member.getUserId()%>" readonly>
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="userPwd" id="userPwd"></td>
			</tr>
			<tr>
				<th>비밀번호 확인</th>
				<td><input type="password" id="userPwdChk"></td>
			</tr>
			<tr>
				<th>이름</th>
				<td>
					<input type="text" name="userName" id="userName" value="<%=member.getUserName()%>" readonly>				
				</td>
			</tr>
			<tr>
				<th>* 성별</th>
				<td>
					<%if(member.getGender().equals("M")){ %>
						<input type="radio" name="gender" value="M" checked> 남자 &nbsp;
						<input type="radio" name="gender" value="F"> 여자
					<%} else if(member.getGender().equals("F")) { %>
						<input type="radio" name="gender" value="M"> 남자 &nbsp;
						<input type="radio" name="gender" value="F" checked> 여자
					<%} %>
				</td>
			</tr>
			<tr>
				<th>* 나이</th>
				<td>
					<input type="number" name="age" min="14" placeholder="22" value="<%=member.getAge()%>" readonly>
				</td>
			</tr>
			<tr>
				<th>* 전화번호</th>
				<td>
					<input type="tel" name="phone" value="<%= member.getPhone()%>">
				</td>
			</tr>
			<tr>
				<th>* 이메일</th>
				<td>
					<input type="email" name="email" value="<%=member.getEmail()%>">
				</td>
			</tr>
			<tr>
				<th colspan="2">
					<input type="submit" value="수정하기"> &nbsp;
					<a>탈퇴하기</a> &nbsp;
					<a href="main.do">Home</a>
				</th>
			</tr>
		</table>
	</form>
</body>
</html>