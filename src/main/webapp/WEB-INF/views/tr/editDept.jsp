<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../1.main/admin_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서 수정</title>
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
        margin-top: 50px;
        max-width: 600px; /* 최대 너비 설정 */
    }
    h2 {
        color: #333;
        border-bottom: 2px solid #B0BEC5; /* 회색 밑줄 */
        padding-bottom: 10px;
        margin-bottom: 20px;
        text-align: center; /* 제목 중앙 정렬 */
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }
    th, td {
        padding: 12px;
        border: 2px solid #ddd;
        text-align: left;
    }
    th {
        background-color: #8C8C8C; /* 회색 헤더 배경 */
        color: white;
        font-size: 16px;
    }
    td input[type="text"], td select {
        width: 95%;
        padding: 8px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 16px;
    }
    input[type="submit"], button {
        background-color: #B0BEC5; /* 회색 버튼 배경 */
        color: white;
        border: none;
        padding: 10px 15px;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
        width: 20%;
    }
    input[type="submit"]:hover, button:hover {
        background-color: #90A4AE; /* 마우스 오버 시 색상 */
    }
</style>
</head>
<body>
    <main>
        <h2>부서 수정</h2>
        <form action="updateDept" method="post">
            <input type="hidden" value="${dept.deptno}" name="deptno">
            <table>
                <tr>
                    <th>항목</th>
                    <th>내용</th>
                </tr>
                <tr>
                    <td>부서명</td>
                    <td><input type="text" value="${dept.deptName}" name="deptName" required></td>
                </tr>
                <tr>
                    <td>부서장</td>
                    <td>
                        <select name="manager" required>
                            <c:forEach var="emp1" items="${empList}">
                                <option value="${emp1.empno}"
                                    <c:if test="${dept.manager eq emp1.empno}"> selected="selected" </c:if>>
                                    <c:choose>
                                        <c:when test="${emp1.grade == 100}">${emp1.empno} 사원</c:when>
                                        <c:when test="${emp1.grade == 110}">${emp1.empno} 주임</c:when>
                                        <c:when test="${emp1.grade == 120}">${emp1.empno} 대리</c:when>
                                        <c:when test="${emp1.grade == 130}">${emp1.empno} 과장</c:when>
                                        <c:when test="${emp1.grade == 140}">${emp1.empno} 차장</c:when>
                                        <c:when test="${emp1.grade == 150}">${emp1.empno} 부장</c:when>
                                        <c:when test="${emp1.grade == 160}">${emp1.empno} 사장</c:when>
                                    </c:choose> ${emp1.name}
                                </option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>부서대표번호</td>
                    <td><input type="text" value="${dept.depttel}" name="deptTel" required></td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center;">
                        <input type="submit" value="수정">
                        <button type="button" onclick="location.href='/tr/deleteDept?deptno=${dept.deptno}'">삭제</button>
                    </td>
                </tr>
            </table>
        </form>
    </main>
</body>
</html>
