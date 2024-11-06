<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../1.main/admin_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정산</title>
<style type="text/css">

 body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 20px;
        background-color: #f4f4f4;
    }
    main {
        margin: 0 auto;
        max-width: 1200px;
        background-color: #fff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    h2 {
        color: #333;
        border-bottom: 2px solid #8C8C8C;
        padding-bottom: 10px;
        margin-bottom: 20px;
    }
    form {
        margin-bottom: 20px;
        text-align: right;
    }
    select, input[type="text"], button {
        padding: 8px;
        margin-right: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        box-sizing: border-box;
    }
    button {
        background-color: #8C8C8C;
        color: white;
        border: none;
        cursor: pointer;
        padding: 10px 15px;
        transition: background-color 0.3s ease;
    }
    button:hover {
        background-color: #7A7A7A;
    }
    table {
        width: 100%;
        border-collapse: collapse;
    }
    th, td {
        padding: 12px;
        border: 1px solid #ddd;
        text-align: center;
    }
    th {
        background-color: #8C8C8C;
        color: white;
    }
    td {
        background-color: #f9f9f9;
    }
      a {
        color: #409cff; /* 기본 링크 색상 */
        text-decoration: none; /* 링크 밑줄 제거 */
    }
    a:hover {
        color: #7AB3E0; /* 마우스 오버 시 색상 */
    }

</style>
</head>
<body>
<main>
    <h2>정산 관리 페이지입니다</h2>
    <form action="admincostSearch" method="get">
       <select name="search" id="searchCost">
    		<option value="codeName" <c:if test="${selectedSearch == 'codeName'}">selected</c:if>>비용항목</option>
    		<option value="name" <c:if test="${selectedSearch == 'name'}">selected</c:if>>신청자</option>
		</select>
        <input type="text" value="${keyword}" name="keyword" placeholder="검색어를 입력하세요">
        <button type="submit">검색</button>
    </form>
    <table>
        <thead>
            <tr>
                <th>순서</th>
                <th>비용항목</th>
                <th>처리상태</th>
                <th>제목</th>
                <th>신청자</th>
                <th>부서</th>
                <th>신청날짜</th>
                <th>금액</th>
                <th>문서번호</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="costCodeCost" items="${adminCostList}" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td>${costCodeCost.codeName}</td>
                        <td>
		          		<c:choose>
							        <c:when test="${costCodeCost.costStatus == 100}">
							            <span style="color: blue;">대기</span>
							        </c:when>
							        <c:otherwise>
							            <span>${costCodeCost.costStatus}</span> 
							       </c:otherwise>
						</c:choose>
						</td>
                        <td><a href="adminCostDetail?costTitle=${costCodeCost.costTitle}">${costCodeCost.costTitle}</a></td>
                        <td>${costCodeCost.name}</td>
                        <td>${costCodeCost.deptName}</td>
                        <td>${costCodeCost.signdate}</td>
                        <td>${costCodeCost.costMoney}</td>
                        <td>${costCodeCost.costYear}-${costCodeCost.signdate}</td>
                    </tr>
            </c:forEach>
        </tbody>
    </table>
</main>
</body>
</html>
