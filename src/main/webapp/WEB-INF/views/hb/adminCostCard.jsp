<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../1.main/admin_header.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 카드</title>
    <style type="text/css">
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        main {
            max-width: 1000px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 30px;
        }
        h2 {
            color: #6E6E6E;
            padding: 20px 0;
            margin-bottom: 20px;
            text-align: center;
            font-weight: bold;
        }
        a {
            text-decoration: none;
        }
        .button-container {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }
        input[type="button"] {
            background-color: #8C8C8C;
            color: white;
            border: none;
            padding: 10px 20px;
            margin: 10px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            text-transform: uppercase;
            transition: background-color 0.3s ease;
            text-align: center;
        }
        input[type="button"]:hover {
            background-color: #7A7A7A;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            border: 2px solid #ddd;
            text-align: center;
        }
        th {
            background-color: #8C8C8C;
            color: white;
            font-size: 16px;
        }
        tr:nth-child(even) {
            background-color: #f0f0f0;
        }
        tr:hover {
            background-color: #d9d9d9;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
    	$(document).ready(function() {
	        $('.status-change-link').click(function(event) {
	            event.preventDefault();
	
	            var cardNum = $(this).data('cardnum');
	            var confirmation = confirm("분실 카드를 확인하셨습니까?");
	
	            if (confirmation) {
	                var linkElement = $(this); // 현재 링크 요소를 저장
	                $.ajax({
	                    url: '/hb/updateCardDelGubun',
	                    type: 'POST',
	                    data: {
	                        cardNum: cardNum
	                    },
	                    success: function(response) {
	                        alert(response);
	                        // 현재 카드 상태 업데이트
	                        linkElement.closest('td').html('<span style="color: green;">처리 완료</span>'); // 카드 상태 업데이트
	                        linkElement.remove(); // 링크 제거
	                    },
	                    error: function(xhr, status, error) {
	                        alert("오류 발생: " + error);
	                        console.log("code: " + xhr.status);
	                        console.log("message: " + xhr.responseText);
	                    }
	                });
	            }
	        });
    });
    </script>
</head>
<body>
    <main>
        <h2>카드 관리</h2>
        <div class="button-container">
            <a href="adminCostCardPlus"><input type="button" value="내역 추가"></a>
            <a href="adminCostCardAdd"><input type="button" value="카드 추가"></a>
        </div>
        <table>
            <thead>
                <tr>
                    <th>순서</th>
                    <th>카드번호</th>
                    <th>카드사</th>
                    <th>보유직원</th>
                    <th>분실신청</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="card" items="${cardList}" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td>${card.cardNum}</td>
                        <td>${card.cardBank}</td>
                        <td>${card.name}/${card.deptName}</td>
                        <td>
                            <c:choose>
                                <c:when test="${card.cardPermit == 0}">
                                    <span style="color: blue;">${cardMap[card.cardPermit]}</span>
                                </c:when>
                                <c:when test="${card.cardPermit == 110 && card.cardDelGubun == 110}">
                                    <span style="color: red;">처리 완료</span>
                                </c:when>
                                <c:when test="${card.cardPermit == 110 && card.cardDelGubun == 100}">
                                    <a href="#" class="status-change-link" data-cardnum="${card.cardNum}" style="color: green; text-decoration: none;">
                                        ${cardMap[card.cardPermit]}
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <span style="color: gray;">${cardMap[card.cardPermit]}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </main>
</body>
</html>
