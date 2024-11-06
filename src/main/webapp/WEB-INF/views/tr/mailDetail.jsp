<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../1.main/user_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메일 내용</title>
<style type="text/css">
main {
	padding: 30px 10%;
	background-color: #fff;
	margin: 20px auto;
	margin-top: 50px;
	border-radius: 8px;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
}

th, td {
	padding: 12px;
	border: 2px solid #ddd;
	text-align: left;
}

th {
	background-color: #034EA2; /* 회색 헤더 배경 */
	color: white;
	font-size: 16px;
	text-align: center;
	width: 200px;
}

#back {
	display: inline-block;
	margin-top: 20px;
	padding: 10px 15px;
	background-color: #B0BEC5; /* 회색 버튼 배경 */
	color: white;
	text-decoration: none;
	border-radius: 4px;
	text-align: center;
}

#back:hover {
	background-color: #90A4AE; /* 마우스 오버 시 색상 */
}

.button {
	display: inline-block;
	padding: 10px 15px;
	margin: 5px;
	background-color: #034EA2; /* 버튼 배경색 */
	color: white; /* 글자색 */
	text-decoration: none; /* 밑줄 제거 */
	border-radius: 5px; /* 둥근 모서리 */
	transition: background-color 0.3s; /* 호버 효과 전환 */
}

.button:hover {
	background-color: #0056b3; /* 호버 시 배경색 변화 */
}

#divButton {
	margin-bottom: 40px;
}
</style>
</head>
<body>
	<main>

		<div class="btn-group" role="group" aria-label="Basic example"
			id="divButton">
			<a class="btn btn-outline-primary" href="mail?empno=${emp.empno}">전체메일함</a>
			<a class="btn btn-outline-primary" href="readMail?empno=${emp.empno}">읽은메일함</a>
			<a class="btn btn-outline-primary"
				href="notReadMail?empno=${emp.empno}">안읽은메일함</a> <a
				class="btn btn-outline-primary"
				href="importantMail?empno=${emp.empno}">중요메일함</a> <a
				class="btn btn-outline-primary" href="sendMail?empno=${emp.empno}">보낸메일함</a>
			<a class="btn btn-outline-primary" aria-current="page"
				href="trashMail?empno=${emp.empno}">휴지통</a>
		</div>

		<table>
			<tr>
				<th>제목</th>
				<td>${mail.mailTitle}</td>
			</tr>
			<tr>
				<th>보낸 사람</th>
				<td><c:forEach var="sendName" items="${mailSendNameList}">
						<c:if test="${sendName.empno eq mail.sendAddress}">${sendName.name}</c:if>
					</c:forEach></td>
			</tr>
			<tr>
				<th>메일 본문</th>
				<td>${mail.mailCnt}</td>
			</tr>
		</table>
	</main>
</body>
</html>
