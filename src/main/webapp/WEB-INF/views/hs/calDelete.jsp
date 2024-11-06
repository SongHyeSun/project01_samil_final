<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../1.main/user_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>calDelete</title>
<style type="text/css">
	/* 메인 */
	.entire {
		display: flex;
		flex-direction: column;
		margin: 40px 120px 20px 150px;
	}
	
	a {
		color: black;	/* 글자 색상 설정 */
		text-decoration: none;	/* 밑줄제거 */
	}
	
	a:hover {
		font-weight: bold;
	}
	
	/* 1구역 */
	.writemyplan {
		display: flex;	/* 플렉스 박스를 사용하여 정렬 */
		flex-direction: row;	/* 가로 방향 정렬 */
		align-items: center;	/* 수직 중앙 정렬 */
	}
	
	.writemyplan img {
		width: 150px;
		height: auto;
	}
	
	.deleteList a {
		display: flex;	/* 플렉스 박스를 사용하여 정렬 */
		justify-content: center; /* 가로 가운데 정렬 */
		align-items: center; /* 세로 가운데 정렬 */
		margin-top: 20px;	/* 위쪽 간격 추가 */
		font-size: 18px;
		font-weight: bold;
		width: 300px;
	}
	
	.writemyplan .deleteList img {
		margin:0 10px 0 10px;	/* 그림과 글씨 사이 간격 조정 */
		width: 30px;
	}
	
	.writemyplan .deleteList a:hover {
		color: rgb(3, 78, 162);
		text-decoration: underline;
	}
	
	/* 1구역의 검색 */
	.container1 {
		display: flex; /* 플렉스 박스를 사용하여 정렬 */
		justify-content: space-between; /* 요소들 사이에 공간 분배 */
		width: 100%; /* 전체 너비 */
		margin-bottom: 20px; /* 아래쪽 여백 추가 */
	}
	
	#searchForm {
		width: 500px;
	}
	
	/* 검색 부분 스타일 */
	.container1 .search {
		width: 100%;
		height: 30px;
		margin-bottom: 20px;
		text-align: right;
	}
	
	.container .deltitle {
		width: 100%;
		min-width: 1000px;
		border: 1px solid;
		border-radius: 17px;
		padding: 15px;
		background-color: rgb(3, 78, 162);
		color: white;
		display: flex;	/* 플렉스 박스를 사용하여 정렬 */
		align-items: center; /* 세로 가운데 정렬 */
		font-weight: bold;
		font-size: 20px;
		margin-bottom: 20px;
	}
	
	.container .deltitle img {
		margin-right: 10px;
	}
	
	.container .delList {
		text-align: center;
		min-width: 1000px;
	}
	
	.container .delList table {
		width: 100%;
		min-width: 1000px;
		border: none;
		padding-left: 20px;
		padding-top: 10px;
	}
	
	.container .delList th {
		background-color: #D5D5D5;
		height: 30px;
	}
	
	.container .delList td {
		padding-top: 7px;
	}
	
	.delbutton {
		text-align: right;
		padding-right: 15px;
	}
	
</style>
<script type="text/javascript">
const API_KEY='L14grotwGfo2U3slJQUf1JMlKnW2SBNNZR9ToRHsJSh4s5hu%2BBvbhuDlQ8%2BaoaX%2BZIFrTX2gWX6THbzNGEC6zQ%3D%3D'

	 async function getData(){
		const url='http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getRestDeInfo?solYear=2024&solMonth=09&ServiceKey=${API_KEY}';
		const response = await fetch(url);
		const data = await response.json();
		console.log("data",data);
	}
	
	getData();


	const year = new Date().getFullYear();
	const month = new Date().getMonth(); // 현재 월

/* 	async function loadCalendar() {
		const response = await fetch('/hs/holidays?countryCode=KR&year=' + year);
		const data = await response.json();
		const holidays = data.holidays.map(h => h.date); // API에서 공휴일 날짜 추출
		generateCalendar(year, month, holidays);
	} */

	function generateCalendar(year, month, holidays) {

	}

	loadCalendar();
	
	function confirmAction(formId, message) {
		if (confirm(message)) {
			document.getElementById(formId).submit();
			return true;
		} else {
			return false;
		}
	}
</script>
</head>
<body>
<main>
	<div class="entire">
		<div class="container">
			<div class="deltitle">
				<img alt="trash" src="/hs/trashfile1.png" width="30px"> 삭제된 일정 목록
			</div>
			<div class="delList">
				<table>
					<tr>
						<th>제목</th>
						<th>일시</th>
						<th></th>
					</tr>
					<c:forEach var="event" items="${listDelete }">
						<tr>
							<td>${event.eventTitle }</td>
							<td>${event.formatStartdate } - ${event.formatEnddate }</td>
							<td class="delbutton">
								<form action="eventRestore" method="post" style="display:inline;" id="restore-form-${event.eventId}">
									<input type="hidden" name="eventId" value="${event.eventId}">
									<input type="hidden" name="eventDelete" value="100">
									<button type="submit" class="btn btn-outline-primary btn-sm" onclick="return confirmAction('restore-form-${event.eventId}', '일정을 복원하시겠습니까?')">복원</button>
								</form>
								<form action="eventForDel" method="post" style="display:inline;" id="delete-form-${event.eventId}">
									<input type="hidden" name="eventId" value="${event.eventId}">
									<button type="submit" class="btn btn-outline-danger btn-sm" onclick="return confirmAction('delete-form-${event.eventId}', '완전히 삭제하시겠습니까?')">삭제</button>
								</form>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
</main>
</body>
</html>