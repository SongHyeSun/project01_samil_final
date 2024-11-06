<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../1.main/admin_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	crossorigin="anonymous">
<meta charset="UTF-8">
<title>관리자 급여지급 페이지입니다</title>
</head>

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


.modal-header h1 {
    font-size: 20px;
    font-weight: bold;
}
</style>

<body>
<main>
	<h3>관리자 급여지급 페이지입니다</h3>
	
	<p>급여 지급일: ${salDate}</p>

	<!-- 검색 필터 폼 -->
	<form action="listSearchGive" method="POST">
		<div class="input-group mb-3">
			<select class="form-select" name="search">
				<option value="seartchEmpno">사원번호</option>
				<option value="seartchName">사원명</option>
				<option value="seartchDet">부서</option>
			</select>
			<input type="text" name="keyword" class="form-control" placeholder="검색어를 입력하세요">
			<button type="submit" class="btn btn-secondary">검색</button>
		</div>
	</form>

	<!-- 사원 목록 테이블 -->
	<form action="insertSal" method="Get">
		<table>
			<thead>
				<tr>
					<th>번호</th>
					<th>사원번호</th>
					<th>사원명</th>
					<th>부서</th>
					<th>직급</th>
				</tr>
			</thead>
			<tbody>
				<c:set var="num" value="1"></c:set>
				<c:forEach var="emp" items="${listEmp}">
					<tr ondblclick="location.href='/mh/adminSalGiveD?empno=${emp.empno}'" style="cursor: pointer;">
						<td>${num}</td>
						<td>${emp.empno}</td>
						<td>${emp.name}</td>
						<td>${emp.deptName}</td>
						<td>
							<c:choose>
								<c:when test="${emp.grade == 100}">사원</c:when>
								<c:when test="${emp.grade == 110}">주임</c:when>
								<c:when test="${emp.grade == 120}">대리</c:when>
								<c:when test="${emp.grade == 130}">과장</c:when>
								<c:when test="${emp.grade == 140}">차장</c:when>
								<c:when test="${emp.grade == 150}">부장</c:when>
								<c:when test="${emp.grade == 160}">사장</c:when>
								<c:otherwise>직급 정보 없음</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<c:set var="num" value="${num + 1}" />
				</c:forEach>
			</tbody>
		</table>
		
		<!-- 페이지 네비게이션 -->
		<div id="container">
			<c:if test="${page.startPage > page.pageBlock}">
				<a href="adminSalGive?currentPage=${page.startPage - page.pageBlock}">[이전]</a>
			</c:if>
			<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
				<a href="adminSalGive?currentPage=${i}">[${i}]</a>
			</c:forEach>
			<c:if test="${page.endPage < page.totalPage}">
				<a href="adminSalGive?currentPage=${page.startPage + page.pageBlock}">[다음]</a>
			</c:if>
		</div>

		<!-- 추가 수당 불러오기 및 급여 지급 모달 버튼 -->
		<div class="d-grid gap-2 d-md-block text-center mt-4">
			<button type="button" class="btn btn-secondary" onclick="window.open('/mh/overtimeSal?salNum=${salNum}', 'width=500,height=500,resizable=no')">추가수당 불러오기</button>
			<button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#exampleModal">급여 지급</button>
		</div>

		<!-- 모달 다이얼로그 -->
		<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="exampleModalLabel">주의</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						근로 월 '${salNum}'의 추가 수당을 확정하셔야 합니다. 추가 수당을 확인하셨습니까?
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
						<button type="submit" class="btn btn-primary" onclick="btn()">계속하기</button>
					</div>
				</div>
			</div>
		</div>

	</form>
</main>
</body>
</html>