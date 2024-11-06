<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../1.main/user_header.jsp"%>
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
	    width: 500px;
	    border-collapse: collapse;
	    border-radius: 8px;
	    overflow: hidden;
	}
	
	 td {
	    border-color: #007acc;
	    color: #333333;
	    overflow: hidden;
	    padding: 10px 5px;
	    word-break: normal;
	}
	
	th {
	    background-color: #034EA2;
	    border-color: #005999;
	    color: #ffffff;
	    font-size: 14px;
	    font-weight: normal;
	    overflow: hidden;
	    padding: 10px 5px;
	    word-break: normal;
	    text-align: center;
	}
	
	.showMem {
		margin-left: 180px;
		border-radius: 10px;
		border: 0px;
		background: #EAEAEA;
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
<title>조직도조회</title>
</head>
<body>
	<main>
		<h2>조직도 조회</h2>
		<hr color="#3333CC">
 		<table border="1">
			<tr>
				<th style="border-right: none; width: 200px;">부서명</th>
				<th style="border-left: none;"></th>
			</tr>
			<c:forEach var="dept" items="${deptList}">
				<c:if test="${dept.higherdeptno == 0}">
					<tr>
						<td style="border-right: none;" >${dept.deptName}</td>
						<td style="border-left: none;"><a
							href="showDeptMemberUser?deptno=${dept.deptno}">
						<input class="showMem" type="button" value="구성원 보기"></a></td>
					</tr>
					<c:set var="deptno" value="${dept.deptno}"></c:set>
					<c:forEach var="dept" items="${deptList}">
						<c:if test="${dept.higherdeptno == deptno}">
							<tr>
								<td style="border-right: none;" >ㄴ${dept.deptName}</td>
								<td style="border-left: none;"><a
									href="showDeptMemberUser?deptno=${dept.deptno}">
								<input class="showMem" type="button" value="구성원 보기"></a></td>
							</tr>
							<c:set var="deptno1" value="${dept.deptno}"></c:set>
							<c:forEach var="dept" items="${deptList}">
								<c:if test="${dept.higherdeptno == deptno1}">
									<tr>
										<td style="border-right: none;">&nbsp;&nbsp;ㄴ${dept.deptName}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
										<td style="border-left: none;"><a
											href="showDeptMemberUser?deptno=${dept.deptno}">
										<input class="showMem" type="button" value="구성원 보기"></a></td>
									</tr>
								</c:if>
							</c:forEach>
						</c:if>
					</c:forEach>
				</c:if>
			</c:forEach>
		</table>
		<table>
			<c:forEach var="dept" items="${deptList}">
			</c:forEach>
		</table>						
	</main>
</body>
</html>