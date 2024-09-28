<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>EL 로 전송값 출력 : The time on the server is ${serverTime}. </P>
<P>Expression Tag 로 전송값 출력 :  The time on the server is <%= request.getAttribute("serverTime") %>. </P>
</body>
</html>
