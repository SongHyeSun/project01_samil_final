<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../1.main/user_header.jsp" %>
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
	    color: #034EA2;
	    border-bottom: 2px solid #034EA2; /* 언더라인 색상 */
	    padding-bottom: 5px; /* 텍스트와 언더라인 사이의 여백 */
	    margin-bottom: 20px; /* 아래쪽 여백 */
	    font-weight: bold; /* 글자 두께 */
	    display: inline-block; /* 텍스트 너비만큼만 표시 */
	}

	.container {
		padding-right: 0;
		padding-left: 0;
		margin-right: 0;
		margin-left: 0;
	}

    .searchCard {
        background-color: white; /* 버튼 배경색 */
        color: black; /* 버튼 글자색 */
        cursor: pointer;
        border: none;
        border-radius: 5px;
        padding: 5px 10px;
        transition: background-color 0.3s; /* 부드러운 효과 */
    }

    .searchCardBox {
        margin-right: 10px; /* 입력 박스와의 간격 */
    }
    .searchCardBox:focus, .searchCard:focus {
        border-color: #3333CC; /* 진한 파란색 포커스 */
        outline: none;
    }
    .  submitButton {
    	background-color: #3333CC;
    }
    
    .searchCard:hover {
        background-color: #3333CC; /* 버튼 호버 시 색상 변경 */
    }
    .cardLost {
        background-color: #034EA2; /* 진한 파란색 */
        color: #fff;
        border: none;
        padding: 10px 20px;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
        transition: background-color 0.3s; /* 부드러운 효과 */
    }
    .cardLost:hover {
        background-color: #005999; /* 버튼 호버 시 색상 변경 */
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    th, td {
        padding: 12px;
        text-align: center;
    }
    th {
        background-color: #034EA2; /* 진한 파란색 헤더 배경 */
        color: white;
    }
    tr:hover {
        background-color: #e0e0e0;
    }
    .CardUseNum {
        width: 60px;
    }
    th.cardNumber {
        border-top-left-radius: 8px; /* 왼쪽 상단 둥글게 */
    }
    th:last-child {
        border-top-right-radius: 8px; /* 오른쪽 상단 둥글게 */
    }
</style>
<title>카드</title>
</head>
<body>
<main>
	<div>
    <h2>카드 사용내역</h2>
    </div>
    	<div style="display: flex; justify-content: space-between; align-items: center;">
    <a href="costCardLost">
        <input type="button" class="cardLost" value="분실 신고">
    </a>
    <form action="cardUseSearch" method="get" class="searchCard">
        <select name="search" id="costsearchCard" class="searchCard">
            <option value="cardNum" <c:if test="${selectedSearch == 'cardNum'}">selected</c:if>>카드번호</option>
            <option value="name" <c:if test="${selectedSearch == 'name'}">selected</c:if>>보유직원</option>
            <option value="deptName" <c:if test="${selectedSearch == 'deptName'}">selected</c:if>>부서이름</option>
            <option value="useDate" <c:if test="${selectedSearch == 'useDate'}">selected</c:if>>사용일</option>
        </select>
        <input type="text" name="keyword" class="searchCardBox" placeholder="검색어를 입력하세요" value="${keyword}">
        <button type="submit" class="searchCard">검색</button>
    </form>
</div>

    <table>
        <tr>
            <td class="CardUseNum">순서</td>
            <th class="cardNumber">카드번호</th>
            <th>사용처</th>
            <th>보유직원/부서이름</th>
            <th>사용일</th>
            <th>금액</th>
        </tr>
	        <c:if test="${not empty cardUseList}">
	    <c:forEach var="cardUse" items="${cardUseList}" varStatus="status">
	        <tr>
	            <td>${status.index + 1}</td>
	            <td>${cardUse.cardNum}</td>
	            <td>${cardUse.place}</td>
				<td>${cardUse.name}/${cardUse.deptName}</td>
	            <td>${cardUse.useDate}</td>
	            <td>${cardUse.cardCost}</td>
	        </tr>
	    </c:forEach>
	</c:if>
<c:if test="${empty cardUseList}">
    <tr>
        <td colspan="6">검색 결과가 없습니다.</td>
    </tr>
</c:if>
</table>
</main>
</body>
</html>
