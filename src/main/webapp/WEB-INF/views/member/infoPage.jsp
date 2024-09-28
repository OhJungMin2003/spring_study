<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%-- <%@ page import="org.myweb.first.member.model.dto.Member" %>   
<%
	Member member = (Member)request.getAttribute("member");
%>  --%>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>first</title>
<style type="text/css">
	table th {  background-color: #9ff;  }
	table#outer { border: 2px solid navy;  }
</style>
<script type="text/javascript">
window.onload = function(){
	//input type="file" 이 선택한 사진파일 이미지 미리보기 처리
	var photofile = document.getElementById("photofile");
	photofile.addEventListener('change', function(event){
		const files = event.currentTarget.files;
		const file = files[0];
		console.log(file.name);  //선택한 파일명 확인
		
		//선택한 파일을 img 태그의 src 속성 값으로 적용함 :이미지 변경될 것임
		const myphoto = document.getElementById("photo");
		//myphoto.src = '서버측에 있는 이미지파일의 상대|절대경로/' + file.name; //서버측에 있는 파일일 때 사용하는 방법임
		//클라이언트 컴퓨터에 있는 파일은 src 속성으로 적용할 수 없음
		
		//클라이언트 컴퓨터에 있는 사진파일을 읽어들여서 출력되게 처리해야 함 (파일입력 > 출력처리)
		const reader = new FileReader();  //파일읽기 객체 생성
		//람다(lambda) 스트림 방식 사용
		//이벤트콜백함수 실행구문(기존 방식) : reader.onload = function(e){ 읽어들이기 처리 };
		reader.onload = (e) => {  //e : event 객체
			myphoto.setAttribute('src', e.target.result); //e.target : 이벤트 발생 대상(읽어들인 파일정보)
			myphoto.setAttribute('data-file', file.name);
		};
		reader.readAsDataURL(file);  //읽어서 img 에 적용 출력됨
	});
};  //window.onload

function validate(){
	//수정하기 전송 보내기 전에 암호와 암호확인이 일치하지 않는지 확인
	var pwdValue = document.getElementById('userPwd').value;
	var pwdValue2 = document.getElementById('userPwd2').value;
	if(pwdValue !== pwdValue2){
		alert('암호와 암호확인이 일치하지 않습니다. 다시 입력하세요.');
		document.getElementById('userPwd').value = '';  //기록된 값 지우기
		document.getElementById('userPwd2').value = '';  //기록된 값 지우기
		document.getElementById('userPwd').focus();  //입력커서 지정함
		return false;  //전송 취소함
	}	
	
	//변경된 암호의 값 형식이 요구한 대로 구성되였는지 검사
	//정규 표현식(Regular Expression) 사용함
	
	return true;  //전송보냄
}  //validate()
</script>
</head>
<body>
<%-- 메뉴바 표시 --%>
<%-- <%@ include file="../common/menubar.jsp" %> --%>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<hr>

<h1 align="center">내 정보 보기 페이지</h1>
<br>
<form action="mupdate.do" method="post" onsubmit="return validate();" enctype="multipart/form-data">
	<%-- 뷰페이지에서는 보이지 않으면서, 서버로 폼 안의 값들이 전송될 때 숨겨서 같이 보내야 하는 값 처리 --%>
	<input type="hidden" name="originalUserPwd" value="${ requestScope.member.userPwd }">
	<input type="hidden" name="ofile" value="${ requestScope.ofile }">
<table id="outer" align="center" width="700" cellspacing="5" cellpadding="0">
	<tr><th colspan="2">등록된 회원님의 정보는 아래와 같습니다.<br>
		수정할 내용이 있으면 변경하고, 수정하기 버튼을 누르세요.
	</th></tr>	
	<tr><th width="120">아이디</th>
		<td>
			<input type="text" name="userId" id="userId" value="${ requestScope.member.userId }" readonly> 
		</td></tr>
	<tr><th>사진첨부</th>
		<%-- 파일로 전송한다면, input type="file" 로 지정하면 됨, 첨부된 사진 미리보기 안됨 --%>
		<!-- <td><input type="file" name="photoFileName"></td> -->
		<%-- 첨부된 사진 미리보기가 되도록 하고자 한다면 --%>
		<td>
			<%-- 선택한 사진파일 미리보기용 영역 지정 : 서버로는 전송되지 않음 --%>
			<div id="myphoto" style="margin:0;width:150px;height:160px;padding:0;border:1px solid navy;">
				<%-- 사진 첨부가 없을 경우를 위한 미리보기용 이미지 출력되게 설정함 --%>
				<img src="/first/resources/photo_files/${ requestScope.member.photoFileName }" id="photo" 
				style="width:150px;height:160px;border:1px solid navy;display:block;margin:0;padding:0;" 
				alt="사진을 드래그 드롭하세요.">
			</div> <br>
			<%-- <%  //첨부된 파일명이 원래 파일명으로 표시되게 처리함
				//파일명 앞에 붙은 "userid_" 글자를 제외시킴
				String filename = member.getPhotoFileName().substring(member.getPhotoFileName().indexOf('_') + 1);
			%> --%>
			${ requestScope.ofile } <br>
			변경할 사진 선택 : <input type="file" id="photofile" name="photofile"> 
			<%-- name 속성의 이름은 필드명과 별개로 지정함
				파일업로드 실패시 파일명만 문자열로 command 객체에 저장되지 않게 하기 위함
			 --%>
		</td>
	</tr>
	<tr><th>암 호</th><td><input type="password" name="userPwd" id="userPwd"></td></tr>
	<tr><th>암호확인</th><td><input type="password" id="userPwd2"></td></tr>
	<tr><th>이 름</th>
	<td><input type="text" name="userName" id="userName" value="${ requestScope.member.userName }" readonly></td></tr>
	<tr><th>성 별</th>
		<td>
		<%-- <% if(member.getGender().equals("M")){ %> --%>
		<c:if test="${ requestScope.member.gender eq 'M' }">
			<input type="radio" name="gender" value="M" checked> 남자 &nbsp;
			<input type="radio" name="gender" value="F"> 여자
		</c:if>
		<%-- <% }else if(member.getGender().equals("F")){ %> --%>
		<c:if test="${ requestScope.member.gender eq 'F' }">
			<input type="radio" name="gender" value="M" > 남자 &nbsp;
			<input type="radio" name="gender" value="F" checked> 여자
		</c:if>
		<%-- <% } %> --%>
		</td>
	</tr>
	<tr><th>나 이</th><td><input type="number" name="age" min="19" value="${ member.age }" ></td></tr>
	<tr><th>전화번호</th><td><input type="tel" name="phone" value="${ member.phone }" ></td></tr>
	<tr><th>이메일</th><td><input type="email" name="email" value="${ member.email }" ></td></tr>
	<tr><th colspan="2">
		<input type="submit" value="수정하기"> &nbsp; 
		<%-- <a href="mdelete.do?userid=${ member.userId }">탈퇴하기</a>  --%>	
		<c:url var="mdel" value="mdelete.do">
			<c:param name="userid" value="${ requestScope.member.userId }" />
		</c:url>
		<a href="${ mdel }">탈퇴하기</a> 	
	</th></tr>
</table>
</form>

<hr>
<%-- <%@ include file="../common/footer.jsp" %> --%>
<c:import url="/WEB-INF/views/common/footer.jsp" />

</body>
</html>