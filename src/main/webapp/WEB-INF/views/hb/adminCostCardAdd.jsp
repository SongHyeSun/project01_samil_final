<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../1.main/admin_header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카드 추가</title>
<style type="text/css">
	body {
        font-family: Arial, sans-serif;
        background-color: #f0f0f0; /* 연한 회색 배경 */
        margin:0;
        padding: 20px;
    }
    main {
        padding: 20px;
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        margin: 0 auto;
        max-width: 1000px; /* 최대 폭 설정 */
        margin-top: 50px;
    }
    h2 {
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
    
    input[type="text"] {
        width: 90%;
        padding: 8px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 16px;
    }	

    buttons[type="submit"]:hover, button:hover {
        background-color: #7A7A7A; /* 마우스 오버 시 색상 */
    }
    a {
        text-decoration: none;
    }
    
	button[type="submit"], button{
        background-color: #8C8C8C; /* 버튼 배경색 */
        color: white;
        border: none;
        padding: 7px 20px;
        margin: 10px;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
        transition: background-color 0.3s ease;
    }
    select {
		    background-color: #ffffff;
		    width: 200px;
		    height: 35px;
		    padding: 5px;
		    border-radius: 5px;
		    border: 1px solid #ccc;
		    margin-right: 5px;
		    text-align: left;
		}
</style>
</head>
<body>
<main>
    <h2>카드 추가</h2>
    <form action="adminCostCardAdd" method="post">
        <table>
            <tr>
                <th>카드번호</th>
                <td><input type="text" name="cardNum" required></td>
            </tr>
            <tr>
                <th>카드사</th>
                <td><input type="text" name="cardBank" required></td>
            </tr>
            <tr>
                <th>보유직원</th>
                <td><select name="empno" required>
                    <option value="">직원을 선택하세요</option>
                	<c:forEach var="emp" items="${empList}">
            			<option value="${emp.empno}">${emp.name}/${emp.empno}</option> 
            		</c:forEach>
				</td>
            </tr>
       </table>
       <div style="text-align: center;">
	       <button class="btn btn-outline-secondary" type="submit">제출</button>
	       <a href="adminCostCard"><button class="btn btn-outline-secondary">돌아가기</button></a>
		</div>
    </form>
</main>
</body>
</html>
