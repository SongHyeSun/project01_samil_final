<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../1.main/user_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>calUpdate</title>
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
    
    h3 {
        color: #333;
        border-bottom: 2px solid #034EA2; /* 회색 밑줄 */
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
        background-color: #034EA2; /* 회색 헤더 배경 */
        color: white;
        font-size: 16px;
        text-align: center;
    }
    
    input[type="text"], input[type="date"] {
        width: 90%;
        padding: 8px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 16px;
    }	
</style>

<script type="text/javascript">
	function validateDates() {
	    const startDate = document.getElementById('eventStartdate').value;
	    const endDate = document.getElementById('eventEnddate').value;
	
	    if (startDate && endDate) {
	        if (new Date(startDate) > new Date(endDate)) {
	            alert("종료일은 시작일 이후의 날짜여야 합니다.");
	            return false; // 폼 제출을 중단
	        }
	    }
	    return true; // 유효성 검사 통과
	}
	
	// 글자수가 넘기면 alert
	function validateTitleLength() {
	    const titleInput = document.querySelector('input[name="eventTitle"]');
	    const maxLength = 30; // 최대 글자 수 설정
	
	    // 한글 처리: 한글은 2바이트이므로 계산 시 2바이트인 경우 반영
	    const byteLength = Array.from(titleInput.value).reduce((acc, char) => {
	        return acc + (char.charCodeAt(0) > 127 ? 2 : 1);
	    }, 0);
	
	    if (byteLength > maxLength) {
	        alert(`제목 글자수를 초과하였습니다.`);
	        return false; // 폼 제출을 중단
	    }
    	return true; // 유효성 검사 통과
	}
</script>

</head>
<body>
<main>
<form action="updateEvent" method="post" onsubmit="return validateDates() && validateTitleLength()">
	<div class="entire">
		<h3>일정 수정하기</h3>
		<input type="hidden" name="eventId" value="${calTotal.eventId }">
		<input type="hidden" name="eventCategory" value="${calTotal.eventCategory}">
		<input type="hidden" name="eventWriter" value="${calTotal.eventWriter }">
		<table>
			<tr>
				<th>제목</th>
				<td>
					<input type="text" name="eventTitle" required="required"  maxlength="30" value="${calTotal.eventTitle }">
				</td>
			</tr>
			<tr>
				<th>일시</th>
				<td>
					<input type="datetime-local" name="eventStartdate" required="required" value="${calTotal.eventStartdate }"> - 
					<input type="datetime-local" name="eventEnddate" required="required" value="${calTotal.eventEnddate }">  
				</td>
			</tr>
			<tr>
				<th>분류</th>
				<td>
					${cateMap[calTotal.eventCategory]}
				</td>
			</tr>
			<tr>
				<th>장소</th>
				<td>
					<input type="text" name="eventLoc" value="${calTotal.eventLoc }">
				</td>
			</tr>
			<tr>
				<th>메모</th>
				<td>
					<input type="text" name="eventMemo" value="${calTotal.eventMemo }">
				</td>
			</tr>
		</table>
		<div style="text-align: center;">
			<button type="submit" class="btn btn-outline-primary">수정</button>
		</div>
	</div>
</form>
</main>
</body>
</html>