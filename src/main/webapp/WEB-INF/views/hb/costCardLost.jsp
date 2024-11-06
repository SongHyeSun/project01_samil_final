<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../1.main/user_header.jsp" %>
<html>
<head>
    <title>카드 분실 신고</title>
    <style type="text/css">
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        main {
	    background-color: #fff;
		margin: 50px 150px;
	    border-radius: 8px;
	    padding-bottom: 50px;
		}
        h2 {
            color: #3333CC;
            margin-bottom: 20px;
            text-align: center;
        }
        .form1 {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            margin: 0 auto;
        }
        label {
            display: block;
            margin: 10px 0 5px;
            color: #333;
        }
        select, input[type="text"], input[type="date"], button {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-bottom: 15px;
            font-size: 14px;
        }
        select:focus, input[type="text"]:focus, input[type="date"]:focus {
            border-color: #3333CC;
            outline: none;
        }
        button {
            background-color: #3333CC;
            color: #ffffff;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        button:hover {
            background-color: #005999;
        }
        #cardDetails {
            display: flex;
            justify-content: space-between;
            padding: 10px;
        }
        #cardDetails div {
            flex: 1; /* Flexbox for equal width */
            margin-right: 10px;
        }
        #cardDetails div:last-child {
            margin-right: 0; /* Remove margin from the last item */
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        function fetchCardDetails() {
            const cardNum = $('#cardNum').val();
            const contextPath = '${pageContext.request.contextPath}';

            $.ajax({
                url: `${contextPath}/hb/getCardDetails`,
                type: 'GET',
                data: { cardNum: cardNum },
                success: function(data) {
                    if (data) {
                        $('#Name').val(data.name || ''); // 사원 이름
                        $('#Deptno').val(data.deptno || ''); // 부서 번호
                    } else {
                        console.log("해당 카드 번호에 대한 데이터가 없습니다.");
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.error('카드 세부 정보 가져오기 오류:', textStatus, errorThrown);
                }
            });
        }
    </script>
</head>
<body>
<main>
    <h2>카드 분실 신고</h2>
	
    <form action="costCardLost" method="post" class="form1">
    <input type="hidden" name="cardBank" value="${card.cardBank}">
        <label for="cardNum">카드번호:</label>
        <select id="cardNum" name="cardNum" onchange="fetchCardDetails()">
            <c:forEach var="card" items="${cardSearchList}">
                <option value="${card.cardNum}">${card.cardNum}{${card.name}/${card.deptName}}</option>
            </c:forEach>
        </select>
        
        <div id="cardDetails">
            <div>
                <label for="Name">이름:</label>
                <input type="text" id="Name" name="name" readonly />
            </div>
            <div>
                <label for="Deptno">부서번호:</label>
                <input type="text" id="Deptno" name="deptno" readonly />
            </div>
        </div>

        <label for="lostDate">분실 날짜:</label>
        <input type="date" id="lostDate" name="lostDate" required />

        <button type="submit">신고하기</button>
    </form>
</main>
</body>
</html>
