<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../1.main/admin_header.jsp"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html lang="ko">
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
	margin: 30px 150px 0 150px;
	border-radius: 8px;
	padding-bottom: 50px;
}

h2 {
    color: #6E6E6E;
    border-bottom: 2px solid #6E6E6E; /* 언더라인 색상 */
    padding-bottom: 5px; /* 텍스트와 언더라인 사이의 여백 */
    margin-bottom: 20px; /* 아래쪽 여백 */
    font-weight: bold; /* 글자 두께 */
	text-align: left; /* 왼쪽 정렬 */
    display: inline-block; /* 텍스트 너비만큼만 표시 */
}

.adminAttSearch, .leaveContainer {
	text-align: right; /* 오른쪽 정렬 */
	margin-bottom: 25px;
}

.table-container {
	margin-top: 100px;
}

input[type="text"] {
	width: 180px; /* 너비 조정 */
}

select {
	width: 100px; /* 너비 조정 */
}

input[type="text"], select {
	padding: 5px; /* 입력란 크기 조정 */
	margin-right: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

input[type="date"] {
	padding: 5px;
	border: 1px solid #ccc;
	border-radius: 4px;
	width: 150px; /* 너비 조정 */
}

button {
	padding: 5px 10px; /* 버튼 크기 조정 */
	background-color: #6E6E6E; /* 배경색 없음 */
	border: none;
	color: white; /* 텍스트 색상 변경 */
	border-radius: 5px;
	cursor: pointer;
}

button:hover {
	background-color: #D5D5D5; /* 호버 시 배경색 */
	color: white; /* 호버 시 텍스트 색상 */
}
	
table {
	width: 100%;
    border-collapse: collapse;
    border-radius: 8px;
    overflow: hidden;
    text-align: center;
}

td {
	border-color: #007acc;
	color: #333333;
    overflow: hidden;
    padding: 10px 5px;
    word-break: normal;
}

th {
    background-color: #6E6E6E;
    border-color: #005999;
    color: #ffffff;
    font-size: 14px;
    font-weight: normal;
    overflow: hidden;
    padding: 10px 5px;
    word-break: normal;
}

tr:hover, tr:hover {
	background-color: #e0e0e0; /* 호버 시 배경색 */
}

td a {
	color: #000; /* 링크 색상 */
	text-decoration: none; /* 밑줄 없음 */
}

td a:hover {
	color: #007BFF;
	text-decoration: underline; /* 호버 시 밑줄 추가 */
}

.status_red {
	color: red; /* 상태 빨간색 */
}

.status_green {
	color: green; /* 상태 초록색 */
}

label {
    margin: 0 5px;
}

div.empInfoSelector {
    margin-bottom: 10px; /* 아래 간격 10px로 조정 */
}

.edit-info {
	cursor: pointer; /* 커서를 포인터로 변경 */
	color: #2478FF; /* "수정됨" 텍스트 색상 변경 */
	font-weight: bold;
}

#approvalStn {
    float: left; /* 왼쪽 정렬 */
    margin-top: 10px;
}
.pagination {
	display: flex;
	justify-content: center; /* 가운데 정렬 */
	margin: 10px 0; /* 위아래 여백 */
}

.pagination a {
	margin: 0 5px; /* 링크 간의 여백 */
	text-decoration: none; /* 밑줄 제거 */
	color: #000; /* 링크 색상 */
}

.pagination a:hover {
	text-decoration: underline; /* 마우스 오버 시 밑줄 */
}

.pagination a.active {
	font-weight: bold; /* 볼드체로 설정 */
	color: #000; /* 강조 색상 */
}
</style>
<title>관리자 근태</title>
</head>
<body>
<main>
	<%
	if (request.getAttribute("successMessage") != null) {
	%>
	<script>
			alert("<%=request.getAttribute("successMessage")%>
		");
	</script>
	<%
	}
	%>
	<form action="/he/adminAtt" method="GET" onsubmit="return validateDates()">
		<h2>근무 현황</h2>
			<div class="adminAttSearch">
			<div class="empInfoSelector">
				<label for="searchInfo">부서정보 조회:</label>
					<select id="searchInfo" name="empInfo">
							<option value="">선택</option>
							<option value="사원명">사원명</option>
						<c:if test="${emp.admin == 170}">
							<option value="부서명">부서명</option>
						</c:if>
							<option value="출근상태">출근상태</option>
					</select>
					<input type="text" id="searchContent" name="searchContent" placeholder="검색어를 입력하세요">
					<button type="submit" id="search">검색</button>
			</div>
			<div class="dateSelector">
					<label for="selectMonth">월별 조회:</label>
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
						<label for="startDate">시작일:</label>
						<input type="date" id="startDate" name="startDate" onchange="setEndDate(); validateStartDate()">
						<label for="endDate">종료일:</label>
						<input type="date" id="endDate" name="endDate">
				</div>
			</div>
		</form>
		<table id="attendanceTable">
			<tr>
				<th>날짜</th>
				<th>사원명</th>
				<th>부서명</th>
				<th>출근</th>
				<th>퇴근</th>
				<th>초과근무 시간</th>
				<th>일일 총 근로시간</th>
				<th>근태</th>
				<th>수정여부</th>
			</tr>
			<c:forEach var="deptAttList" items="${deptAttRecords}">
				<tr>
					<!-- 근무일 포맷팅 -->
					<td>
						<c:out value="${fn:substring(deptAttList.workDate, 0, 4)}" />년 
		                <c:out value="${fn:substring(deptAttList.workDate, 4, 6)}" />월 
		                <c:out value="${fn:substring(deptAttList.workDate, 6, 8)}" />일
					</td>
					<td>
						<!-- 근무시간 수정 링크 -->
						<a href="/he/updateAdminAtt?empno=${deptAttList.empno}&workDate=${deptAttList.workDate}" title="근무시간 수정">
							   ${deptAttList.name}</a>
					</td>
					<td>${deptAttList.deptName}</td>
					<td>${deptAttList.clockIn}</td>
					<td>${deptAttList.clockOut}</td>
					<td>${deptAttList.overTime}시간</td>
					<td>${deptAttList.totWorkTime}시간</td>
					<td class="${deptAttList.attStatus == 130 || deptAttList.attStatus == 140 ? 'status_red' : ''}">
						<c:choose>
							<c:when test="${deptAttList.attStatus == 100}">출근</c:when>
							<c:when test="${deptAttList.attStatus == 110}">지각</c:when>
							<c:when test="${deptAttList.attStatus == 120}">조퇴</c:when>
							<c:when test="${deptAttList.attStatus == 130}">지각&조퇴</c:when>
							<c:when test="${deptAttList.attStatus == 140}">결근</c:when>
						</c:choose>
					</td>
					<td><c:choose>
							<c:when test="${deptAttList.editCheck == 0}"></c:when>
							<c:when test="${deptAttList.editCheck == 1}">
								<span class="edit-info" style="cursor: pointer;" onclick="toggleEditInfo(this)">수정됨</span>
									<div class="edit-details" style="display:none;">
										<span class="attEditor">수정자: ${deptAttList.editWhoName} (${deptAttList.editWho})</span><br>
										<span class="modifiedDate">수정일자: ${deptAttList.editWhen}</span>
									</div>
							</c:when>
						</c:choose></td>
				</tr>
			</c:forEach>
		</table>
		<!-- 페이징 처리 -->
		<c:if test="${totalPages > 0}">
			<div class="pagination">
				<c:if test="${currentPage > 1}">
					<a href="?page=${currentPage - 1}&size=${size}&empInfo=${param.empInfo}&searchContent=${param.searchContent}&month=${param.month}&startDate=${param.startDate}&endDate=${param.endDate}">
						이전</a>
				</c:if>

				<!-- 페이지 시작과 끝 계산 -->
				<c:set var="startPage" value="${(currentPage - 1) / 10 * 10 + 1}" />
				<c:set var="endPage" value="${startPage + 9}" />

				<!-- 끝 페이지 조정 -->
				<c:if test="${endPage > totalPages}">
					<c:set var="endPage" value="${totalPages}" />
				</c:if>

				<!-- 페이지 번호 링크 생성 -->
				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					<a href="?page=${i}&size=${size}&empInfo=${param.empInfo}&searchContent=${param.searchContent}&month=${param.month}&startDate=${param.startDate}&endDate=${param.endDate}" class="${currentPage == i ? 'active' : ''}">
						${i}</a>
				</c:forEach>
		
				<c:if test="${endPage < totalPages}">
					<a href="?page=${endPage + 1}&size=${size}&empInfo=${param.empInfo}&searchContent=${param.searchContent}&month=${param.month}&startDate=${param.startDate}&endDate=${param.endDate}">
						다음</a>
				</c:if>
			</div>
		</c:if>
		<!-- 첫 페이지와 마지막 페이지 링크 -->
		<div class="pagination">
			<c:if test="${currentPage > 10}">
				<a href="?page=1&size=${size}&empInfo=${param.empInfo}&searchContent=${param.searchContent}&month=${param.month}&startDate=${param.startDate}&endDate=${param.endDate}">1</a>
				<c:if test="${startPage > 1}">
					<span>...</span><!-- 페이지 생략 표시 -->
				</c:if>
			</c:if>
			<c:if test="${currentPage < totalPages}">
				<a href="?page=${totalPages}&size=${size}&empInfo=${param.empInfo}&searchContent=${param.searchContent}&month=${param.month}&startDate=${param.startDate}&endDate=${param.endDate}">
				   ${totalPages}</a><!-- 마지막 페이지 링크 -->
			</c:if>
		</div>

<% if (request.getAttribute("error") != null) { %>
	<script>
		alert('<%= request.getAttribute("error") %>');
	</script>
<% } %>

	<div class="table-container">
		<form action="/he/adminAtt" method="get">
			<h2>연차 현황</h2>
			<div class="leaveContainer">
				<a href="../se/appReq"><button type="button" id="approvalStn">결재</button></a>
				<label for="searchEmpDeptInfo">부서정보 조회:</label>
					<select id="searchEmpDeptInfo" name="searchEmpDeptInfo">
						<option value="">선택</option>
						<option value="사원">사원명</option>
					<c:if test="${emp.admin == 170}"><!-- 관리자만 부서명 조회 가능 -->
						<option value="부서">부서명</option>
					</c:if>
						<option value="결재상태">결재상태</option>
				</select>
				<input type="text" id="LeaveSearchContent" name="LeaveSearchContent" placeholder="검색어를 입력하세요">
				<button type="submit" id="empLeaveSearch">검색</button>
			</div>
		</form>
		<div style="overflow-x: auto; max-height: 437px;">
		<table>
			<tr>
				<th>연차그룹</th>
				<th>사원명</th>
				<th>부서명</th>
				<th>사용예정일</th>
				<th>기간</th>
				<th>누적사용일</th>
				<th>결재신청내역</th>
				<th>결재상태</th>
			</tr>
			<c:forEach var="deptLeaveList" items="${deptLeave}">
				<tr>
					<td><c:choose>
							<c:when test="${deptLeaveList.documentFormId == '100'}">연차</c:when>
							<c:when test="${deptLeaveList.documentFormId == '110'}">병가</c:when>
							<c:when test="${deptLeaveList.documentFormId == '120'}">경조사</c:when>
							<c:when test="${deptLeaveList.documentFormId == '160'}">휴직</c:when>
							<c:when test="${deptLeaveList.documentFormId == '170'}">퇴직</c:when>
						</c:choose></td>
					<td>${deptLeaveList.name}</td>
					<td>${deptLeaveList.deptName}</td>
					<td>${deptLeaveList.furloughServiceData}일</td>
					<td>
						<c:set var="startDate" value="${deptLeaveList.furloughStartDate}" />
						<c:set var="endDate" value="${deptLeaveList.furloughEndDate}" />
						<c:out value="${fn:substring(startDate, 0, 10)}" /> ~ <c:out value="${fn:substring(endDate, 0, 10)}" />
					</td>
					<td>${deptLeaveList.totalVacation - deptLeaveList.restVacation}일</td>
					<td><a href="../se/appDetail?approvalNum=${deptLeaveList.approvalNum}&documentFormId=${deptLeaveList.documentFormId}">
							${deptLeaveList.approvalTitle}</a></td>
					<td class="<c:choose>
                    	<c:when test="${deptLeaveList.approvalCondition == '100'}">status_green</c:when>
                    </c:choose>">
						<c:choose>
							<c:when test="${deptLeaveList.approvalCondition == '100'}">결재요청</c:when>
							<c:when test="${deptLeaveList.approvalCondition == '110'}">결재진행</c:when>
							<c:when test="${deptLeaveList.approvalCondition == '120'}">결재완료</c:when>
							<c:when test="${deptLeaveList.approvalCondition == '130'}">반려</c:when>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
		</table>
		</div>
	</div>
	<script>
	// 종료일을 자동으로 설정하는 함수
	function setEndDate() {
	    const startDateInput = document.getElementById('startDate');
	    const endDateInput = document.getElementById('endDate');

	    const today = new Date();
	    const selectedStartDate = new Date(startDateInput.value);

	    // 오늘 날짜와 선택한 시작일 비교
	    if (startDateInput.value && 
	        selectedStartDate.getFullYear() === today.getFullYear() &&
	        selectedStartDate.getMonth() === today.getMonth() &&
	        selectedStartDate.getDate() === today.getDate()) {
	        endDateInput.value = startDateInput.value; // 시작일을 종료일에 설정
	    }
	}

	// 시작일 유효성 검사 함수
	function validateStartDate() {
	    const startDateInput = document.getElementById('startDate');
	    const endDateInput = document.getElementById('endDate');
	    
	    const today = new Date();
	    today.setHours(0, 0, 0, 0); // 오늘 날짜의 시간 부분을 00:00:00로 설정

	    const selectedDate = new Date(startDateInput.value);
	    selectedDate.setHours(0, 0, 0, 0); // 선택한 날짜의 시간 부분을 00:00:00로 설정

		// 선택한 날짜가 오늘 이후인 경우 경고
	    if (selectedDate > today) {
	        alert("오늘 이후 날짜는 선택할 수 없습니다.\n시작일을 오늘 또는 그 이전으로 설정해 주세요.");
	        startDateInput.value = ""; // 시작일 초기화
	        endDateInput.value = ""; // 종료일 초기화
	    }
	}

		// 종료일 변경 시 시작일을 올해 1월1일로 설정
		const startDateInput = document.getElementById('startDate');
		const endDateInput = document.getElementById('endDate');

		endDateInput.addEventListener('change', function() {
			if (!startDateInput.value) {
				startDateInput.value = new Date(new Date().getFullYear(), 0, 2)
						.toISOString().split('T')[0];
			}
		});

		// 시작일과 종료일 유효성 검사 함수
		function validateDates() {
			const startDate = document.getElementById('startDate').value;
			const endDate = document.getElementById('endDate').value;
			// 선택된 종료일의 날짜가 시작일 이전 일 경우
			if (startDate && endDate) {
				if (new Date(startDate) > new Date(endDate)) {
					alert("종료일은 시작일 이후의 날짜여야 합니다.");
					return false; // 폼 제출을 중단
				}
			}
			return true; // 유효성 검사 통과
		}

		function toggleEditInfo(element) {
		    const details = element.nextElementSibling;
		    details.style.display = details.style.display === 'none' ? 'block' : 'none';
		}
	</script>
	</main>
</body>
</html>