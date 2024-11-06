<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../1.main/admin_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
	    color: #6E6E6E;
	    border-bottom: 2px solid #6E6E6E; /* 언더라인 색상 */
	    padding-bottom: 5px; /* 텍스트와 언더라인 사이의 여백 */
	    margin-bottom: 20px; /* 아래쪽 여백 */
	    font-weight: bold; /* 글자 두께 */
	    display: inline-block; /* 텍스트 너비만큼만 표시 */
	}
	
	table {
	    margin: 20px auto;
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
	    background-color: #6E6E6E;
	    border-color: #005999;
	    color: #ffffff;
	    font-size: 14px;
	    font-weight: normal;
	    overflow: hidden;
	    padding: 10px 5px;
	    word-break: normal;
	}

	.tg tr:hover, table tr:hover {
		background-color: #e0e0e0; /* 호버 시 배경색 */
	}

	select {
	    background-color: #ffffff;
	    width: 200px;
	    height: 35px;
	    padding: 5px;
	    border-radius: 5px;
	    border: 1px solid #ccc;
	    margin-right: 5px;
	}
	
	button {
	    padding: 5px 10px;
	    border: none;
	    border-radius: 5px;
	    background-color: #034EA2;
	    color: #ffffff;
	    cursor: pointer;
	    transition: background-color 0.3s;
	}
	
	button:hover {
		background-color: #023a8a; /* 호버 시 색상 */
	}

	.pagination {
		display: block;
		text-align: center;
		margin: 50px 0;
	}

	.pagination a {
		margin: 0 5px;
		text-decoration: none;
		color: #007BFF;
	}
	.approval-link {
		color: #007BFF; /* 링크 색상 */
		text-decoration: none; /* 기본 밑줄 제거 */
	}

	.approval-link:hover {
		text-decoration: underline; /* 호버 시 밑줄 추가 */
	}

	.status-red {
	    background-color: rgb(255, 36, 36);
	    color: black; /* Optional: Change text color for better contrast */
	}
	
	.status-green {
	    background-color: rgb(89, 218, 80);
	    color: black; /* Optional */
	}
	
	.status-yellow {
	    background-color: rgb(247, 234, 110);
	    color: black; /* Optional */
	}
	
	.status-white {
	    background-color: rgb(189, 189, 189);
	    color: black; /* Optional */
	}
</style>
<title>관리자 결재</title>
</head>
<body>
<main>
    <h2>전체보관함</h2>
    <div style="display: flex; justify-content: space-between; align-items: center;">
	<c:choose>
	    <c:when test="${searchCount > 0}">
	        <h5>검색된 결과 개수: ${searchCount}</h5>
	    </c:when>
	    <c:otherwise>
	        <h5>전체 보관함: ${adminApp}</h5>
	    </c:otherwise>
	</c:choose>
	</div>
	
	<table class="tg">
		<tr>
			<th>결재항목</th><th>작성자</th><th>문서명</th><th>부서명</th><th>기안일</th><th>결재상태</th><th>승인일</th>
		</tr>
		<c:forEach var="Approval" items="${adminAppList}">
			<c:if test="${Approval.approvalNum != lastApprovalNum || Approval.documentFormId != lastdocumentFormId}">
				<tr>
					<td>
			            <c:choose>
								<c:when test="${Approval.documentFormId == 100}">연차</c:when>
								<c:when test="${Approval.documentFormId == 110}">병가</c:when>
								<c:when test="${Approval.documentFormId == 120}">경조사</c:when>
								<c:when test="${Approval.documentFormId == 130}">법인</c:when>
								<c:when test="${Approval.documentFormId == 140}">비품</c:when>
								<c:when test="${Approval.documentFormId == 150}">유류비</c:when>
								<c:when test="${Approval.documentFormId == 160}">휴직</c:when>
						</c:choose>
					</td>
					<td>${Approval.name}</td>
					<td><a href="appDetail?approvalNum=${Approval.approvalNum}&documentFormId=${Approval.documentFormId}">${Approval.approvalTitle}</a></td>
			        <td>${Approval.deptName}</td>
			        <td>
			        	<fmt:formatDate value="${Approval.approvalDate}" pattern="yy/MM/dd" />
			        </td>	
					<td class="${Approval.approvalCondition == 130 ? 'status-red' : 
					             Approval.approvalCondition == 120 ? 'status-green' : 
					             Approval.approvalCondition == 110 ? 'status-yellow' : 
					             Approval.approvalCondition == 100 ? 'status-white' : ''}">
					    ${statusMap[Approval.approvalCondition]}
					</td>
	            	<td>
					   <fmt:formatDate value="${Approval.approvalCompleteDate}" pattern="yy/MM/dd" />
					</td>
				</tr>
				<c:set var="num" value="${num-1}"></c:set>
			</c:if>
		</c:forEach>
	</table>
	
	<c:set var="num" value="${page.total-page.start+1 }"></c:set>
	
	<div class="pagination">
		<c:if test="${page.startPage > page.pageBlock}">
			<a href="adminApp?currentPage=${page.startPage-page.pageBlock}">[이전]</a>
		</c:if>
		<c:forEach var="i" begin="${page.startPage}" end="${page.endPage }">
			<a href="adminApp?currentPage=${i}">[${i}]</a>
		</c:forEach>
		<c:if test="${page.endPage < page.totalPage}">
			<a href="adminApp?currentPage=${page.startPage + page.pageBlock}">[다음]</a>
		</c:if>	
	</div>

	<form action="adminAppListSearch" style="text-align: center;">
		<select name="search">
			<option value="s_approvalTitle">제목</option>
			<option value="s_name">작성자</option>
			<option value="s_deptName">부서명</option>
		</select>
		<input type="text" name="keyword">
		<button type="submit">검색</button><p>
	</form>
</main>
</body>
</html>