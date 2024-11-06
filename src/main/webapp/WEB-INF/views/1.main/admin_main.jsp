<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="admin_header.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style type="text/css">
.greeting {
	text-align: center; /* 텍스트를 중앙 정렬 */
    position: absolute; /* 절대 위치 지정 */
    top: 50%; /* 세로 중앙 */
    left: 50%; /* 가로 중앙 */
    transform: translate(-50%, -50%); /* 중앙으로 이동 */
}
</style>
<title>SAMIL</title>
</head>
<body>
	<h1 class="greeting">
		<c:choose>
			<c:when test="${emp.admin==170}">마스터 ${emp.name}님, 안녕하세요!</c:when>
			<c:when test="${emp.admin==100}">인사 담당자 ${emp.name}님, 안녕하세요!</c:when>
			<c:when test="${emp.admin==110}">결재 담당자 ${emp.name}님, 안녕하세요!</c:when>
			<c:when test="${emp.admin==120}">급여 담당자 ${emp.name}님, 안녕하세요!</c:when>
			<c:when test="${emp.admin==130}">비용 담당자 ${emp.name}님, 안녕하세요!</c:when>
			<c:when test="${emp.admin==140}">근태 담당자 ${emp.name}님, 안녕하세요!</c:when>
			<c:when test="${emp.admin==150}">게시판 담당자 ${emp.name}님, 안녕하세요!</c:when>
			<c:when test="${emp.admin==160}">일정 담당자 ${emp.name}님, 안녕하세요!</c:when>
		</c:choose>
	</h1>
</body>
</html>
