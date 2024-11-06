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
        
        #bottombutton {
        	background-color: #B0BEC5; /* 회색 버튼 배경 */
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
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
        <h2>관리자 사원정보수정</h2>
        <form name="join" action="updateEmp" method="post" enctype="multipart/form-data">
        <input value="${emp.empno}" name="recentEditor" hidden="hidden">
        <input value="${emp.image}" name="image1" hidden="hidden">
            <table>
                <tr>
                    <th>항목</th>
                    <th>내용</th>
                </tr>
                <tr>
                    <td>사진 변경</td>
                    <td><input type="file" name="image" value="${emp1.image}"></td>
                </tr>
                <tr>
                    <td>이름</td>
                    <td>
                        ${emp1.name}
                        <input type="text" required="required" name="name" hidden="hidden" value="${emp1.name}">
                    </td>
                </tr>
                <tr>
                    <td>사원번호</td>
                    <td>
                        ${emp1.empno}
                        <input type="number" required="required" name="empno" hidden="hidden" value="${emp1.empno}">
                    </td>
                </tr>
                <tr>
                    <td>이메일</td>
                    <td>
                        <input type="text" id="emailId" name="emailId" required value="${emp1.email1}">@
                        <input type="text" id="emailDomain" name="emailDomain" placeholder="직접 입력" value="${emp1.email2}">
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
                    <td><input type="text" name="phone" value="${emp1.phone}"></td>
                </tr>
                <tr>
                    <td>직급</td>
                    <td>
                        <select name="grade">
                            <option value=100 <c:if test="${emp1.grade eq 100}">selected="selected"</c:if>>사원</option>
                            <option value=110 <c:if test="${emp1.grade eq 110}">selected="selected"</c:if>>주임</option>
                            <option value=120 <c:if test="${emp1.grade eq 120}">selected="selected"</c:if>>대리</option>
                            <option value=130 <c:if test="${emp1.grade eq 130}">selected="selected"</c:if>>과장</option>
                            <option value=140 <c:if test="${emp1.grade eq 140}">selected="selected"</c:if>>차장</option>
                            <option value=150 <c:if test="${emp1.grade eq 150}">selected="selected"</c:if>>부장</option>
                            <option value=160 <c:if test="${emp1.grade eq 160}">selected="selected"</c:if>>사장</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>직책</td>
                    <td>
                        <select name="job">
                            <option value="100" <c:if test="${emp1.job eq 100}">selected="selected"</c:if>>평사원</option>
                            <option value="110" <c:if test="${emp1.job eq 110}">selected="selected"</c:if>>팀장</option>
                            <option value="120" <c:if test="${emp1.job eq 120}">selected="selected"</c:if>>대표</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>은행</td>
                    <td><input type="text" name="bank" value="${emp1.bank}"></td>
                </tr>
                <tr>
                    <td>계좌</td>
                    <td><input type="text" name="account" value="${emp1.account}"></td>
                </tr>
                <tr>
                    <td>주소</td>
                    <td><input type="text" name="address" value="${emp1.address}"></td>
                </tr>
                <tr>
                    <td>부서</td>
                    <td>
                        <select name="deptno">
                            <c:forEach var="dept" items="${deptList}">
                                <option value="${dept.deptno}" <c:if test="${emp1.deptno eq dept.deptno}">selected="selected"</c:if>>${dept.deptName}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                
                <tr>              
                	<c:choose>
                		<c:when test="${emp.admin eq 160}">
	                    <td>권한</td>
	                    <td>                           
                                <input type="radio" name="admin" value="100" <c:if test="${emp1.admin eq 100}">checked="checked"</c:if>>인사
                                <input type="radio" name="admin" value="110" <c:if test="${emp1.admin eq 110}">checked="checked"</c:if>>결재
                                <input type="radio" name="admin" value="120" <c:if test="${emp1.admin eq 120}">checked="checked"</c:if>>급여
                                <input type="radio" name="admin" value="130" <c:if test="${emp1.admin eq 130}">checked="checked"</c:if>>비용
                                <input type="radio" name="admin" value="140" <c:if test="${emp1.admin eq 140}">checked="checked"</c:if>>게시판
                                <input type="radio" name="admin" value="150" <c:if test="${emp1.admin eq 150}">checked="checked"</c:if>>일정
                                <input type="radio" name="admin" value="160" <c:if test="${emp1.admin eq 160}">checked="checked"</c:if>>마스터
                                <input type="radio" name="admin" value="170" <c:if test="${emp1.admin eq 170}">checked="checked"</c:if>>권한없음
                         </td>       
                            </c:when>
                            <c:otherwise>
                                <input type="text" name="admin" value="${emp1.admin}" hidden="hidden">
                            </c:otherwise>
                        </c:choose>
                    
                </tr>
            </table>
            <div style="text-align: center;">
                <input type="submit" value="수정">
                <button type="button" id="bottombutton" onclick="location.href='deleteEmp?empno=${emp1.empno}'">삭제</button>
            </div>
        </form>
    </main>
</body>

</html>