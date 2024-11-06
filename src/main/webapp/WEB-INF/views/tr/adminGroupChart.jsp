<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../1.main/admin_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
body {
	
}

	main {
	    padding: 30px 10%;
	    background-color: #fff;
	    margin: 20px auto;
	    border-radius: 8px;
	}

	table {
	    width: 600px;
	    border-collapse: collapse;
	    border-radius: 8px;
	    overflow: hidden;
	    margin-top: 30px;
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
	    text-align: center;
	}
	
	input {
		/* margin-left: 180px; */
		border-radius: 10px;
		border: 0px;
		
	}
	
	button {
		padding: 5px 10px;
	    border: none;
	    border-radius: 5px;
	    background-color: #6E6E6E;
	    color: #ffffff;
	    cursor: pointer;
	    transition: background-color 0.3s;
	}
	
	.showMem {
		margin-left: 200px;
		background: #EAEAEA;
	}
	.showMem2 {
	
		background: #EAEAEA;
	}
</style>
<title>관리자 조직관리</title>
</head>
<body>
	<main>
		<h2>관리자 조직관리 페이지입니다</h2>
		<hr>
		<button onclick="location.href='/tr/addDept'">부서추가</button>
		<table border="1" frame=void;>
			<tr>
				<th style="border-right: none;">부서명</th>
				<th style="border-left: none;"></th>
				<th style="border-left: none;"></th>
			</tr>
			<c:forEach var="dept" items="${deptList}">
				<c:if test="${dept.higherdeptno == 0}">
					<tr>
						<td class="deptName" style="border: none;">${dept.deptName}</td>
						<td style="border: none;"><a
							href="showDeptMember?deptno=${dept.deptno}">
							<input class="showMem" type="button" value="구성원 보기"></a></td>
						<td style="border: none;"><a
							href="editDept?deptno=${dept.deptno}"><input type="button"
								value="부서 편집"  class="showMem2"></a></td>
					</tr>
					<c:set var="deptno" value="${dept.deptno}"></c:set>
					<c:forEach var="dept" items="${deptList}">
						<c:if test="${dept.higherdeptno == deptno}">
							<tr>
								<td class="deptName" style="border: none;">ㄴ${dept.deptName}</td>
								<td style="border: none;"><a
									href="showDeptMember?deptno=${dept.deptno}"><input
										class="showMem" type="button" value="구성원 보기"></a></td>
								<td style="border: none;"><a
									href="editDept?deptno=${dept.deptno}"><input type="button"
										value="부서 편집"  class="showMem2"></a></td>
							</tr>
							<c:set var="deptno1" value="${dept.deptno}"></c:set>
							<c:forEach var="dept" items="${deptList}">
								<c:if test="${dept.higherdeptno == deptno1}">
									<tr>
										<td class="deptName" style="border: none;">&nbsp;&nbsp;ㄴ${dept.deptName}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
										<td style="border: none;"><a
											href="showDeptMember?deptno=${dept.deptno}"><input
											class="showMem"	type="button" value="구성원 보기"></a></td>
										<td style="border: none;"><a
											href="editDept?deptno=${dept.deptno}"><input
												type="button" value="부서 편집"  class="showMem2"></a></td>
									</tr>
								</c:if>
							</c:forEach>
						</c:if>
					</c:forEach>
				</c:if>
			</c:forEach>
		</table>
	</main>
</body>
</html>