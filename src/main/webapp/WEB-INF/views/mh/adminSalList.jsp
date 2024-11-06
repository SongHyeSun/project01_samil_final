<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../1.main/admin_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<meta charset="UTF-8">
<title>관리자 급여대장 페이지입니다</title>
<style type="text/css">
body {
        font-family: Arial, sans-serif;
        background-color: #f0f0f0; 
        margin: 0;
        padding: 20px;
    }
    main {
	    background-color: #fff;
		margin: 50px 150px;
	    border-radius: 8px;
	    padding-bottom: 50px;
	}
    h3 {
        color: #333;
        border-bottom: 2px solid #8C8C8C; 
        padding-bottom: 10px;
        margin-bottom: 20px;
        text-align: center; 
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

    input[type="text"], input[type="file"], input[type="number"] {
        width: 33%;
        padding: 8px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 16px;
    }

</style>
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
	        var px = 100;  // 스크롤이 100px 이상일 때만 보이도록 설정
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
<main>
	<h3>${salNum } 급여대장</h3>
	<table><thead>
  <tr>
    <th colspan="10">${salDate}
  </tr></thead>
<tbody>
  <tr>
    <th rowspan="2"></th>
    
    <th >사원번호</th>
    <th>성명</rh>
    <th>기본급</th>
    <th>상여</th>
    <th>야간근로</th>
    <th>식대</th>
    <th>지급합계</th>
    <th>지급총액</th>
    <th>지급일</th>
  </tr>
  <tr>
    <th>부서</th>
    <th>직책</th>
    <th>소득세</th>
    <th>-</th>
    <th>-</th>
    <th>-</th>
    <th>-</th>
    <th>공제총액</th>
    <th>-</th>
  </tr>
  <tr>
  <th colspan="10">
    		<form action="listSearchList">
			<select class ="sertchList" name="search">
				<option class ="sertchList" value="seartchEmpno">사원번호</option>
				<option class ="sertchList"  value="seartchName">사원명</option>
				<option class ="sertchList" value = "seartchDet">부서</option>
				<option class ="sertchList" value = "seartchsalnum">근로월</option>
			</select> 
			<input type="text" name="keyword" id="key">
			<button type="submit" class="btn btn-secondary" id="btn2">검색</button>
		</form>
  </tr>

 <c:forEach var="emp" items="${listEmp }">
    <tr>
    <td rowspan="2">  <form action="/mh/salJoin" method="POST" target="_blank">
                <input type="hidden" name="empno" value="${emp.empno}">
                <input type="hidden" name="salNum" value="${emp.salNum}">
                <button class="btn btn-secondary" id="btnEmp_${emp.empno}" type="submit" value="${emp.empno }">명세서 보기</button>
            </form>
    <td>${emp.empno }</td>
    <td>${emp.name}</td>
    <td><fmt:formatNumber value="${emp.salBase }" type="currency" /></td>
    <td><fmt:formatNumber value="${emp.salBonus }" type="currency" /></td>
    <td><fmt:formatNumber value="${emp.salNight }" type="currency" /></td>
    <td><fmt:formatNumber value="${emp.salFood }" type="currency" /></td>
    <td><fmt:formatNumber value="${emp.salTotal }" type="currency" /></td>
    <td><fmt:formatNumber value="${emp.salFinal }" type="currency" /></td>
    <td>${emp.salDate }</td>
  </tr>
  <tr>
    <td>${emp.deptName }</td>
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
    <td><fmt:formatNumber value="${emp.tax }" type="currency"/></td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td><fmt:formatNumber value="${emp.tax }" type="currency"/></td>
    <td>-</td>
    <td>-</td>

  </tr>
 </c:forEach>
  

</tbody>
</table>
</main>
</body>
</html>
