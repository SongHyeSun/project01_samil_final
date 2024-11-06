<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>추가수당 확인</title>
<style type="text/css">
    body {
        background-color: #f0f0f0;!important
        font-family: Arial, sans-serif;!important
        
    }

    h2 {
        color: #333;
        font-size: 24px;
        margin-bottom: 20px;
    }

    table {
        width: 100%;
        background-color: #ffffff; /* 테이블 배경 흰색 */
        border-collapse: collapse;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        margin-bottom: 20px;
    }

    th, td {
        padding: 15px;
        text-align: center;
        border: 1px solid #ddd; /* 테이블 경계 */
    }

    th {
        background-color: #f1f1f1; /* 옅은 회색 헤더 */
        color: #555;
    }

    td {
        color: #666;
    }

    button {
        background-color: #6c757d; /* 기본 버튼 색상 */
        color: #ffffff;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        margin-right: 10px;
    }

    button:hover {
        background-color: #5a6268; /* 버튼 호버 색상 */
    }

    .btn-outline-secondary {
        background-color: transparent;
        border: 1px solid #6c757d;
        color: #6c757d;
    }

    .btn-outline-secondary:hover {
        background-color: #6c757d;
        color: #ffffff;
    }

    .table-hover tbody tr:hover {
        background-color: #f1f1f1; /* 테이블 행 호버 색상 */
    }

    /* 추가적인 마진 및 패딩 */
    .container {
        padding: 20px;
        background-color: #ffffff;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        margin-top: 30px;
    }
</style>
<script type="text/javascript">
function btn(){
    alert('추가수당이 확정되었습니다.');
}
</script>
<script type="text/javascript">
(function($){
	$.topbutton = function(op){
	    var _op = {
	        html : "",               // 버튼에 들어갈 HTML 또는 텍스트
	        css : undefined,            // 추가적인 CSS 스타일
	        scrollSpeed : 150,          // 스크롤 속도 (밀리초)
	        scrollAndShow : false      // 스크롤 시에만 보이도록 할지 여부
	    }
	    for(key in op){ _op[key] = op[key]; }

	    var basicCSS = {
	            width : '40px',  // 버튼 너비
	            height : '40px',  // 버튼 높이
	            background : 'url(/images/btn_top.png) 0 0 no-repeat',  // 배경 이미지 설정
	            right : '20px',  // 오른쪽에서 20px 떨어진 위치에 고정
	            bottom: '60px',  // 하단에서 60px 떨어진 위치에 고정
	            border : '0',
	            zIndex: '1000',  // 다른 요소보다 앞에 오도록 설정
	            display: 'none',  // 스크롤 전에는 보이지 않음
	            position: 'fixed'  // 화면에 고정
	    };
	    if(_op.css != undefined){
	        var userCss  = {};
	        var arr = _op.css.split(";").filter(function(n){ return n != "" });
	        for(key in arr){
	            var index = arr[key].split(":");
	            var uKey = index[0].replace(/(\s*)/g,"");
	            var uValue = index[1].replace(/(\s*)/g,"");
	            userCss[uKey] = uValue;
	        }
	        for(key in userCss){ basicCSS[key] = userCss[key]; }
	    }
	    var attr = "";
	    for(key in basicCSS){ attr += key+':'+basicCSS[key]+'; '; }

	    var scrollAndShow ="";  // 스크롤에 따라 버튼을 표시할지 설정
	    if(_op.scrollAndShow){
	        scrollAndShow ="display:none;";
	        var px = 150;  // 스크롤이 100px 이상일 때만 보이도록 설정
	        var on = true;
	        $(window).scroll(function(){
	            if($(this).scrollTop() > px){ 
	                if(!on){$('#topButton').fadeIn(); on = true;}  // 스크롤이 100px을 넘으면 버튼 표시
	            }
	            else{
	                if(on){$('#topButton').fadeOut(); on = false;}  // 스크롤이 100px 이하면 버튼 숨김
	            }
	        });
	        if($(window).scrollTop() > px){ scrollAndShow = "display:block;"; }
	    }

	    // 버튼 HTML 추가
	    var html = '<button type="button" id="topButton" style="'+scrollAndShow+' '+attr+'">Top</button>';
	    $('body').append(html);

	    // 클릭 시 페이지 상단으로 스크롤
	    $('#topButton').click(function(){
	        $('html, body').animate({scrollTop : 0}, parseInt(_op.scrollSpeed));
	    });
	};
})(jQuery);

</script>

<script type="text/javascript">
	// Top 버튼을 설정
	$.topbutton({
	    scrollAndShow : true,    // 스크롤에 따라 버튼을 보이게 할지 설정
	    scrollSpeed : 200,       // 스크롤 속도 설정
	    html : "▲ Top",          // 버튼 텍스트 설정 (이미지 대신 텍스트 사용 가능)
	    css : "background-color: #3498db; color: white; border-radius: 5px; font-size: 14px;" // 추가 스타일 적용
	});
</script>
</head>
<body>

<div class="container">
<h2>${salNum} 추가수당 확인</h2>
<p>급여 지급일: ${salDate}</p>

<table class="table table-hover">
    <thead>
        <tr>
            <th>번호</th>
            <th>사원번호</th>
            <th>사원명</th>
            <th>부서</th>
            <th>직급</th>
            <th>초과시간</th>
            <th>추가근무수당</th>
        </tr>
    </thead>
    <tbody>
        <c:set var="num" value="1"></c:set>
        <c:forEach var="emp" items="${overtimeSalList}">
            <tr>
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
                <td>${emp.totalOvertime} 시간</td>
                <td><fmt:formatNumber value="${emp.overtimeSal}" type="currency" /></td>
            </tr>
            <c:set var="num" value="${num + 1}"></c:set>
            <input type="hidden" name="salNum" value="${salNum}" />
        </c:forEach>
    </tbody>
</table>
 <div style="text-align: center;">
<!-- 버튼 -->
    <button class="btn" onclick="btn(); window.open('/mh/updateOvertimeSal?salNum=${salNum}','width=500,height=500,resizable=no')"> 추가수당 확정 </button>
    <button class="btn" onclick="window.close()">닫기</button>
</div>
</div>
</body>
</html>
