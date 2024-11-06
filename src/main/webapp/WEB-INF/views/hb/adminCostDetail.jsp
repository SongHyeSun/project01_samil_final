<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../1.main/admin_header.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>정산 상세 페이지입니다</title>
    <style>
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
    
    input[type="text"], input[type="file"], input[type="date"] {
        width: 90%;
        padding: 8px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 16px;
    }

        tr:nth-child(even) {
            background-color: #e9e9e9; /* 짝수 행 회색 */
        }

        tr:hover {
            background-color: #d0d0d0; /* 마우스 오버 시 색상 변화 */
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
    <h2>정산 상세 정보</h2>
    <table>
        <tr>
            <th>처리상태</th>
            <td style="display: flex; align-items: center; text-align: center;">
                <select id="adminStatusSelect" >
                    <c:forEach var="costStatus" items="${statusList}">
                        <option value="${costStatus.key}" 
                                <c:if test="${costDetail.costStatus == costStatus.key}">selected</c:if>
                        >${costStatus.value}</option>
                    </c:forEach>
                </select>
                <div class="button-container" style="margin-left: 5px;">
                    <button class="btn btn-outline-secondary btn-sm" onclick="changeStatus()">상태변경</button>
                </div>
            </td>
        </tr>
        <tr><th>순서</th><td>${costDetail.costYear}</td></tr>
        <tr><th>비용항목</th><td>${costDetail.codeName}</td></tr>
        <tr><th>제목</th><td>${costDetail.costTitle}</td></tr>
        <tr><th>신청자</th><td>${costDetail.name}</td></tr>
        <tr><th>부서/부서번호</th><td>${costDetail.deptName}/${costDetail.deptno }</td></tr>
        <tr><th>금액</th><td>${costDetail.costMoney}</td></tr>
        <tr><th>증빙서류</th><td>${costDetail.attach}</td></tr>
    </table>
	<div style="text-align: center;">
		<button onclick="location.href='adminCostCheck'" class="btn btn-outline-secondary">목록</button>
	</div>

</main>
    <script>
        function changeStatus() {
            var selectedStatus = document.getElementById("adminStatusSelect").value;
            var costTitle = "${costDetail.costTitle}";
            var costYear = "${costDetail.costYear}";

            console.log("Selected Status:", selectedStatus);
            console.log("Cost Title:", costTitle);
            console.log("Cost Year:", costYear);

            // AJAX 요청
            $.ajax({
                url: 'adminStatusSelect',
                method: 'GET',
                data: {
                    costTitle: costTitle,
                    costStatus: selectedStatus,
                    costYear: costYear
                },
                success: function(data) {
                    alert(data);
                    location.reload(); // 페이지 새로고침
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    alert('오류 발생: ' + textStatus);
                    console.error('오류:', errorThrown);
                }
            });
        }
    </script>
</body>
</html>
