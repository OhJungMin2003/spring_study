<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<!-- <h1>Welcome!!!</h1> -->
<!-- 웰컴 요청(첫페이지 접속)이 오면, main 페이지가 나가도록 요청을 전달함 (forwarding)
	첫페이지 요청 url : http://domain/ => 개발시에는 http://localhost:톰켓포트번호/context-root명/
	예) http://localhost:8088/first
 -->
<%--  <%
 	//스프링에서는 뷰페이지(*.jsp) 내보내기도 모두 컨트롤러에서 리턴되어서 뷰리졸버를 거쳐서 나와야 됨
 	/* RequestDispatcher view = request.getRequestDispatcher("main.do");
 	view.forward(request, response); */
 	request.getRequestDispatcher("main.do").forward(request, response); 	
 %> --%>
 <%-- jsp 표준액션 태그를 사용한다면 --%>
 <jsp:forward page="main.do" />
</body>
</html>