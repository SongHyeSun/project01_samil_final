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
<title>관리자 급여지급 페이지입니다</title>
</head>
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
    max-width: 600px; /* 중앙 정렬과 최대 폭 설정 */
    text-align: center; /* 텍스트 중앙 정렬 */
}

h3 {
    color: #333;
    border-bottom: 2px solid #8C8C8C;
    padding-bottom: 10px;
    margin-bottom: 20px;
}

table {
    width: 100%; /* 표를 컨테이너 전체에 맞춤 */
    border-collapse: collapse;
    margin-bottom: 20px;
    background-color: #fff; /* 표 배경색 */
    border-radius: 8px;
    overflow: hidden;
}

th, td {
    padding: 12px;
    border: 1px solid #ddd;
    text-align: center;
}

th {
    background-color: #6E6E6E; /* 헤더 배경색 */
    color: white;
}

input[type="text"], input[type="file"], input[type="number"] {
    width: 90%;
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 16px;
    background-color: #f9f9f9; /* 입력 필드 배경색 */
    text-align: right;
}
</style>
<body>
	<main>
	<h3>관리자 급여지급 페이지입니다</h3>
	<p>급여 지급일 : ${salDate}</p>

	<table>
		<thead>
			<tr><th>지급 항목명</th><th>금액 (${shemp.empno}, ${shemp.name})</th></tr>
		</thead>
		<tbody>
			<tr><th>기본급</th><td><input type="number" value="${shemp.salBase}" class="text" id="base"></td></tr>
			<tr><th>식대</th><td><input type="number" value="${shemp.salFood}" class="text" id="food"></td></tr>
			<tr><th>상여금</th><td><input type="number" value="${shemp.salBonus}" class="text" id="bonus"></td></tr>
			<tr><th>추가수당</th><td><input type="number" value="${shemp.salNight}" class="text" id="night"></td></tr>
			<tr style="background-color:#f0f0f0"><th>지급합계</th><td><input type="text" readonly="readonly" id="total" value="${shemp.salTotal}" class="text"></td></tr>
			<tr style="background-color:#f0f0f0"><th>소득세</th><td><input type="text" readonly="readonly" id="tax" value="${shemp.tax}" class="text"></td></tr>
			<tr style="background-color:#f0f0f0"><th>차인지급액</th><td><input type="text" readonly="readonly" id="salFinal" value="${shemp.salFinal}" class="text"></td></tr>
		</tbody>
	</table>

	<button id="btn1" class="btn btn-secondary" onclick="location.href='/mh/adminSalGive?currentPage=1'">취소</button>
	<button id="btn2"class="btn btn-secondary"  onclick="salDList(${empno})">저장</button>
</main>


<script type="text/javascript">
const num1 = document.getElementById('base');
const num2 = document.getElementById('food');
const num3 = document.getElementById('bonus');
const num4 = document.getElementById('night');
const total = document.getElementById('total');
const tax = document.getElementById('tax');
const salFinal = document.getElementById('salFinal');

function calculateSum() {
    // 각 급여 항목의 합계를 계산
    const sum = Number(num1.value) + Number(num2.value) + Number(num3.value) + Number(num4.value);
    total.value = sum;  // 합계를 업데이트

    // 세금 계산 (1%)
    const taxAmount = Number(total.value) * 0.1;
    tax.value = taxAmount.toFixed(0);  // 세금 값을 업데이트 (소수점 2자리까지)

    // 실수령액 계산 (합계에서 세금을 뺀 값)
    const finalSalary = Number(total.value) - Number(tax.value);
    salFinal.value = finalSalary.toFixed(0);  // 실수령액 업데이트 (소수점 2자리까지)
    
    // 디버깅용 콘솔 출력
    console.log("총 합계: ", sum);
    console.log("세금: ", taxAmount);
    console.log("실수령액: ", finalSalary);
}

// 각 입력 필드에서 값이 변경될 때마다 합계를 계산
num1.addEventListener('input', calculateSum);
num2.addEventListener('input', calculateSum);
num3.addEventListener('input', calculateSum);
num4.addEventListener('input', calculateSum);


function salDList(empno) {
    console.log("start");
    // 입력 필드 값 가져오기
   // var empno = '${shemp.empno}';
    var salBase = $('#base').val();
    var salFood = $('#food').val();
    var salBonus = $('#bonus').val();
    var salNight = $('#night').val();
    var saltotal = $('#total').val();
    var saltax = $('#tax').val();
    var salfinal = $('#salFinal').val();
    console.log(empno);
    
    $.ajax({

        url: '/mh/updateSal', 
        type: 'POST',
        data: {
            empno: empno,
            salBase: salBase,
            salFood: salFood,
            salBonus: salBonus,
            salNight: salNight,
            saltotal: saltotal,
            saltax: saltax,
            salfinal: salfinal,
        },
        success: function(response) {
            alert('급여 정보가 성공적으로 업데이트되었습니다.');
           
        },
        error: function(xhr, status, error) {
            console.error('오류 발생: ' + error);
            alert('급여 정보 업데이트 중 오류가 발생했습니다.');
        }
    });
}
</script>

</body>
</html>