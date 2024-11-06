<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../1.main/user_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메일보냄</title>
<style type="text/css">
main {
	padding: 30px 10%;
	background-color: #fff;
	margin: 20px auto;
	margin-top: 50px;
	border-radius: 8px;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
}
h3 {
        color: #333;
        border-bottom: 2px solid #034EA2; /* 회색 밑줄 */
        padding-bottom: 10px;
        margin-bottom: 20px;
        text-align: center; /* 제목 중앙 정렬 */
    }

th, td {
	padding: 12px;
	border: 2px solid #ddd;
	text-align: left;
}

th {
	background-color: #8C8C8C; /* 회색 헤더 배경 */
	color: white;
	font-size: 16px;
}

input[type="text"], textarea {
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
button {
        margin-left: 10px;
        cursor: pointer; /* 마우스 커서 변경 */
        border: none;
        color: blue;
        background-color: white;
    }
</style>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
//버튼 클릭 이벤트
$(document).ready(function() {
	//개인 버튼 클릭 이벤트
	$('button[data-type="personal"]').on('click', function() {
		//모든 버튼에서 active 클래스 제거
		$('button[data-type]').removeClass('active');
		//클릭된 버튼에 active 클래스 추가
		$(this).addClass('active');
	});
	
	// 주소록 버튼 클릭 이벤트
    $('button[data-bs-toggle="modal"]').on('click', function() {
        // 모든 버튼에서 active 클래스 제거
        $('button[data-type]').removeClass('active');
        // 클릭된 버튼에 active 클래스 추가
        // 이 경우, 주소록 버튼에는 active 클래스를 추가하지 않을 수 있음
        // 하지만 필요한 경우 추가할 수 있음
        selectButton(this); // 추가
    });
  
});


// 선택된 직원 목록
let selAtten = [];
let empnoArr = [];

// 직원 추가 함수
function addEmployee(emp) {
	if (!selAtten.includes(emp)) {
		selAtten.push(emp);
		empnoArr.push(emp.empno);
		renderSelAtten();
		
		console.log("선택된 직원 목록: ",empnoArr);
		
		// 주소록 버튼을 클릭된 것처럼 상태 변경
		selectAddressBookButton();
	} else {
		alert(emp.name +"은(는)이미 선택되었습니다.");	//중복 선택 시 경고
	}
}

// 직원 선택 시 스타일 추가
function toggleEmployeeSelection(button) {
	button.classList.toggle('selected');
} 

// 직원 삭제 함수
function removeEmployee(emp) {
	selAtten = selAtten.filter(e => e.empno !== emp.empno);
	empnoArr = empnoArr.filter(empno => empno !== emp.empno); // empnoArr에서 해당 직원의 empno 제거
	renderSelAtten();
}

// 선택된 직원 렌더링
function renderSelAtten() {
	const selectedContainer = document.querySelector('.selected-employees'); // 기존 직원 표시 영역
	const modalSelectedContainer = document.querySelector('.selectbox'); // 모달 내 선택된 직원 영역
	const selectedEmployeesInput = document.getElementById('selMem'); // hidden input
	const selectedEmpnoArrInput = document.getElementById('empnoArr'); // hidden input selEmpno

	// 두 곳 모두 업데이트
	selectedContainer.innerHTML = '';
	modalSelectedContainer.innerHTML = '';
	selectedEmployeesInput.value = JSON.stringify(selAtten); // hidden input 업데이트
	selectedEmpnoArrInput.value = empnoArr;

	if (selAtten.length === 0) {
		selectedEmployeesInput.value = ""; // 빈 문자열로 설정
        selectedEmpnoArrInput.value = ""; // 빈 문자열로 설정
		return; // 배열이 비어있으면 함수 종료
	}

	// 기본 창에서는 한 줄로 표시
	selAtten.forEach(emp => {
		const empDiv = document.createElement('div');
		empDiv.textContent = emp.name + ' (' + emp.empno + ') ';
		empDiv.style.display = 'inline-block'; // 한 줄에 표시
		empDiv.style.marginRight = '10px'; // 간격 조정

		const removeBtn = document.createElement('button');
		removeBtn.textContent = 'x';
		removeBtn.onclick = () => {
			removeEmployee(emp);
			renderSelAtten(); // 직원 제거 후 재렌더링
		};

		empDiv.appendChild(removeBtn);
		selectedContainer.appendChild(empDiv); // 기본 직원 표시 영역에 추가
	});

	// 모달 창에서는 한 줄씩 표시
	selAtten.forEach(emp => {
		const li = document.createElement('li'); // li로 변경
		li.textContent = emp.name + ' (' + emp.empno + ') ';

		const removeBtn = document.createElement('button');
		removeBtn.textContent = 'x';
		removeBtn.onclick = () => {
			removeEmployee(emp);
			renderSelAtten(); // 직원 제거 후 재렌더링
		};

		li.appendChild(removeBtn);
		modalSelectedContainer.appendChild(li); // 모달 내 선택된 직원 표시 영역에 추가
	});
	
	//숨겨진 입력 필드 업데이트
	document.getElementById('selMem').value = JSON.stringify(selAtten);	// JSON 형태로 변환하여 저장
}

// 모달에서 선택된 직원 추가 및 닫기
function addEmployeesAndCloseModal() {
	const selectedButtons = document.querySelectorAll('.accordion-body.selected');

	selectedButtons.forEach(button => {
		const empData = JSON.parse(button.getAttribute('data-emp'));
		addEmployee(empData);
	});

	// 선택된 직원 목록 렌더링
	renderSelAtten();

	// 모달 닫기
	const modal = bootstrap.Modal.getInstance(document.getElementById('addressModal'));
	modal.hide();
}
</script>
</head>
<body>
<main>
	<form action="sendMailTo" method="post">
		<input type="hidden" id="selMem" name="selMem" value=""> <input
			type="hidden" id="empnoArr" name="empnoArr" value=""> <input
			type="text" name="Myempno" value="${emp.empno}" hidden="hidden">
		<!-- 선택된 직원 표시 영역 -->
		<p>
		<h3>메일작성</h3>
		<table>
			<tr>
				<td>받는 사람&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="button" class="btn btn-outline-info btn-sm"
						data-bs-toggle="modal" data-bs-target="#addressModal">
						주소록</button>
				</td>
				<td>
					<div class="selected-employees" style="margin-top: 10px;"></div>
				</td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" name="title"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea name="content" cols="50" rows="10"></textarea></td>
			</tr>
		</table>
		<div style="text-align: center; margin-top: 20px;">
			<input type="submit" value="작성">
		</div>
	</form>

	<!-- 주소록 모달 -->
	<div class="modal fade" id="addressModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div
			class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">받는 사람 추가</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="container-fluid">
						<div class="row">

							<!-- 직원 검색 및 조직도 -->
							<div class="col-sm-7">
								<!-- 아코디언 분류 -->
								<div class="accordion accordion-flush"
									id="accordionFlushExample">
									<c:forEach var="dept" items="${deptList}">
										<div class="accordion-item">
											<h2 class="accordion-header">
												<button class="accordion-button collapsed" type="button"
													data-bs-toggle="collapse"
													data-bs-target="#flush-collapse-${dept.deptno}"
													aria-expanded="false"
													aria-controls="flush-collapse-${dept.deptno}">
													${dept.deptName}</button>
											</h2>
											<div id="flush-collapse-${dept.deptno}"
												class="accordion-collapse collapse"
												data-bs-parent="#accordionFlushExample">
												<c:forEach var="emp" items="${deptEmpMap[dept.deptno]}">
													<div class="accordion-body"
														onclick="addEmployee({ name: '${emp.name}', empno: '${emp.empno}' })">
														<button type="button"
															class="list-group-item list-group-item-action">${emp.empno}
															${emp.name} ${empgrade[emp.grade]}</button>
													</div>
												</c:forEach>
											</div>
										</div>
									</c:forEach>
								</div>
							</div>

							<!-- 선택된 사원 목록 -->
							<div class="col-md-4 ms-auto" style="text-align: center;">
								<span style="font-weight: bold; color: blue;">선택된 사원</span>
								<div class="selectbox" style="text-align: left;"></div>
							</div>
						</div>
					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-outline-secondary btn-sm"
						data-bs-dismiss="modal">닫기</button>
					<button type="submit" class="btn btn-outline-warning btn-sm"
						onclick="addEmployeesAndCloseModal()">추가</button>
				</div>
			</div>
		</div>
	</div>
</main>
</body>
</html>
