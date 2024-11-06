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
	}
	
	table {
	    margin: 20px auto;
	    width: 100%;
	    border-collapse: collapse;
	    border-radius: 8px;
	    overflow: hidden;
	    text-align: center;
	}
	
	tbody td {
	    border-color: #007acc;
	    color: #333333;
	    overflow: hidden;
	    padding: 10px 5px;
	    word-break: normal;
	}
	
	thead th {
	    background-color: #034EA2;
	    border-color: #005999;
	    color: #ffffff;
	    font-size: 14px;
	    font-weight: normal;
	    overflow: hidden;
	    padding: 10px 5px;
	    word-break: normal;
	}
	
	select {
	    word-wrap: normal;
	    background-color: #ffffff;
	    width: 200px;
	    height: 30px;
	    padding: 5px;
	    border-radius: 5px;
	    border: 1px solid #ccc;
	    margin-right: 5px;
	}
	
	button{
	    padding: 5px 10px;
	    border: none;
	    border-radius: 5px;
	    background-color: #034EA2;
	    color: #ffffff;
	    cursor: pointer;
	    transition: background-color 0.3s;
}

	#trEmpSearch {
	    background-color: #ffffff;
	    width: 200px;
	    height: 30px;
	    padding: 5px;
	    border-radius: 5px;
	    border: 1px solid #ccc;
	    margin-right: 5px;
}
h2 {
	    color: #034EA2;
	    border-bottom: 2px solid #034EA2; /* 언더라인 색상 */
	    padding-bottom: 5px; /* 텍스트와 언더라인 사이의 여백 */
	    margin-bottom: 20px; /* 아래쪽 여백 */
	    font-weight: bold; /* 글자 두께 */
	    display: inline-block; /* 텍스트 너비만큼만 표시 */
	}


</style>
<title>관리자 사원정보관리</title>
</head>
<body>
	<main>
		<h2>사원 정보 검색</h2>
        <hr color="#3333CC">
		<form action="searchEmpByKeyword" method="get">
		<select name="option">
		<option value="name" >사원명</option>
		<option value="deptName" >부서</option>
		</select>
			<input id="trEmpSearch" type="text" name="keyword"
				placeholder="검색어를 입력하세요" />
			<button type="submit">검색</button>
		</form>
		<br />
		<div style="width:100%; height:500px; overflow:auto">
		<table border="1">
			<thead>
				<tr>
					<th>사번</th>
					<th>이름</th>
					<th>부서</th>
					<th>직책</th>
					<th>직급</th>
					<th>전화번호</th>
					<th>이메일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="emp" items="${empDeptList}">
					<tr>
						<td>${emp.empno}</td>
						<td class="empName">${emp.name}</td>
						<td>${emp.deptName}</td>
						<td><c:choose>
								<c:when test="${emp.job == 100}">평사원</c:when>
								<c:when test="${emp.job == 110}">팀장</c:when>
								<c:when test="${emp.job == 120}">대표</c:when>
							</c:choose></td>
						<td><c:choose>
								<c:when test="${emp.grade == 100}">사원</c:when>
								<c:when test="${emp.grade == 110}">주임</c:when>
								<c:when test="${emp.grade == 120}">대리</c:when>
								<c:when test="${emp.grade == 130}">과장</c:when>
								<c:when test="${emp.grade == 140}">차장</c:when>
								<c:when test="${emp.grade == 150}">부장</c:when>
								<c:when test="${emp.grade == 160}">사장</c:when>
							</c:choose></td>
						<td>${emp.phone}</td>
						<td>${emp.email}</td>
					</tr>
				</c:forEach>

				<c:if test="${empty empDeptList}">
					<tr>
						<td colspan="3">No employees found</td>
					</tr>
				</c:if>
			</tbody>
		</table>
		</div>

	</main>
</body>
</html>