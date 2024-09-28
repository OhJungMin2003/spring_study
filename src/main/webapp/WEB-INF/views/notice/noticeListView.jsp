<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>first</title>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp"/>
<hr>

<h1 align="center">공지사항</h1>
<br>
<center>
	<button>목록</button> &nbsp; &nbsp;
	<c:if test="${ !empty sessionScope.loginUser and loginUser.adminYN eq 'Y' }">
	<button onclick="javascript: location.href='${ pageContext.servletContext.contextPath }/moveWrite.do';">공지글 등록</button>
	</c:if>
</center>
<br>
<table align="center" width="500" border="1" cellspacing="0" cellpadding="0">
	<tr>
		<th>번호</th>
		<th>제목</th>
		<th>작성자</th>
		<th>첨부파일</th>
		<th>날짜</th>
	</tr>
	
	<c:forEach items="${ requestScope.list }" var="n">
		<tr>
			<td align="center">${ n.noticeNo }</td>
			<td align="center">
				<c:if test="${ n.importance eq 'Y' }">
					<img src="${pageContext.servletContext.contextPath }/resources/images/ico_notice.gif" width="15" height="15">
				</c:if>
				<a href="${pageContext.servletContext.contextPath}/ndetail.do?no=${n.noticeNo}">${ n.noticeTitle }</a>
			</td>
			<td align="center">${ n.noticeWriter }</td>
			<td align="center">
				<c:if test="${ !empty n.originalFilePath }">*</c:if>
				<c:if test="${ empty n.originalFilePath }">&nbsp;</c:if>
			</td>
			<td align="center">
				<fmt:formatDate value="${ n.noticeDate }" pattern="yyyy-MM-dd"/>
			</td>
		</tr>
	</c:forEach>
</table>

<hr>
<c:import url="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>