<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../1.main/user_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
	main {
	    padding: 30px 10%;
	    background-color: #fff;
	    margin: 20px auto;
	    border-radius: 8px;
	}
	
	table {
	    margin: 20px auto;
	    width: 100%;
	    border-collapse: collapse;
	    border-radius: 8px;
	    overflow: hidden;
	    text-align: center;
		border: 1px solid #BDBDBD; /* 테이블 외부 테두리 설정 */
	}
	
	td {
	    border-color: #007acc;
	    color: #333333;
	    overflow: hidden;
	    padding: 10px 5px;
	    word-break: normal;
	    border: 1px solid #BDBDBD;
	    border-left: none; /* 왼쪽 세로선 제거 */
        border-right: none; /* 오른쪽 세로선 제거 */
	}
	
	th {
	    background-color: #034EA2;
	    border-color: #005999;
	    color: #ffffff;
	    font-size: 14px;
	    font-weight: normal;
	    overflow: hidden;
	    padding: 10px 5px;
	    word-break: normal;
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
    h2 {
	    color: #034EA2;
	    border-bottom: 2px solid #034EA2; /* 언더라인 색상 */
	    padding-bottom: 5px; /* 텍스트와 언더라인 사이의 여백 */
	    margin-bottom: 20px; /* 아래쪽 여백 */
	    font-weight: bold; /* 글자 두께 */
	    display: inline-block; /* 텍스트 너비만큼만 표시 */
	}
	.goMail:hover {
	background: gray;
}
	
</style>
<title>메일</title>
</head>
<body>
	<main>
		<h2>중요 메일함</h2>
		<hr color="#3333CC">
		<p>
		<a class="button" href="sendMailForm">메일작성</a>
		
		<div class="btn-group" role="group" aria-label="Basic example">
			<a class="btn btn-outline-primary" href="mail?empno=${emp.empno}">전체메일함</a> 
			<a class="btn btn-outline-primary"href="readMail?empno=${emp.empno}">읽은메일함</a> 
			<a class="btn btn-outline-primary" href="notReadMail?empno=${emp.empno}">안읽은메일함</a>
			<a class="btn btn-outline-primary active" href="importantMail?empno=${emp.empno}">중요메일함</a> 
			<a class="btn btn-outline-primary"	href="sendMail?empno=${emp.empno}">보낸메일함</a> 
			<a class="btn btn-outline-primary" aria-current="page"href="trashMail?empno=${emp.empno}">휴지통</a>
		</div>
<form action="deleteMail" method="post">
		<table border="1">
			<thead>
				<tr>
						<th>보낸사람</th>
						<th style="width: 70%">제목</th>
						<th>읽음여부</th>
						<th>보낸시간</th>
						<th>삭제</th>
						<th>중요메일</th>
				</tr>
			</thead>
			<tbody>
				
					<c:forEach var="mail" items="${mailList}">
						<tr class="goMail">
							<td onclick="location.href='/tr/mailDetail?mailNo=${mail.mailNo}'"><c:forEach var="sendName" items="${mailSendNameList}">
						<c:if test="${sendName.empno eq mail.sendAddress}">${sendName.name}</c:if>
						</c:forEach>
						</td>
							<td onclick="location.href='/tr/mailDetail?mailNo=${mail.mailNo}'">${mail.mailTitle}</td>
							<td onclick="location.href='/tr/mailDetail?mailNo=${mail.mailNo}'"><c:choose>
									<c:when test="${mail.mailRead == 1}"><img src="/upload/openmail.png" width="20"></c:when>
									<c:when test="${mail.mailRead == 0}"><img src="/upload/unopenmail.png" width="20"></c:when>
								</c:choose></td>
							<td>${mail.sendDate}</td>
							<td><input type='checkbox' name='maildelete' value='${mail.mailNo}'/></td>
							<td><a href="/tr/importantMailCheck?empno=${emp.empno}&mailNo=${mail.mailNo}&mailBox=3"><c:choose>
									<c:when test="${mail.important == 1}"><img src="<%=request.getContextPath()%>/tr/important.png" width="20"></c:when>
									<c:when test="${mail.important == 0}"><img src="<%=request.getContextPath()%>/tr/unimportant.png" width="20"></c:when>
								</c:choose></a></td>
						</tr>
					</c:forEach>
			</tbody>
		</table>
				<div style="text-align: right; margin-top: 20px;">
						<input type="text" value="${emp.empno}" name="empno" hidden="hidden">
						<input type="submit" value="선택삭제">
				</div>
		</form>
	</main>
</body>
</html>