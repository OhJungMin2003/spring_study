<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- 
<%@ page import="org.myweb.first.member.model.dto.Member" %> 
<%
	//로그인 상태를 확인하기 위해서 세션 객체에 저장된 로그인한 회원의 정보를 추출
	//User loginUser = (User)session.getAttribute("loginUser");
	Member loginUser = (Member)session.getAttribute("loginUser");
%>   --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>first</title>
<style type="text/css">
div.lineA {
	height: 100px;
	border: 1px solid gray;
	float: left;
	position: relative;
	left: 120px;
	margin: 5px;
	padding: 5px;
}

div#banner {
	width: 500px;
	padding: 0;
}

div#banner img {
	width: 450px;
	height: 80px;
	padding: 0;
	margin-top: 10px;
	margin-left: 25px;
}

div#loginBox {
	width: 280px;
	font-size: 10pt;
	text-align: left;
	padding-left: 20px;
}

div#loginBox button {
	width: 250px;
	height: 35px;
	background-color: navy;
	color: white;
	margin-top: 10px;
	margin-bottom: 15px;
	font-size: 14pt;
	font-weight: bold;
	cursor: pointer; /* 손가락모양 : 클릭 가능한 버튼으로 표시함 */
}

div#loginBox a {
	text-decoration: none;
	color: navy;
}
</style>
<%-- juery 파일 로드 --%>
<!-- <script type="text/javascript" src="/first/resources/js/jquery-3.7.1.min.js"></script> -->
<script type="text/javascript"
	src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
	function movePage() {
		//자바스크립트로 페이지 연결 또는 서블릿 컨트롤러 연결 요청시에는
		//location 객체의 href 속성을 사용함 
		location.href = "loginPage.do";
	}

	$(function() {
		//최근 등록된 공지글 3개 (top-N) 전송받아서 출력 처리
		$.ajax({
			url : 'ntop3.do',
			type : 'post',
			dataType : 'json',
			success : function(data) {
				console.log('success : ' + data); //[object object]

				//object -> String
				var str = JSON.stringify(data);

				//string-> json : parsing
				var json = JSON.parse(str);

				values = '';
				for ( var i in json.nlist) {
					values += '<tr><td>'
							+ json.nlist[i].no
							+ '</td><td><a href="ndetail.do?no='
							+ json.nlist[i].no
							+ '">'
							+ decodeURIComponent(json.nlist[i].title).replace(
									/\+/gi, ' ') + '</td><td>'
							+ json.nlist[i].date + '</td></tr>'
				}
				$('#newnotice').html($('#newnotice').html() + values);
			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.log('error : ' + jqXHR + "," + textStatus + ","
						+ errorThrown);
			}

		}); //ajax : ntop.do

		//조회수 많은 인기 게시글 3개 (top-N 전송받아서 출력처리)
		$.ajax({
			url : 'btop3.do',
			type : 'post',
			dataType : 'json',
			success : function(data) {
				console.log('success : ' + data); //[object object]

				//object -> String
				var str = JSON.stringify(data);

				//string-> json : parsing
				var json = JSON.parse(str);

				values = '';
				for ( var i in json.blist) {
					values += '<tr><td>'
							+ json.blist[i].bnum
							+ '</td><td><a href="bdetail.do?bnum='
							+ json.blist[i].bnum
							+ '">'
							+ decodeURIComponent(json.blist[i].btitle).replace(
									/\+/gi, ' ') + '</td><td>'
							+ json.blist[i].rcount + '</td></tr>'
				}
				$('#toplist').html($('#toplist').html() + values);
			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.log('error : ' + jqXHR + "," + textStatus + ","
						+ errorThrown);
			}

		});
	});//jQuery.document.ready(function(){});
</script>
</head>
<body>
	<h1>first Spring Project : first</h1>
	<%-- 메뉴바 표시 --%>
	<%-- <%@ include file="menubar.jsp" %> --%>
	<%-- jstl 에서는 / 가 /context-root 를 의미함 
	속성 url 은 브라우저 상단에 표시되는 페이지 경로에 대한 url 을 의미함
	기본 웰컴 페이지 url 이 http://localhost:8088/first 이므로
	기본 url 뒤에 표기될 추가 url 로 보면 됨
	전체 url : http://localhost:8088/first/WEB-INF/views/common/menubar.jsp 로 표기해도 됨
	기본 url 은 생략할 수 있으므로
	url : /WEB-INF/views/common/menubar.jsp 만 표기해도 됨
--%>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<hr>
	<header>
		<div id="banner" class="lineA">
			<img src="/first/resources/images/photo2.jpg">
		</div>
		<%-- <% if(loginUser == null){  //로그인 하지 않은 상태일 때 %> --%>
		<c:if test="${ empty sessionScope.loginUser }">
			<div id="loginBox" class="lineA">
				first 사이트 방문을 환영합니다.<br>
				<button onclick="movePage();">first 로그인</button>
				<br>
				<%-- 로그인 버튼을 클릭하면 자바스크립트 movePage() 함수가 실행되게 해서, 로그인 페이지가 나타나게 처리함 --%>
				<a href="enrollPage.do">회원가입</a>
				<%-- 회원가입 클릭하면 회원가입페이지가 연결되어 출력되게 링크 설정했음 --%>
			</div>
		</c:if>
		<%-- <% }else{  //로그인 했을 때 %> --%>
		<c:if test="${ !empty sessionScope.loginUser }">
			<div id="loginBox" class="lineA">
				${ sessionScope.loginUser.userName } 님 &nbsp; <a href="logout.do">로그아웃</a>
				<br> 메일 0, 쪽지 0 <br>
				<%-- a 태그로 서비스를 위한 url 요청시, 값도 같이 보내려면 쿼리스트링을 사용해야 함
				url?전송이름=보낼값&전송이름=보낼값
				?전송이름=보낼값&전송이름=보낼값 : 쿼리스트링(queryString) 이라고 함
				주의 : 쿼리스트링에는 공백 있으면 안됨
			 --%>
				<a href="myinfo.do?userId=${ sessionScope.loginUser.userId }">내
					정보 보기</a>
			</div>
		</c:if>
		<%-- <% } %> --%>

	</header>
	<hr style="clear: both;">

	<!-- 최근 등록된 공지글 3개 출력 : ajax -->
	<div
		style="float: left; border: 1px solid navy; padding: 5px; margin: 5px; margin-left: 150px;">
		<h4>새로운 공지사항</h4>
		<table id="newnotice" border="1" cellspacing="0" width="350">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>날짜</th>
			</tr>
		</table>
	</div>

	<!-- 조회수 많은 인기 게시글 3개 출력 : ajax -->
	<div
		style="float: left; border: 1px solid navy; padding: 5px; margin: 5px; margin-left: 50px;">
		<h4>인기 게시글</h4>
		<table id="toplist" border="1" cellspacing="0" width="350">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>조회수</th>
			</tr>
		</table>
	</div>


	<hr style="clear: both;">
	<%-- jsp 파일 안에 별도로 작성된 jsp(권장), html 파일을 포함할 수 있다.
	주의 : 상대경로만 사용할 수 있음
 --%>
	<%-- <%@ include file="footer.jsp" %> --%>
	<c:import url="/WEB-INF/views/common/footer.jsp" />


</body>
</html>