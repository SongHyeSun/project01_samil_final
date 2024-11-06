<%@page import="com.oracle.samil.Amodel.Attendance"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../1.main/user_header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style type="text/css">
    body {
	    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
	    margin: 0;
	    padding: 0;
	    justify-content: center;
	    align-items: center;
	    height: 100vh;
	}
	
	main {
	    background-color: #fff;
	    margin: 50px 150px;
	    border-radius: 8px;
	    padding-bottom: 50px;
	}
	
	h2 {
	    color: #034EA2;
	    border-bottom: 2px solid #034EA2; /* 언더라인 색상 */
	    padding-bottom: 5px; /* 텍스트와 언더라인 사이의 여백 */
	    margin-bottom: 20px; /* 아래쪽 여백 */
	    font-weight: bold; /* 글자 두께 */
	    display: inline-block; /* 텍스트 너비만큼만 표시 */
	    margin-bottom: 30px;
	}

	.dateSelector {
		display: flex; /* 플렉스 박스 레이아웃 사용 */
		justify-content: flex-end; /* 오른쪽 정렬 */
		gap: 10px; /* 요소 간격 */
		align-items: center;
		margin-bottom: 20px;
	}
	
	label {
		color: #000; /* 레이블 색상 */
		margin: 0 10px 0 10px;
	}
	
	select, input[type="date"] {
		padding: 5px; /* 입력란 크기 조정 */
		border: 1px solid #D5D5D5; /* 테두리 색상 */
		border-radius: 4px; /* 둥근 모서리 */
		width: 150px; /* 전체 너비 */
		font-size: 14px;
		height: 40px;
	}

	#search, #LeaveRequest {
		padding: 5px 5px; /* 버튼 크기 조정 */
	    border: none;
	    border-radius: 5px;
	    background-color: #034EA2;
	    color: #ffffff;
	    cursor: pointer;
		width: 70px;
		height: 40px;
	}
	
	#search:hover, #LeaveRequest:hover {
		background-color: #023a8a; /* 호버 시 색상 */
	}
	
	.table-container {
		margin-top: 100px;
	}

	.searchLeave {
		margin-bottom: 20px;
	}

	table {
	    width: 100%;
	    border-collapse: collapse;
	    border-radius: 8px;
	    overflow: hidden;
	    text-align: center;
	}
	
	.tg {
	    border: none;
	    border-color: #4d4d4d;
	}
	
	.tg td {
	    border-color: #007acc;
	    color: #000;
	    overflow: hidden;
	    padding: 10px 5px;
	    word-break: normal;
	}
	
	.tg th {
	    background-color: #034EA2;
	    border-color: #005999;
	    color: #ffffff;
	    font-size: 14px;
	    font-weight: normal;
	    overflow: hidden;
	    padding: 10px 5px;
	    word-break: normal;
	}

	/* 테이블 행에 hover 효과 추가 */
	.tg tr:hover, table tr:hover {
		background-color: #e0e0e0; /* 호버 시 배경색 */
	}
	
	.status_red {
		color: red; /* 상태 빨간색 */
	}
	
	td a {
		color: #000;
		text-decoration: none; /* 밑줄 없음 */
	}

	td a:hover {
		color: #007BFF;
		text-decoration: underline; /* 호버 시 밑줄 추가 */
	}
	
	#LeaveRequest {
		padding: 5px 10px; /* 버튼 크기 조정 */
		width: 100px;
		background-color: #034EA2; /* 버튼 배경색 */
		color: white; /* 텍스트 색상 */
		border: none; /* 테두리 없음 */
		border-radius: 4px; /* 둥근 모서리 */
		cursor: pointer; /* 커서 변경 */
	}

	/* 연차 신청 버튼에 hover 효과 추가 */
	#LeaveRequest:hover {
		background-color: #0276a0; /* 버튼 호버 시 색상 */
	}
	
	#selectMonth {
		width: 100px;
	}
	
	.pagination {
		display: flex;
		justify-content: center; /* 가운데 정렬 */
		margin: 10px 0; /* 위아래 여백 */
	}
	
	.pagination a {
		margin: 0 5px; /* 링크 간의 여백 */
		text-decoration: none; /* 밑줄 제거 */
		color: #007bff; /* 링크 색상 */
	}
	
	.pagination a:hover {
		text-decoration: underline; /* 마우스 오버 시 밑줄 */
	}
	
	.pagination a.active {
		font-weight: bold; /* 볼드체로 설정 */
		color: #007bff; /* 강조 색상 */
	}
</style>
<title>근태</title>
</head>
<body>
<main>
	<form action="/he/att" method="GET" onsubmit="return validateDates()">
		<h2>출퇴근 조회</h2>
		<div class="dateSelector">
			<label for="selectMonth">월별 조회</label>
				<select id="selectMonth" name="month">
					<option value="">선택</option>
					<option value="01">1월</option>
					<option value="02">2월</option>
					<option value="03">3월</option>
					<option value="04">4월</option>
					<option value="05">5월</option>
					<option value="06">6월</option>
					<option value="07">7월</option>
					<option value="08">8월</option>
					<option value="09">9월</option>
					<option value="10">10월</option>
					<option value="11">11월</option>
					<option value="12">12월</option>
			</select>
				<label for="startDate">시작일</label>
					<input type="date" id="startDate" name="startDate" onchange="setEndDate(); validateStartDate()">
				<label for="endDate">종료일</label>
					<input type="date" id="endDate" name="endDate">
				<button type="submit" id="search">검색</button>
		</div>
	</form>
	<table class="tg" id="attendanceTable">
		<tr>
			<th>근무일</th>
			<th>사원명</th>
			<th>출근시간</th>
			<th>퇴근시간</th>
			<th>초과근무 시간</th>
			<th>일일 총 근로시간</th>
			<th>근태</th>
		</tr>
		<c:forEach var="myAttList" items="${attRecords}">
			<tr>
				<!-- 근무일 포맷팅 -->
				<td><script>
						var workDateStr = "${myAttList.workDate}"; // 근무일 문자열
						var formattedDate = workDateStr.substr(0, 4) + "년 " + workDateStr.substr(4, 2) + "월 " + workDateStr.substr(6, 2) + "일";
						document.write(formattedDate);
				</script></td>
				<td>${myAttList.name}</td>
				<td>${myAttList.clockIn}</td>
				<td>${myAttList.clockOut}</td>
				<td>${myAttList.overTime}시간</td>
				<td>${myAttList.totWorkTime}시간</td>
				<td class="${myAttList.attStatus == 130 || myAttList.attStatus == 140 ? 'status_red' : ''}">
					<c:choose>
						<c:when test='${myAttList.attStatus == 100}'>출근</c:when>
						<c:when test='${myAttList.attStatus == 110}'>지각</c:when>
						<c:when test='${myAttList.attStatus == 120}'>조퇴</c:when>
						<c:when test='${myAttList.attStatus == 130}'>지각&조퇴</c:when>
						<c:when test='${myAttList.attStatus == 140}'>결근</c:when>
					</c:choose>
				</td>
			</tr>
		</c:forEach>
	</table>
	<!-- 페이징 처리 -->
	<div class="pagination">
		<c:if test="${currentPage > 1}">
			<a href="?page=${currentPage - 1}&size=${size}">&lt;</a><!-- 이전 페이지 링크 -->
		</c:if>
		<c:forEach var="i" begin="1" end="${totalPages}">
			<c:if test="${i > currentPage - 10 && i < currentPage + 10}">
				<a href="?page=${i}&size=${size}" class="${currentPage == i ? 'active' : ''}">${i}</a><!-- 페이지 번호 링크 -->
			</c:if>
		</c:forEach>
		<c:if test="${currentPage < totalPages}">
			<a href="?page=${currentPage + 1}&size=${size}">&gt;</a><!-- 다음 페이지 링크 -->
		</c:if>
	</div>

	<div class="table-container">
		<form action="myLeaveList" method="get">
			<h2>연차 조회</h2>
			<div class="searchLeave" style="display: flex; justify-content: space-between; align-items: center; margin-right: 15px">
				<a href="../se/draftingForm"><button type="button" id="LeaveRequest">연차 신청</button></a>
				<h5 class="vacation-item" style="display: inline;">남은 연차 :
					${emp.restVacation}&nbsp;&nbsp;&nbsp; 총 연차일 : ${emp.totalVacation}</h5>
			</div>
		</form>
		<div style="overflow-x: auto; max-height: 437px;">
		<table class="tg">
			<tr>
				<th>신청일자</th>
				<th>연차항목</th>
				<th>사용예정일수</th>
				<th>기간</th>
				<th>신청내역</th>
				<th>결재상태</th>
			</tr>
			<c:forEach var="myLeaveList" items="${myLeave}">
				<tr>
					<td>
						<c:set var="startDate" value="${myLeaveList.furloughStartDate}" />
						<c:out value="${fn:substring(startDate, 0, 10)}" /><!-- 신청일자 출력 -->
					</td>
					<td><c:choose>
							<c:when test="${myLeaveList.documentFormId == '100'}">연차</c:when>
							<c:when test="${myLeaveList.documentFormId == '110'}">병가</c:when>
							<c:when test="${myLeaveList.documentFormId == '120'}">경조사</c:when>
							<c:when test="${myLeaveList.documentFormId == '160'}">휴직</c:when>
							<c:when test="${myLeaveList.documentFormId == '170'}">퇴직</c:when>
						</c:choose></td>
					<td>${myLeaveList.furloughServiceData}일</td>
					<td>
						<c:set var="startDate" value="${myLeaveList.furloughStartDate}" />
						<c:set var="endDate" value="${myLeaveList.furloughEndDate}" />
						<c:out value="${fn:substring(startDate, 0, 10)}" /> ~ <c:out value="${fn:substring(endDate, 0, 10)}" /><!-- 기간 출력 -->
					</td>
					<td><a href="../se/appDetail?approvalNum=${myLeaveList.approvalNum}&documentFormId=${myLeaveList.documentFormId}">
							${myLeaveList.approvalTitle} </a></td><!-- 신청 내역 링크 -->
					<td class="<c:choose>
                    	<c:when test="${myLeaveList.approvalCondition == '130'}">status_red</c:when></c:choose>">
							<c:choose>
								<c:when test="${myLeaveList.approvalCondition == '100'}">결재요청</c:when>
								<c:when test="${myLeaveList.approvalCondition == '110'}">결재진행</c:when>
								<c:when test="${myLeaveList.approvalCondition == '120'}">결재완료</c:when>
								<c:when test="${myLeaveList.approvalCondition == '130'}">반려</c:when>
							</c:choose>
					</td>
				</tr>
			</c:forEach>
		</table>
		</div>
	</div>
	<script>
	/* 시작일을 오늘날짜로 입력시 종료일을 자동으로 시작일과 동일하게 입력 */
	function setEndDate() {
	    const startDateInput = document.getElementById('startDate'); // 시작일 입력 필드
	    const endDateInput = document.getElementById('endDate'); // 종료일 입력 필드

	    const today = new Date(); // 오늘 날짜
	    const selectedStartDate = new Date(startDateInput.value); // 선택된 시작일

	    // 오늘 날짜와 선택한 시작일 비교
	    if (startDateInput.value && 
	        selectedStartDate.getFullYear() === today.getFullYear() &&
	        selectedStartDate.getMonth() === today.getMonth() &&
	        selectedStartDate.getDate() === today.getDate()) {
	        endDateInput.value = startDateInput.value; // 시작일을 종료일에 설정
	    }
	}

	// 선택한 시작일이 오늘 이후인 경우 경고
	function validateStartDate() {
	    const startDateInput = document.getElementById('startDate');
	    const endDateInput = document.getElementById('endDate');
	    
	    const today = new Date();
	    today.setHours(0, 0, 0, 0); // 오늘 날짜의 시간 부분을 00:00:00로 설정

	    const selectedDate = new Date(startDateInput.value); // 선택한 시작일
	    selectedDate.setHours(0, 0, 0, 0); // 선택한 날짜의 시간 부분을 00:00:00로 설정

	    // 선택한 시작일이 오늘 이후인 경우 경고
	    if (selectedDate > today) {
	        alert("오늘 이후 날짜는 선택할 수 없습니다.\n시작일을 오늘 또는 그 이전으로 설정해 주세요.");
	        startDateInput.value = ""; // 시작일 초기화
	        endDateInput.value = ""; // 종료일 초기화
	    }
	}

		// 시작일과 종료일의 값이 비어 있을 경우 기본 종료일 설정
		const startDateInput = document.getElementById('startDate');
		const endDateInput = document.getElementById('endDate');

		// 종료일의 값만 입력한 경우 시작일을 1월1일로 설정
		endDateInput.addEventListener('change', function() {
			if (!startDateInput.value) {
				startDateInput.value = new Date(new Date().getFullYear(), 0, 2)
						.toISOString().split('T')[0];
			}
		});

	// 시작일과 종료일 유효성 검사
	function validateDates() {
		const startDate = document.getElementById('startDate').value;
		const endDate = document.getElementById('endDate').value;

		// 종료일이 시작일보다 이전 날짜인 경우
		if (startDate && endDate) {
			if (new Date(startDate) > new Date(endDate)) {
				alert("종료일은 시작일 이후의 날짜여야 합니다.");
				return false; // 폼 제출을 중단
			}
		}
		return true; // 유효성 검사 통과
	}
	</script>
</main>
</body>
</html>