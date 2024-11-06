<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../1.main/admin_header.jsp"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>출근 및 퇴근 시간 수정</title>
<style type="text/css">
body {
        font-family: Arial, sans-serif;
        background-color: #f0f0f0; /* 연한 회색 배경 */
        margin: 0;
        padding: 20px;
    }
    
    main {
        padding: 20px;
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        margin: 0 auto;
        max-width: 1000px; /* 최대 폭 설정 */
        margin-top: 50px;
    }
	h2 {
        color: #333;
        border-bottom: 2px solid #8C8C8C; /* 회색 밑줄 */
        padding-bottom: 10px;
        margin-bottom: 20px;
        text-align: center; /* 제목 중앙 정렬 */
    }

table {
		width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
        border-radius: 8px;
        overflow: hidden;
	}
    th, td {
        padding: 12px;
        border: 2px solid #ddd;
    }
    th {
        background-color: #6E6E6E; /* 회색 헤더 배경 */
        color: white;
        font-size: 16px;
        text-align: center;
    }
    
    input[type="text"]{
        width: 90%;
        padding: 8px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 16px;
    }	

button {
    padding: 10px 15px; /* 버튼 크기 조정 */
    background-color: #D5D5D5; /* 배경색 */
    border: none; /* 테두리 없음 */
    color: black; /* 텍스트 색상 */
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s; /* 부드러운 전환 효과 */
    margin-top: 10px; /* 위쪽 간격 */
}

button:hover {
    background-color: #b0b0b0; /* 호버 시 색상 */
}

a {
    text-decoration: none; /* 링크 기본 스타일 제거 */
}

a button {
    background-color: transparent; /* 취소 버튼 배경색 없음 */
    color: #D5D5D5; /* 텍스트 색상 */
    border: 1px solid #D5D5D5; /* 테두리 색상 */
}

a button:hover {
    background-color: #D5D5D5; /* 호버 시 색상 */
    color: white; /* 텍스트 색상 변경 */
}

</style>
</head>
<body>
<main>
	<h2>출근 및 퇴근 시간 수정</h2>
	<form action="/he/updateAdminAtt" method="POST" class="formatt" onsubmit="return validateForm()">
		<table>
		<tr>
			<th>
				<input type="hidden" name="empno" value="${updateAtt.empno}">
				근무일 
			</th>
			<td>${updateAtt.workDate} <input type="text" required="required" name="workDate" hidden="hidden" value="${updateAtt.workDate}"></td>
		</tr>
		<tr>
			<th>사원명</th>
			<td>${updateAtt.name} <input type="text" required="required" name="name" hidden="hidden" value="${updateAtt.name}"></td>
		</tr>
		<tr class="label-input">
			<th>출근 시간</th>
			<td><input type="text" id="clockIn" name="clockIn" value="${updateAtt.clockIn}" required></td>
		</tr>
		<tr class="label-input">
			<th>퇴근 시간</th>
			<td><input type="text" id="clockOut" name="clockOut" value="${updateAtt.clockOut}" required></td>
		</tr>
		<tr>
			<th>수정자</th>
			<td>${emp.name} <input type="text" required="required" name="name" hidden="hidden" value="${emp.empno}"></td>
		</tr>
		</table>
		<div style="text-align: center;">
			<button type="submit" onclick="updateClear()" class="btn btn-outline-secondary">수정 완료</button>
			<a href="/he/adminAtt"><button type="button" class="btn btn-outline-secondary">취소</button></a>
		</div>
	</form>
<script>
    function validateForm() {
        const clockIn = document.getElementById('clockIn').value; // 출근 시간
        const clockOut = document.getElementById('clockOut').value; // 퇴근 시간
        const timePattern = /^([01]\d|2[0-3]):([0-5]\d)$/; // 'HH:mm' 형식

        // 형식 검사
        if (!timePattern.test(clockIn)) {
            alert("출근 시간 형식이 잘못되었습니다\n'HH:mm' 형식으로 입력해 주세요.");
            return false; // 폼 제출 중단
        }

        if (!timePattern.test(clockOut)) {
            alert("퇴근 시간을 'HH:mm' 형식으로 입력해 주세요.");
            return false; // 폼 제출 중단
        }

        alert("수정되었습니다!");
        return true; // 폼 제출
    }
</script>
</main>
</body>
</html>
