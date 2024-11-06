<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../1.main/user_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인정보 수정</title>
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
        max-width: 700px; /* 최대 너비 설정 */
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
        background-color: #034EA2; /* 회색 헤더 배경 */
        color: white;
        font-size: 16px;
    }
    td input[type="text"], td input[type="number"], td select {
        width: 95%;
        padding: 8px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 16px;
    }
    input[type="submit"] {
        background-color: #B0BEC5; /* 회색 버튼 배경 */
        color: white;
        border: none;
        padding: 10px 15px;
        border-radius: 4px;
        cursor: pointer;
    }
    input[type="submit"]:hover {
        background-color: #90A4AE; /* 마우스 오버 시 색상 */
    }
    
    #emailId {
        	width: 150px;
        }
        
        #emailDomain {
        	width: 180px;       	
        }
        
        #emailDomainSelect {
        	width: 180px;
        	height: 42px;
        }
</style>
</head>
<body>
    <main>
        <h2>개인정보 수정</h2>
        <form action="updateOwnEmp" method="post">
            <table>
                <tr>
                    <th>항목</th>
                    <th>내용</th>
                </tr>
                <tr>
                    <td>이름</td>
                    <td>${emp.name}</td>
                </tr>
                <tr>
                    <td>사원번호</td>
                    <td>
                        <input type="number" required="required" name="empno" hidden="hidden" value="${emp.empno}">
                        ${emp.empno}
                    </td>
                </tr>
                <tr>
                    <td>이메일</td>
                    <td>
                        <input type="text" id="emailId" name="emailId" required value="${emp.email1}"> @
                        <input type="text" id="emailDomain" name="emailDomain" placeholder="직접 입력" value="${emp.email2}">
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
                    <td><input type="text" name="phone" value="${emp.phone}"></td>
                </tr>
                <tr>
                    <td>은행</td>
                    <td><input type="text" name="bank" value="${emp.bank}"></td>
                </tr>
                <tr>
                    <td>계좌</td>
                    <td><input type="text" name="account" value="${emp.account}"></td>
                </tr>
                <tr>
                    <td>주소</td>
                    <td><input type="text" name="address" value="${emp.address}"></td>
                </tr>              
            </table>
            
            <input value="${emp.empno}" name="recentEditor" hidden="hidden">
             <div style="text-align: center; margin-top: 20px;">
        		<input type="submit" value="수정">
    		</div>
        </form>
    </main>
</body>
</html>
