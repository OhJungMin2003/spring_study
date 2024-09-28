<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%  //스크립트릿(scriptlet) 태그 : 일반 자바 구문 작성, 조건문, 반복문 등 작성되면 됨
	String message = (String)request.getAttribute("message");
%>  --%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>first : error</title>
</head>
<body>
<%-- <h1>오류 발생 : <%= message %></h1> --%>
<h1>오류 발생 : <%= request.getAttribute("message") %></h1> <%-- 전송값 바로 꺼내서 출력 처리할 수도 있음 --%>
<%-- expression(표시) tag : 자바 코드로 바꾸면 out.print(message) 와 같음 
	out.print(message); 또는 out.print(request.getAttribute("message")); 로 변환됨
	out.print(request.getAttribute("message");); 에러 발생함 () 얀에 ; 사용하면 안됨
--%>
<a href="javascript:history.go(-1);">이전 페이지로 이동</a> &nbsp; <a href="main.do">Home</a>
</body>
</html>