<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="user_header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>SAMIL</title>
<style type="text/css">
.profile {
	display: flex; /* Flexbox 사용 */
	flex-direction: column; /* 세로 방향으로 정렬 */
	align-items: center; /* 왼쪽 정렬 */
	padding-right: 20px;
}

.profile a {
	text-decoration: none;
	color: #000;
	font-size: 19px;
	font-weight: bold;
}

.onOff {
	margin-top: 10px; /* onOff div 위쪽에 10px의 공간 추가 */
}

.onOff button {
	width: 80px; /* 원하는 너비로 설정 */
	padding: 1px 10px; /* 패딩을 추가하여 버튼의 크기를 늘림 */
	font-size: 15px;
	margin-right: 5px; /* 버튼 간의 간격 추가 */
	background-color: transparent; /* 배경색 없애기 */
	border: 1px solid #D3D3D3;
	border-radius: 3px; /* 모서리 둥글게 하기 */
	cursor: pointer; /* 커서 포인터로 변경 */
}

.currentTime {
	margin: 10px 0; /* 시간 표시 div에 여백 추가 */
	font-size: 15px; /* 시간 폰트 크기 */
}

.notice {
	width: 100%; /* 너비를 70%로 설정 */
	margin: 0 auto; /* 가운데 정렬 */
	text-align: center; /* 가운데 정렬 */
	padding: 30px 30px;
}

.notice table {
	border-collapse: collapse; /* 테두리 겹침 제거 */
	width: 100%; /* 테이블을 부모 요소와 같은 너비로 설정 */
	margin: 0 auto; /* 테이블을 가운데로 정렬 */
	border-radius: 10px; /* 꼭지점 둥글게 설정 */
	overflow: hidden;
}

.notice th, .notice td {
	border: 1px solid black;
	padding: 10px; /* 셀 내부 여백 */
	text-align: center; /* 텍스트 가운데 정렬 */
}

.notice th {
	color: black; /* 헤더 글자 색상 */
}

.notice td {
	width: 50%; /* 셀의 가로 너비를 50%로 설정 */
}

.notice a {
	text-decoration: none;
	color: #000;
}

.notice th.no-column, .notice td.no-column {
	width: 10%; /* No 열의 너비 */
}

.notice td.no-column {
	padding: 0;
}

.notice th:nth-child(2), .notice td:nth-child(2) {
	width: 70%; /* 제목 열의 너비 */
}

.notice th:nth-child(3), .notice td:nth-child(3) {
	width: 20%; /* 작성일 열의 너비 */
}

.schedule {
	display: flex;
	flex-direction: column;
}

/* 미니캘린더구역 */
.calendar {
	width: 200px;
	border-collapse: collapse;
	margin: 20px 0;
	text-align: center;
	font-size: 15px;
}

.calendar th, .calendar td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: center;
	width: 35px;
}

.calendar th {
	background-color: #f2f2f2;
}

.calendar td {
	cursor: pointer;
}

.sunday, holiday {
	color: pink;
}

.saturday {
	color: lightblue;
}

.day-cell {
	cursor: pointer;
}

.mailTable {
	margin: 20px auto;
	width: 100%;
	border-collapse: collapse;
	border-radius: 8px;
	overflow: hidden;
	text-align: center;
	border: 1px solid #BDBDBD;
	width: 100%; /* 테이블 외부 테두리 설정 */
	font-size: 15px;
}
.mailTable td{
border-color: #007acc;
	color: #333333;
	overflow: hidden;
	padding: 10px 5px;
	word-break: normal;
	border: 1px solid #BDBDBD;
	border-left: none; /* 왼쪽 세로선 제거 */
	border-right: none; /* 오른쪽 세로선 제거 */
}
.mailTable th{
background-color: #034EA2;
	border-color: #005999;
	color: #ffffff;
	font-size: 14px;
	font-weight: normal;
	overflow: hidden;
	padding: 10px 5px;
	word-break: normal;


}





</style>
<script>
	function updateTime() {
		const now = new Date();
		const timeString = now.toLocaleTimeString(); // HH:MM:SS 형식으로 변환
		document.getElementById('currentTime').textContent = timeString;
	}

	$(document)
			.ready(
					function() {
						updateTime(); // 페이지 로드 시 현재 시간 표시
						setInterval(updateTime, 1000); // 1초마다 현재 시간 업데이트

						$('#on')
								.click(
										function() {
											const now = new Date();
											const currentHour = now.getHours();
											const currentMinute = now
													.getMinutes();

											// 06:00 이전인지 체크
											if (currentHour < 6
													|| (currentHour === 6 && currentMinute === 0)) {
												alert('출근시간을 기록할 수 없습니다. (06:00 이전)');
												return;
											}

											// 18:00 이후인지 체크
											if (currentHour >= 18
													&& currentMinute > 0) {
												alert('출근시간을 기록할 수 없습니다. (18:00 이후)');
												return;
											}

											$
													.ajax({
														url : '/he/att/clockIn',
														type : 'POST',
														success : function(
																response) {
															alert('출근시간 기록: '
																	+ response);
															window.localStorage
																	.setItem(
																			'clockInTime',
																			new Date()
																					.toISOString());
														},
														error : function(xhr) {
															alert('이미 출근 기록이 있습니다.'); // 서버에서 반환한 메시지 사용
														}
													});
										});

						$('#off').click(
								function() {
									if (!window.localStorage
											.getItem('clockInTime')) {
										alert('출근 시간을 먼저 기록해 주세요.');
										return;
									}

									$.ajax({
										url : '/he/att/clockOut',
										type : 'POST',
										success : function(response) {
											alert('퇴근시간 기록: ' + response);
											window.localStorage
													.removeItem('clockInTime');
										},
										error : function(xhr) {
											alert('이미 퇴근 기록이 있습니다.'); // 서버에서 반환한 메시지 사용
										}
									});
								});

						$('#attLink').click(function() {
							window.location.href = '/he/att';
						});
					});
</script>
</head>
<body>
	<main class="wrapper">
		<div class="profile">
			<div class="info">
				<a href="/he/att">${emp.empno} ${emp.name} ${gradeName}
					${jobName}</a>
			</div>
			<div class="currentTime" id="currentTime"></div>
			<div class="onOff">
				<button type="button" id="on">on</button>
				<button type="button" id="off">off</button>
			</div>
		</div>
		<div class="cost">
			<a href="/hb/costCost"> 비용: <fmt:formatNumber
					value="${costMoney}" />원 <br> 카드 사용 내역: ${cardUseNum} 건
			</a>
		</div>
		<div class="sal">
			<c:forEach var="list" items="${salNumList}">
				<tr>
					<td><button
							class="bg-white hover:bg-gray-100 text-gray-800 font-semibold py-2 
px-4 border border-gray-400 rounded shadow"
							onclick="window.open('/mh/check?empno=${emp.empno}&salNum=${list.salNum }','width=500,height=500,resizable=no')"
							value="${emp.empno }">${list.salNum }<br> 명세서 보기
						</button></td>
				</tr>
			</c:forEach>
		</div>
		<div class="schedule">
			<a href="/hs/cal"><h4>${calendarData.currentYear}년
					${calendarData.currentMonth}월 ${calendarData.currentDay }일</h4>
				<table class="calendar">
					<thead>
						<tr>
							<th>Sun</th>
							<th>Mon</th>
							<th>Tue</th>
							<th>Wed</th>
							<th>Thu</th>
							<th>Fri</th>
							<th>Sat</th>
						</tr>
					</thead>
					<tbody id="calendar-body">
						<c:forEach var="i" begin="1" end="${calendarData.startDay - 1}">
							<td></td>
						</c:forEach>
						<c:forEach var="day" begin="1" end="${calendarData.daysInMonth}">
							<c:choose>
								<c:when test="${(calendarData.startDay + day - 1) % 7 == 1}">
									<td class="sunday">${day}</td>
								</c:when>
								<c:when test="${(calendarData.startDay + day - 1) % 7 == 0}">
									<td class="saturday">${day}</td>
								</c:when>
								<c:otherwise>
									<td>${day}</td>
								</c:otherwise>
							</c:choose>
							<c:if test="${(calendarData.startDay + day - 1) % 7 == 0}">
								</tr>
								<tr>
							</c:if>
						</c:forEach>
					</tbody>
				</table> </a>
			<button type="button" class="btn position-relative"
				style="background-color: rgb(3, 78, 162); color: white;"
				onclick="location.href='/hs/res'">시설예약</button>
		</div>
		<div class="notice">
			<table border="1">
				<tr>
					<th class="no-column">공지</th>
					<th>제목</th>
					<th>작성일</th>
				</tr>

				<c:set var="pinnedCount" value="0" />
				<c:set var="normalCount" value="0" />

				<!-- 상단 공지 게시물 출력 -->
				<c:forEach var="post" items="${listPosts4}">
					<c:if test="${post.isPinned == 1 && pinnedCount < 4}">
						<tr>
							<td class="no-column"><img src="/jh/notice.png"
								style="width: 20px; height: 20px;"></td>
							<td style="text-align: left; padding-left: 30px;"><a
								href="/jh/detailPosts/${post.postId}">${post.postsTitle}</a></td>
							<td>${post.creationDate}</td>
						</tr>
						<c:set var="pinnedCount" value="${pinnedCount + 1}" />
					</c:if>
				</c:forEach>

				<!-- 일반 게시물 출력 (총 4개가 되도록) -->
				<c:forEach var="post" items="${listPosts4}">
					<c:if
						test="${post.isPinned != 1 && normalCount < (4 - pinnedCount)}">
						<tr>
							<td class="no-column">공지</td>
							<td style="text-align: left; padding-left: 30px;"><a
								href="/jh/detailPosts/${post.postId}">${post.postsTitle}</a></td>
							<td>${post.creationDate}</td>
						</tr>
						<c:set var="normalCount" value="${normalCount + 1}" />
					</c:if>
				</c:forEach>
			</table>
		</div>
		<div class="approval">
			결재요청 <a href="/se/appReq">${reqApp}</a>건 결재문서 <a href="/se/appAll">${allApp}</a>건
		</div>
		<div class="mail">
			<table class="mailTable">
				<thead>
					<tr>
						<th>제목</th>
						<th>보낸 사람</th>
						<th>보낸 시간</th>
					</tr>
				</thead>
				<c:forEach var="mail" items="${listMail10}" begin="0"
					end="${mailMax}">
					<tr>
						<td><a style="font-size: 15px;" href="tr/mailDetail?mailNo=${mail.mailNo}">${mail.mailTitle}</a></td>
						<td><c:forEach var="sendName" items="${mailSendNameList}">
								<c:if test="${sendName.empno eq mail.sendAddress}">${sendName.name}</c:if>
							</c:forEach></td>
						<td>${mail.sendDate}</td>
				</c:forEach>
				<c:if test="${empty listMail10}">
					<tr>
						<td colspan="3">안 읽은 메일이 없습니다</td>
					</tr>
				</c:if>
			</table>
	</main>
</body>
</html>
