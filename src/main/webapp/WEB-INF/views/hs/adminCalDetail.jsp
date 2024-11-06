<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../1.main/admin_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin_calDetail</title>
<style type="text/css">
	/* 메인 */
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
        text-align: center;
    }
    th {
        background-color: #6E6E6E; /* 회색 헤더 배경 */
        color: white;
        font-size: 16px;
    }
    
    input[type="text"], input[type="file"], input[type="date"] {
        width: 90%;
        padding: 8px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 16px;
    }	
	
	.entire {
		width: 100%;
	}
	
	.emoti {
    	font-size: 25px;
    	color: #86E57F;		/* 회사일정색상 */
    }
    
    .category {
    	color: #62C15B;
    }
	
</style>

<script type="text/javascript">
	function confirmDel(eventId) {
		// 알림창 띄우기
		var result = confirm("정말로 삭제하시겠습니까?");
		if (result) {
			// 사용자가 확인을 클릭한 경우, 삭제 요청을 수행합니다.
			window.location.href = 'deleteAdmEvent?eventId=' + eventId;
		}
	}
</script>
</head>
<body>
<main>
<div class="entire">
		<h3>회사일정 상세보기</h3>
		<table>
			<tr>
				<th>제목</th>
				<td>${event.eventTitle }</td>
			</tr>
			<tr>
				<th>일시</th>
				<td>${event.formatStartdate } - 
					  ${event.formatEnddate }
				</td>
			</tr>
			<tr>
				<th>분류</th>
				<td><span class="emoti">●</span>
					<span class="category">${cateMap[event.eventCategory]}</span>
				</td>
			</tr>
			<tr>
				<th>장소</th>
				<td>${event.eventLoc }</td>
			</tr>
			<tr>
				<th>메모</th>
				<td>${event.eventMemo }</td>
			</tr>
		</table>
		<div style="text-align: right;">
			<input type="button" class="btn btn-outline-secondary" value="이전" onclick="location.href='/hs/adminCal'">
			<input type="button" class="btn btn-outline-primary" value="수정" onclick="location.href='/hs/adminCalUpdate?eventId=${event.eventId}'">
			<form action="deleteEvent" method="post" style="display: inline;">
				<input type="hidden" name="eventId" value="${event.eventId }">
				<input type="hidden" name="eventDelete" value="110">
				<input type="submit" class="btn btn-outline-danger" value="삭제" onclick="confirmDel(${event.eventId})">
			</form>
		</div>
	</div>
</main>
</body>
</html>