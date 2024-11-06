<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../1.main/user_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
body {
        background-color: #ffffff;
        color: #333333;
        font-family: Arial, sans-serif;
    }
    main {
        margin-left: 200px;
        padding: 20px;
        border-radius: 8px; /* 둥글게 만들기 */
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
        background-color: #f9f9f9; /* 부드러운 배경색 */
    }
    h2 {
        color: #000099; /* 진한 파란색 제목 */
        border-bottom: 2px solid #000099; /* 제목 아래 선 */
        padding-bottom: 10px;
        margin-bottom: 20px;
    }
    table {
        width: 100%;
        border-collapse: collapse;
    }
    th, td {
        padding: 12px;
        border: 1px solid #ccc;
        text-align: left;
    }
    th {
        background-color: #000099; /* 진한 파란색 헤더 배경 */
        color: white; /* 흰색 글자 */
    }
    td input[type="text"], td input[type="number"], td input[type="file"] {
        width: 95%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px; /* 입력 필드 둥글게 */
        font-size: 16px;
    }
    td input[type="text"]:focus, td input[type="number"]:focus {
        border-color: #000099; /* 포커스 시 진한 파란색 테두리 */
        outline: none; /* 기본 포커스 아웃라인 제거 */
    }
    input[type="submit"], input[type="reset"] {
        background-color: #000099; /* 버튼 배경색 */
        color: white; /* 버튼 글자색 */
        border: none;
        padding: 10px 20px;
        border-radius: 4px; /* 버튼 둥글게 */
        cursor: pointer; /* 커서 포인터 */
        font-size: 16px;
        margin: 5px; /* 버튼 간격 */
    }
    input[type="submit"]:hover, input[type="reset"]:hover {
        background-color: #003366; /* 버튼 호버 시 진한 파란색 */
    }
    .button-container {
        text-align: center; /* 버튼 중앙 정렬 */
        margin-top: 20px; /* 위쪽 여백 */
    }
</style>
<title>정산 신청</title>
<script>
    function updateCostCode() {
        const codeNumSelect = document.getElementById('codeNum');
        const selectedOption = codeNumSelect.options[codeNumSelect.selectedIndex];
        const costCodeInput = document.getElementById('costCode');
        costCodeInput.value = selectedOption.value; // 자동으로 코드 입력
    }
</script>
</head>
<body>
    <main>
        <h2>정산 신청 페이지</h2>
        <form action="submitCost" method="post">
        	<input type="hidden" value="${cost.status }">
            <table>
                <tr>
                    <th><label for="costCode">코드</label></th>
                    <td><input type="number" name="costCode" id="costCode" readonly="readonly" placeholder="100"></td>
                </tr>
                <tr>
                    <th><label for="costTitle">제목:</label></th>
                    <td><input type="text" name="costTitle" id="costTitle" required></td>
                </tr>
                <tr>
                    <th><label for="name">신청자 </label> <label for="deptName">/ 부서코드</label></th>
                    <td>
                        <input type="hidden" name="empno" value="${emp.empno}">
                        <input type="hidden" name="deptno" value="${emp.deptno}">

                        <input type="text" name="name" id="name" value="${emp.name}" > 
                        <input type="text" name="deptName" id="deptName" value="${emp.deptno}">	
                    </td>
                </tr>
                <tr>
                    <th><label for="signdate">작성일:</label></th>
                    <td>
                    <input type="text" name="signdate" id="signdate" value="<%= new java.text.SimpleDateFormat("yyyy/MM/dd").format(new java.util.Date()) %>" readonly>
                	</td>
                </tr>
                <tr>
                    <th><label for="costMoney">금액:</label></th>
                    <td><input type="number" name="costMoney" id="costMoney" required></td>
                </tr>
                <tr>
                    <th><label for="codeNum">비용항목:</label></th>
                    <td>
                        <select name="codeNum" id="codeNum" onchange="updateCostCode()">
                            <c:forEach var="costCode" items="${costCode}">
                                <option value="${costCode.codeNum}">${costCode.codeName}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th><label for="attach">첨부파일:</label></th>
                    <td><input type="file" name="attach" id="attach"></td>
                </tr>
                <tr>
                    <td colspan="2" class="button-container">
                        <input type="submit" value="신청하기">
                        <input type="reset" value="초기화">
                    </td>
                   </tr>
            </table>
        </form>
    </main>
</body>
</html>
