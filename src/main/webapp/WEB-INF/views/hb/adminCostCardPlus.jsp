<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../1.main/admin_header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내역 추가</title>
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
        max-width: 1000px;
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
    td input[type="text"], td input[type="number"], td input[type="date"], td input[type="file"] {
        width: 90%;
        padding: 8px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 16px;
    }
    td input[type="button"], .bottombutton {
        background-color: #B0BEC5; /* 회색 버튼 배경 */
        color: white;
        border: none;
        padding: 8px 12px;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
    }
    td input[type="button"]:hover, .bottombutton:hover {
        background-color: #90A4AE; /* 마우스 오버 시 색상 */
    }
    .bottombutton[type="submit"] {
        background-color: #90A4AE; /* 제출 버튼 색상 */
    }
    .bottombutton[type="submit"]:hover {
        background-color: #78909C; /* 제출 버튼 오버 색상 */
    }
    .bottombutton[type="reset"] {
        background-color: #CFD8DC; /* 초기화 버튼 색상 */
    }
    .bottombutton[type="reset"]:hover {
        background-color: #B0BEC5; /* 초기화 버튼 오버 색상 */
    }
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
	function updateCardDetails() {
	  	  var cardNum = $('#cardNum').val();
	
	    $.ajax({
	        url: '/hb/getCardDetails',  // 카드 세부정보를 가져오는 엔드포인트
	        type: 'GET',
	        data: { cardNum: cardNum },
	        success: function(response) {
	            $('#cardBank').val(response.cardBank);
	            $('#name').val(response.name);
	            $('#deptName').val(response.deptName);
	        },
	        error: function() {
	            alert('카드 세부정보를 가져오는 데 실패했습니다.');
	        }
	    });
	}
	</script>

</head>
<body>
<h2>내역 추가 버튼입니다</h2>
<main>
    <form action="adminCostCardPlus" method="post">
        <table>
            <tr>
                <th>항목</th>
                <th>내용</th>
            </tr>
            <tr>
    			<td>카드번호</td>
    			<td>
				        <select name="cardNum" id="cardNum" required onchange="updateCardDetails()">
				            <c:forEach var="card" items="${cardList}">
				                <option value="${card.cardNum}">${card.cardNum}(${card.name}/${card.deptName })</option>
				            </c:forEach>
       					 </select>
			    </td>
			</tr>
            <tr>
                <td>가맹점</td>
                <td><input type="text" name="place"></td>
            </tr>
            <tr>
                <td>사용날짜</td>
                <td><input type="date" name="useDate"  id="useDateInput" onchange="formatDate()"></td>
            </tr>
            <tr>
                <td>금액</td>
                <td><input type="number" name="cardCost"></td>
            </tr>
            <tr>
                <td>카드사</td>
                <td><input type="text" name="cardBank" value="${card.cardBank}" id="cardBank"></td>
            </tr>
            <tr>
                <td> 부서 / 보유 직원 </td>
                <td>
                    <input type="text" value="${card.name}" name="name" id="name">
                    <input type="text" value="${card.deptName}" name="deptName" id="deptName">
                </td>
            </tr>
            <tr>
                <td>증빙서류</td>
                <td>
                    <input type="file" name="cardPaper" id="cardPaper">
                </td>
            </tr>
        </table>
        <div style="text-align: center;">
            <button type="submit" class="btn btn-outline-secondary">제출하기</button>
            <button type="reset" class="btn btn-light">초기화</button>
        </div>
    </form>
</main>
</body>
</html>
