<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ page import="org.myweb.first.notice.model.dto.Notice" %>
<%
	Notice notice = (Notice)request.getAttribute("notice");
%> --%>
<!-- EL 로 대체함 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%-- 요청 url 을 따로 지정 --%>
<c:url var="nup" value="nmoveup.do">
	<c:param name="no" value="${ notice.noticeNo }"/>
</c:url>

<c:url var="ndel" value="ndelete.do">
	<c:param name="no" value="${ notice.noticeNo }"/>
	<c:param name="rfile" value="${ notice.renameFilePath }"/>	
</c:url>
<script type="text/javascript">
//수정 페이지로 이동 버튼 클릭시 작동하는 함수
function moveUpdatePage(){
	location.href = "${nup}";
}

//삭제하기 버튼 클릭시 작동하는 함수
function requestDelete(){
	location.href = "${ndel}";
}

</script>
</head>
<body>
<%-- <%@ include file="../common/menubar.jsp" %> --%>
<c:import url="/WEB-INF/views/common/menubar.jsp"/>
<hr>

<h2 align="center">${ notice.noticeNo } 번 공지글 상세보기 (관리자용)</h2>
<br>
<table align="center" width="500" border="1" cellspacing="0" cellpadding="5">
	<tr>
		<th>제 목</th>
		<td>${ notice.noticeTitle }</td>
	</tr>
	<tr>
		<th>작성자</th>
		<td>${ notice.noticeWriter }</td>
	</tr>
	<tr>
		<th>등록날짜</th>
		<td><fmt:formatDate value="${ notice.noticeDate }" pattern="yyyy년 MM월 dd일 hh시 mm분 ss초"/></td>
	</tr>
	<tr>
		<th>중요도</th>
		<td>${ notice.importance }</td>
	</tr>
	<tr>
		<th>중요도 설정 종료 날짜</th>
		<td><fmt:formatDate value="${ notice.impEndDate }" pattern="yyyy년 MM월 dd일 hh시 mm분 ss초"/></td>
	</tr>
	<c:if test="${ !empty notice.originalFilePath }">
	<tr>
		<th>첨부파일</th>
		<td>
			<c:url var="nfdown" value="nfdown.do">
				<c:param name="ofile" value="${ notice.originalFilePath }"/>
				<c:param name="rfile" value="${ notice.renameFilePath }"/>
			</c:url>
			<a href="${ nfdown }">${ notice.originalFilePath }</a>
		</td>
	</tr>
	</c:if>
	<tr>
		<th>내용</th>
		<td>${ notice.noticeContent }</td>
	</tr>
	<tr>
		<th colspan="2">
			<button onclick="moveUpdatePage(); return false;">수정페이지로 이동</button> &nbsp;
			<button onclick="requestDelete(); return false;">삭제하기</button> &nbsp;
			<button onclick="javascript:location.href=${pageContext.servletContext.contextPath}/nlist.do">목록</button> &nbsp;
			<button onclick="javascript: history.go(-1); return false;">이전 페이지로 이동</button>
		</th>
	</tr>
</table>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>