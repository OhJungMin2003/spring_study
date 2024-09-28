<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- page 지시자(directive) 태그는 jsp 파일 안에서 한번만 사용해야 함
	이 페이지(jsp 파일)의 설정 관련 속성으로 값을 지정함
	단, import 속성만 page 지시자 태그를 별도로 분리해서 작성할 수 있음
 --%> 
<%-- <%@ page import="org.myweb.first.member.model.dto.Member" %>    
<%
	Member loginUser = (Member)session.getAttribute("loginUser");
%> --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
nav > ul#menubar {
	list-style: none;
	position: relative;
	left: 150px;
}
nav > ul#menubar li {
	float: left;
	width: 120px;
	height: 30px;
	margin-right: 5px;
	padding: 0;
}
nav > ul#menubar li a {
	text-decoration: none;
	width: 120px;
	height: 30px;
	display: block;
	background: orange;
	color: navy;
	text-align: center;
	font-weight: bold;
	margin: 0;
	text-shadow: 1px 1px 2px white;
	padding-top: 5px;
}
nav > ul#menubar li a:hover {
	text-decoration: none;
	width: 120px;
	height: 30px;
	display: block;
	background: navy;
	color: white;
	text-align: center;
	font-weight: bold;
	margin: 0;
	text-shadow: 1px 1px 2px white;
	padding-top: 5px;
}
hr { clear: both; }
</style>
</head>
<body>
<%-- 로그인하지 않았을 때 --%>
<%-- <% if(loginUser == null){ %> --%>
<c:if test="${ empty sessionScope.loginUser }">
	<nav>
	<ul id="menubar">
		<li><a href="main.do">Home</a></li>
		<li><a href="nlist.do?page=1">공지사항</a></li>
		<li><a href="blist.do?page=1">게시글</a></li>
		<li><a href="moveAjax.do">ajax처리</a></li>
		<li><a href="moveApi.do">api처리</a></li>
	</ul>
	</nav>
</c:if>
<%-- <% }else if(loginUser.getAdminYN().equals("Y")){ %> --%>
<%-- 관리자가 로그인했을 때 --%>
<c:if test="${ !empty sessionScope.loginUser and sessionScope.loginUser.adminYN eq 'Y' }">
	<nav>
	<ul id="menubar">
		<li><a href="main.do">Home</a></li>
		<li><a href="nlist.do?page=1">공지사항관리</a></li>
		<li><a href="blist.do?page=1">게시글관리</a></li>
		<li><a href="mlist.do?page=1">회원관리</a></li>		
	</ul>
	</nav>
</c:if>
<%-- <% }else if(loginUser != null & loginUser.getAdminYN().equals("N")){ %> --%>
<%-- 일반 회원이 로그인했을 때 --%>
<c:if test="${ !empty sessionScope.loginUser and sessionScope.loginUser.adminYN eq 'N' }">
	<nav>
	<ul id="menubar">
		<li><a href="main.do">Home</a></li>
		<li><a href="nlist.do?page=1">공지사항</a></li>
		<li><a href="blist.do?page=1">게시글</a></li>
		<li><a href="moveAjax.do">ajax처리</a></li>
		<li><a href="moveApi.do">api처리</a></li>
		<li><a href="myinfo.do?userId=${ sessionScope.loginUser.userId }">my page</a></li>
	</ul>
	</nav>
</c:if>
<%-- <% } %> --%>


</body>
</html>




