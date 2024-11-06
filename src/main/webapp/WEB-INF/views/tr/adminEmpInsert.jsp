<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../1.main/admin_header.jsp"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">	
    <title>관리자 사원정보등록</title>
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
            max-width: 1000px;
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
            border-radius: 8px;
            overflow: hidden;
        }
        th, td {
            padding: 12px;
            border: 2px solid #ddd;
            text-align: center;
        }
        th {
            background-color: #8C8C8C; /* 회색 헤더 배경 */
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
        select {
            width: 92%; /* select 박스 너비 조정 */
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }
        input[type="submit"], input[type="reset"] {
            background-color: #B0BEC5; /* 회색 버튼 배경 */
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        input[type="submit"]:hover, input[type="reset"]:hover {
            background-color: #90A4AE; /* 마우스 오버 시 색상 */
        }
        
        #emailId {
        	width: 200px;
        }
        
        #emailDomain {
        	width: 263px;       	
        }
        
        #emailDomainSelect {
        	width: 263px;
        	height: 42px;
        }
        
        .select {
        	width: 750px;
        }
    </style>
    <script type="text/javascript">
        function updateEmailDomain() {
            const domainSelect = document.getElementById("emailDomainSelect");
            const domainInput = document.getElementById("emailDomain");

            if (domainSelect.value === "custom") {
                domainInput.value = "";
                domainInput.readOnly = false;
                domainInput.focus();
            } else {
                domainInput.value = domainSelect.value;
                domainInput.readOnly = true;
            }
        }
    </script>
</head>
<body>
    <main>
        <h2>관리자 사원정보등록</h2>
        <form name="join" action="addEmp" method="post" enctype="multipart/form-data">
            <table>
                <tr>
                    <th>항목</th>
                    <th>내용</th>
                </tr>
                <tr>
                    <td>사진</td>
                    <td><input type="file" name="image"></td>
                </tr>
                <tr>
                    <td>이름</td>
                    <td><input type="text" required="required" name="name"></td>
                </tr>
                <tr>
                    <td>이메일</td>
                    <td>
                        <input type="text" id="emailId" name="emailId" required>@
                        <input type="text" id="emailDomain" name="emailDomain" placeholder="직접 입력">
                        <select id="emailDomainSelect" onchange="updateEmailDomain()">
                            <option value="custom" selected>직접 입력</option>
                            <option value="gmail.com">gmail.com</option>
                            <option value="naver.com">naver.com</option>
                            <option value="daum.net">daum.net</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>전화번호</td>
                    <td><input type="text" name="phone"></td>
                </tr>
                <tr>
                    <td>직급</td>
                    <td>
                        <select name="grade" class="select">
                            <option value=100>사원</option>
                            <option value=110>주임</option>
                            <option value=120>대리</option>
                            <option value=130>과장</option>
                            <option value=140>차장</option>
                            <option value=150>부장</option>
                            <option value=160>사장</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>직책</td>
                    <td>
                        <select name="job" class="select">
                            <option value="100">평사원</option>
                            <option value="110">팀장</option>
                            <option value="120">대표</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>은행</td>
                    <td><input type="text" name="bank"></td>
                </tr>
                <tr>
                    <td>계좌</td>
                    <td><input type="text" name="account"></td>
                </tr>
                <tr>
                    <td>주소</td>
                    <td><input type="text" name="address"></td>
                </tr>
                <tr>
                    <td>입사일</td>
                    <td><input type="date" name="hiredate"></td>
                </tr>
                <tr>
                    <td>부서</td>
                    <td>
                        <select name="deptno" class="select">
                            <c:forEach var="dept" items="${deptList}">
                                <option value="${dept.deptno}">${dept.deptName}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
            </table>
            <input value="${emp.empno}" name="recentEditor" hidden="hidden">
            <div style="text-align: center;">
                <input type="submit" value="제출하기">
                <input type="reset" value="초기화">
            </div>
        </form>
    </main>
</body>
</html>