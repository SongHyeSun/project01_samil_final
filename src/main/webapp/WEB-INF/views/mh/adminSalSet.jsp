<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../1.main/admin_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<meta charset="UTF-8">
<title>관리자 급여확인 페이지입니다</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<style type="text/css">

/* 그리드 설정 */
.grid-container {
  display: grid;
  grid-template-columns: 1fr 1fr; /* 두 개의 열로 설정 */
  gap: 20px; /* 그리드 간 간격 */
  margin: 20px;
}

.grid-item {
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 10px;
}

    .salInfo th, .salInfo td{
        border: none !important;
        
    }
body {
    font-family: Arial, sans-serif;
    background-color: #f0f0f0; /* 연한 회색 배경 */
    margin: 0;
    padding: 20px;
}
		main {
	    background-color: #fff;
		margin: 50px 150px;
	    border-radius: 8px;
	    padding-bottom: 50px;
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
        background-color: #6E6E6E; 
        color: white;
        font-size: 16px;
    }

.sertchList {
  width: 200px;
  padding: 5px;
  margin-right: 10px;
}

#key {
  width: 200px;
  padding: 5px;
}

.text {
  width: 200px;
  padding: 5px;
  margin: 5px 0;
  background-color: #f0f0f0;
}

button {
  padding: 10px 15px;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

#empInfo tr:hover {
  background-color: #BDBDBD;
}

    h3 {
        color: #333;
        border-bottom: 2px solid #8C8C8C; 
        padding-bottom: 10px;
        margin-bottom: 20px;
        text-align: center; 
    }
    
    input[type="text"], input[type="file"], input[type="date"]{
        width: 90%;
        padding: 8px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 16px;
    }
    input[type="number"] {
       width: 33%;
        padding: 8px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 16px;
    
    }
    
</style>
<script type="text/javascript">
function btn(){
    alert('계좌 정보가 수정되었습니다.');
}
</script>
</head>
<body>
<main>
	<h3>관리자 급여확인 페이지입니다</h3>

    <div class="grid-container">
    <!-- 첫 번째 테이블: 검색 및 사원 목록 -->
    <div class="grid-item">
        <form action="adminSalSet" method="POST">
            <label for="day">급여 지급일:</label>
            <select id="day" name="day">
                <% String salDate = (String) request.getAttribute("salDate");
                   String dayPart = salDate.substring(salDate.lastIndexOf("/") + 1);
                   int selectedDay = Integer.parseInt(dayPart);
                   for (int i = 1; i <= 31; i++) {
                       String selected = (i == selectedDay) ? "selected" : "";
                %>
                <option value="<%= i %>" <%= selected %>><%= i %></option>
                <% } %>
            </select>
            <button type="submit" class="btn btn-secondary">변경</button>
        </form>

        <form action="listSearch">
            <select class="sertchList" name="search">
                <option value="seartchEmpno">사원번호</option>
                <option value="seartchName">사원명</option>
                <option value="seartchDet">부서</option>
            </select>
            <input type="text" name="keyword" id="key">
            <button type="submit" class="btn btn-secondary">검색</button>
        </form>

        <table id="empInfo">
            <thead>
                <tr>
                    <th>번호</th>
                    <th>사원번호</th>
                    <th>사원명</th>
                    <th>부서</th>
                    <th>직급</th>
                </tr>
            </thead>
            <tbody>
                <c:set var="num" value="1"></c:set>
                <c:forEach var="emp" items="${listEmp}">
                    <tr onclick="salDList(${emp.empno})" id="salDList" style="cursor: pointer;">
                        <td>${num}</td>
                        <td>${emp.empno}</td>
                        <td>${emp.name}</td>
                        <td>${emp.deptName}</td>
                        <td>
                           <c:choose>
                                <c:when test="${emp.grade == 100}">사원</c:when>
                                <c:when test="${emp.grade == 110}">주임</c:when>
                                <c:when test="${emp.grade == 120}">대리</c:when>
                                <c:when test="${emp.grade == 130}">과장</c:when>
                                <c:when test="${emp.grade == 140}">차장</c:when>
                                <c:when test="${emp.grade == 150}">부장</c:when>
                                <c:when test="${emp.grade == 160}">사장</c:when>
                                <c:otherwise>직급 정보 없음</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <c:set var="num" value="${num + 1 }"></c:set>
</c:forEach>
				</tbody>
			</table>
			<table id="paging">

				<c:if test="${page.startPage > page.pageBlock }">
					<a
						href="adminSalSet?currentPage=${page.startPage-page.pageBlock}">[이전]</a>
				</c:if>
				<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
					<a href="adminSalSet?currentPage=${i}">[${i}]</a>
				</c:forEach>
				<c:if test="${page.endPage < page.totalPage }">
					<a
						href="adminSalSet?currentPage=${page.startPage+page.pageBlock}">[다음]</a>
				</c:if>
            </tbody>
        </table>
    </div>

       <!-- 두 번째 테이블: 사원 상세 정보 -->
    <div class="grid-item">
        <table>
            <tr>
                <th>기초 정보</th>
            </tr>
            <tr>
                <td>
                     
                    
                    
                    
                    
                    
                    <table class="salInfo"><thead>
  <tr>
    <td>이름:</td>
    <td><input type="text" id="iname" class="text" readonly></td>
    <td>입사일자:</td>
    <td> <input type="text" id="idate" class="text" readonly></td>
  </tr></thead>
<tbody>
  <tr>
    <td>부서명: </td>
    <td><input type="text" id="idname" class="text" readonly></td>
    <td>직급: </td>
    <td><input type="text" id="igraed" class="text" readonly></td>
  </tr>
</tbody>
</table>
                    
                    
                </td>
            </tr>
            <tr>
                <th>급여 정보</th>
            </tr>
            <tr>
                <td>
                     
                     
                     
                    
                    
                    
                    
                                        <table class="salInfo"><thead>
  <tr>
    <td>기본급:</td>
    <td><input type="text" id="isalBase" class="text" readonly></td>
    <td>식대:</td>
    <td> <input type="text" id="isalFood" class="text" readonly></td>
  </tr></thead>
<tbody>
  <tr>
    <td>상여: </td>
    <td><input type="text" id="isalBonus" class="text" readonly></td>
    <td>추가수당: </td>
    <td> <input type="text" id="isalNight" class="text" readonly></td>
  </tr>
</tbody>
</table>
                </td>
            </tr>
            <tr>
                <th>계좌 정보</th>
            </tr>
            <tr>
                <td>
                    <form action="saveBank" method="POST">
                        <input type="hidden" name="iempno" id="iempno">
                        <select id="inputState" name="selectedBank" class="form-control">
                            <c:forEach var="cl" items="${listEmp}">
                                <c:set var="selected" value="" />
                                <c:if test="${cl.bank == selectedBank}">
                                    <c:set var="selected" value="selected" />
                                </c:if>
                                <option value="${cl.bank}" ${selected}>${cl.bank}</option>
                            </c:forEach>
                        </select>
                        계좌번호: <input type="number" id="iaccount" name="iaccount" class="text">
                        <button id="btn1" onclick="javascript:btn()" type="submit" class="btn btn-secondary">계좌정보 수정</button>
                    </form>
                </td>
            </tr>
        </table>
    </div>
</div>
</main>
	<script type="text/javascript">
	        function salDList(empno) {
	            $.ajax({
	                url: "/mh/getDeptName?empno=" + empno, 
	                type: "GET",         
					dataType:'json',
	                success: function(response) {
console.log(response);

	                	 let gradeName = '';
	                     switch(response.response.grade) {
	                         case 100:
	                             gradeName = '사원';
	                             break;
	                         case 110:
	                             gradeName = '주임';
	                             break;
	                         case 120:
	                             gradeName = '대리';
	                             break;
	                         case 130:
	                             gradeName = '과장';
	                             break;
	                         case 140:
	                             gradeName = '차장';
	                             break;
	                         case 150:
	                             gradeName = '부장';
	                             break;
	                         case 160:
	                             gradeName = '사장';
	                             break;
	                         default:
	                             gradeName = '직급 정보 없음';
	                     }
	                    $('#iname').val(response.response.name);
	                    $('#iempno').val(response.response.empno);
	                    $('#idate').val(response.response.hiredate);
	                    $('#idname').val(response.response.deptName);
	                    $('#igraed').val(gradeName);
	                    $('#isalBase').val(response.response.salBase);
	                    $('#isalFood').val(response.response.salFood);
	                    $('#isalBonus').val(response.response.salBonus);
	                    $('#isalNight').val(response.response.salNight);
	                    $('#iaccount').val(response.response.account);
	                    $('#salDate').val(response.response.salDate);
	                    $('#inputState').val(response.response.bank);
	                    console.log(response);

	                },
	                error: function(xhr, status, error) {
	                    console.error("AJAX 요청 중 오류 발생: ", status, error);
	                    console.log("응답 내용: ", xhr.responseText); 
	                }
	            });
	        }
	        

	        	    
	        
	        document.addEventListener('DOMContentLoaded', function() {
	            var daySelect = document.getElementById('day');

	            daySelect.addEventListener('change', function() {
	                var selectedDay = daySelect.value;
	                alert('선택된 급여 지급일: ' + selectedDay + '일');
	            });
	        });
	        
	        
	        </script>
</body>
</html>