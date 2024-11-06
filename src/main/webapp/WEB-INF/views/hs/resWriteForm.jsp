<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../1.main/user_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>resWriteForm</title>
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

	/* 메인 */
	.entire {
		display: flex;
		margin: 40px 120px 20px 150px;
	}
	
	/* 버튼 위치 조정 */
    .form-actions {
        margin-top: 20px;
        text-align: center; /* 버튼을 왼쪽으로 정렬 */
    }
    
</style>

<script type="text/javascript">
	function validateDates() {
	    const startDate = document.getElementById('resStart').value;
	    const endDate = document.getElementById('resEnd').value;
	
	    if (startDate && endDate) {
	        if (new Date(startDate) > new Date(endDate)) {
	            alert("종료일은 시작일 이후의 날짜여야 합니다.");
	            return false; // 폼 제출을 중단
	        }
	    }
	    return true; // 유효성 검사 통과
	}
	
	 function updateEndDate() {
	        const startDateTimeInput = document.getElementById('resStart');
	        const endDateTimeInput = document.getElementById('resEnd');

	        // 시작 날짜가 입력된 경우
	        if (startDateTimeInput.value) {
	            // 시작 날짜를 Date 객체로 변환
	            const startDateTime = new Date(startDateTimeInput.value);

	            // 종료 날짜를 한 시간 뒤로 설정
	            startDateTime.setHours(startDateTime.getHours() + 10);

	            // 종료 날짜를 YYYY-MM-DDTHH:mm으로 포맷
	            const endDateTime = startDateTime.toISOString().slice(0, 16);

	            // 종료 날짜 입력에 설정
	            endDateTimeInput.value = endDateTime;
	        } else {
	            // 시작 날짜가 비어있으면 종료 날짜도 비워줌
	            endDateTimeInput.value = '';
	        }
	}
	 
	// 글자수가 넘기면 alert
	function validateTitleLength() {
		const titleInput = document.querySelector('input[name="resContent"]');
		const maxLength = 30; // 최대 글자 수 설정
		
		// 한글 처리: 한글은 2바이트이므로 계산 시 2바이트인 경우 반영
		const byteLength = Array.from(titleInput.value).reduce((acc, char) => {
			return acc + (char.charCodeAt(0) > 127 ? 2 : 1);
		}, 0);
		
		if (byteLength > maxLength) {
			alert(`예약내용 글자수를 초과하였습니다.`);
			return false; // 폼 제출을 중단
		}
		return true; // 유효성 검사 통과
	}
</script>
</head>
<body>
<main>
	<form action="writeReserv" method="post" onsubmit="return validateDates() && validateTitleLength()">
		<div class="writeReservation">
			<h3>시설 예약</h3>
			<input type="hidden" name="resState" value="100">
			<input type="hidden" name="resWriter" value="${emp.empno }">
			<table>
				<tr>
					<th>시설명</th>
					<td>
						<select name="facilId">
							<c:forEach var="facility" items="${facilSort }">
								<option value="${facility.facilId }">${facility.facilType } ${facility.facilName }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th>일시</th>
					<td>
						<input type="datetime-local" name="resStart" id="resStart" required="required" onchange="updateEndDate()">
						<input type="datetime-local" name="resEnd" id="resEnd" required="required">
					</td>
				</tr>
				<tr>
					<th>예약내용</th>
					<td><input type="text" name="resContent" required="required" maxlength="30"></td>
				</tr>
				<tr>
					<th>연락처</th>
					<td><input type="tel" name="resTel"></td>
				</tr>
				<tr>
					<th>요청사안</th>
					<td><input type="text" name="resRequest"></td>
				</tr>
			</table>
			<div class="form-actions">
				<button type="submit" class="btn btn-outline-primary">신청</button>
			</div>
		</div>
	</form>
</main>
</body>
</html>