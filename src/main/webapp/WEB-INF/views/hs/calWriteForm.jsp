<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../1.main/user_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CalWriteForm</title>
<!-- jquery (자동완성기능) -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

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
        max-width: 1000px; /* 최대 폭 설정 */
        margin-top: 50px;
    }
	
	h3 {
        color: #333;
        border-bottom: 2px solid #034EA2; /* 회색 밑줄 */
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
    }
    th {
        background-color: #034EA2; /* 회색 헤더 배경 */
        color: white;
        font-size: 16px;
        text-align: center;
    }
    
    input[type="text"], input[type="date"] {
        width: 90%;
        padding: 8px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 16px;
    }	

	.btn.selected {
		background-color: #FFBB00;
		color: black;
		border-color: #F29661;
	}
        
	.btn-address-book {
		cursor: pointer;
		padding: 5px 10px;
		margin: 2px;
		border: 1px solid #ddd;
		background-color: #e0e0e0;
		border-radius: 5px;
	}
	
	/* 주소록 버튼 클릭 시 색상 변화 추가 */
	.btn-address-book.selected {
	    background-color: #00D8FF; /* 클릭 시 배경색 변경 */
	    color: white; /* 클릭 시 글자색 변경 */
	    border: none; /* 테두리 제거 */
	}
	
	.scheduleTypeCell {
		position: relative;
		padding-left: 25px; /* 동그라미 기호 여백 */
	}
	.scheduleTypeCell::before {
		content: '';
		position: absolute;
		left: 0;
		top: 50%;
		transform: translateY(-50%);
		width: 15px;
		height: 15px;
		border-radius: 50%;
		background-color: #f0f0f0; /* 기본 색상 */
	}
	.scheduleTypeCell.personal::before {
		background-color: #ffad60; /* 연한 주황색 */
	}
	.scheduleTypeCell.shared::before {
		background-color: #87ceeb; /* 하늘색 */
	}
	/* 버튼 위치 조정 */
    .form-actions {
        margin-top: 20px;
        text-align: center; /* 버튼을 왼쪽으로 정렬 */
    }
    
    .selectbox {
    	border: 1px solid;
    	margin-top: 10px;
    	padding: 10px;
    	border-radius: 10px;
    	height: 100%;
    }
    
    button {
		margin-left: 10px;
		cursor: pointer; /* 마우스 커서 변경 */
		border: none;
		color: blue;
		background-color: white;
	}
        
        
</style>



</head>
<body>
<main>
	<form action="writeEvent" method="post" onsubmit="return validateDates() && validateTitleLength()">
	<div class="entirewrite">
		<h3>일정쓰기</h3>
		<input type="hidden" name="eventDelete" value=100>
		<input type="hidden" name="eventWriter" value="${emp.empno }">
		<input type="hidden" name="selMem" id="selMem" value="">
		<input type="hidden" name="empnoArr" id="empnoArr" value="">
		<input type="hidden" name="attendRes" value="100">
			<table>
			
				<tr>
					<th>제목</th>
					<td><input type="text" name="eventTitle" maxlength="30" required="required"></td>
				</tr>
				<tr>
					<th>일시</th>
					<td><input type="datetime-local" name="eventStartdate" id="eventStartdate" required="required" onchange="updateEndDate()">
						<input type="datetime-local" name="eventEnddate" id="eventEnddate" required="required"></td>
				</tr>
				<tr>
					<th>참석자</th>
					<td>
						<button type="button" class="btn btn-outline-warning btn-sm" data-type="personal" onclick="getEventCate(120)">개인</button>
						<!-- 주소록 모달버튼 -->
						<button type="button" class="btn btn-outline-info btn-sm" data-bs-toggle="modal" data-bs-target="#addressModal" onclick="getEventCate(110)">
							주소록
						</button>
						<div id="checkboxContainer" style="display: none;">
							<input type="checkbox" name="attendRsvp" value="100" id="flexCheckChecked" style="margin-left: 20px;">
							<label class="form-check-label" for="flexCheckChecked">수정 권한</label>
							<input type="hidden" name="attendRsvp" id="attendRsvpHidden" value="110">
						</div>
						<div class="selected-employees" style="margin-top: 10px;"></div> <!-- 선택된 직원 표시 영역 -->
                    </td>
				</tr>
				<tr>
					<th>분류</th>
					<td>
						<span id="eventCate"></span>
						<input type="hidden" id="eventCategory" name="eventCategory" value="">
					</td>
				</tr>
				<tr>
					<th>장소</th>
					<td><input type="text" name="eventLoc"></td>
				</tr>
				<tr>
					<th>메모</th>
					<td><input type="text" name="eventMemo"></td>
				</tr>
			</table>
			<div class="form-actions">
				<button type="submit" class="btn btn-outline-primary">등록</button>
			</div>
		</div>
	</form>

	
	<!-- 주소록 모달 -->
	<div class="modal fade" id="addressModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">공유일정 참석자 추가</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="container-fluid">
						<div class="row">
							
							<!-- 직원 검색 및 조직도 -->
							<div class="col-sm-7">
								<!-- 아코디언 분류 -->
								<div class="accordion accordion-flush" id="accordionFlushExample">
									<c:forEach var="dept" items="${deptList44}">
										<div class="accordion-item">
											<h2 class="accordion-header">
												<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse-${dept.deptno}" aria-expanded="false" aria-controls="flush-collapse-${dept.deptno}">
													${dept.deptName}
												</button>
											</h2>
											<div id="flush-collapse-${dept.deptno}" class="accordion-collapse collapse" data-bs-parent="#accordionFlushExample">
												<c:forEach var="emp" items="${deptEmpMap[dept.deptno]}">
													<div class="accordion-body" onclick="addEmployee({ name: '${emp.name}', empno: '${emp.empno}' })">
														<button type="button" class="list-group-item list-group-item-action">${emp.empno} ${emp.name} ${empgrade[emp.grade]}</button>
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
								<div class="selectbox" style="text-align: left;">
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-outline-secondary btn-sm" data-bs-dismiss="modal">닫기</button>
					<button type="submit" class="btn btn-outline-warning btn-sm" onclick="addEmployeesAndCloseModal()">추가</button>
				</div>
			</div>
		</div>
	</div>
</main>
<script type="text/javascript">

	// 개인/주소록 버튼을 눌러서 아작스로 개인일정, 공유일정 변경하기
	function getEventCate(eventCate) {
		console.log(eventCate);
		$('#eventCategory').val(eventCate); // eventCategory의 값을 업데이트
		$.ajax(
				{
					url:"<%=request.getContextPath()%>/hs/getEventCate",
					data:{eventCategory : eventCate},
					dataType:'text',
					success:function(eventCat) {
						console.log(eventCat);
						$('#eventCate').html(eventCat);
						if (eventCat.includes("개인일정")) {
							selectPersonal();	//개인일정 선택
							$('#eventCate').css('color','#FFBB00');
							console.log("색상 변경 : 개인일정");
							
						} else if (eventCat.includes("공유일정")) {
							selectAddressBook();	//주소록 선택
							$('#eventCate').css('color','#00D8FF');
							console.log("색상 변경 : 공유일정");
						}
					}
			});
	}
	
	// 개인/주소록 선택 시 체크박스 표시 조정
	function selectPersonal() {
	    hideCheckbox(); // 개인 일정 선택 시 체크박스 숨김
	}

	function selectAddressBook() {
	    showCheckbox(); // 주소록 선택 시 체크박스 보이기
	}
	
	function showCheckbox() {
	    const checkboxContainer = document.getElementById('checkboxContainer');
	    checkboxContainer.style.display = 'block'; // 체크박스 보이기
	    updateAttendRsvpHidden(); // 체크박스 기본값 설정
	}
	
	function hideCheckbox() {
	    const checkboxContainer = document.getElementById('checkboxContainer');
	    checkboxContainer.style.display = 'none'; // 체크박스 숨기기

	    // 수정 권한 값을 110으로 설정
	    const hiddenInput = document.getElementById('attendRsvpHidden');
	    hiddenInput.value = '110';
	}

	
	
	//버튼 클릭 이벤트
	$(document).ready(function() {
		
		// 초기 체크박스 상태 설정
	    const eventCategoryValue = $('#eventCategory').val();
	    getEventCate(eventCategoryValue); // 페이지 로드 시 카테고리에 따라 초기 상태 설정
		
		//개인 버튼 클릭 이벤트
		$('button[data-type="personal"]').on('click', function() {
			//모든 버튼에서 active 클래스 제거
			$('button[data-type]').removeClass('active');
			//클릭된 버튼에 active 클래스 추가
			$(this).addClass('active');
			//개인 일정 요청
			getEventCate(120);
		});
		
		// 주소록 버튼 클릭 이벤트
	    $('button[data-bs-toggle="modal"]').on('click', function() {
	        // 모든 버튼에서 active 클래스 제거
	        $('button[data-type]').removeClass('active');
	        // 클릭된 버튼에 active 클래스 추가
	        // 이 경우, 주소록 버튼에는 active 클래스를 추가하지 않을 수 있음
	        // 하지만 필요한 경우 추가할 수 있음
	        selectButton(this); // 추가
	        getEventCate(110);
	    });
		
	  //수정권한 체크박스가 체크되면, 자동으로 value 바뀌게 하기
		$('#flexCheckChecked').change(function() {
	    	const hiddenInput = $('#attendRsvpHidden');
	        hiddenInput.val($(this).is(':checked') ? '100' : '110');
	    });
	  	console.log("attendRsvp:", hiddenInput.val());
	  
	});
	
	
	//주소록 버튼 클릭 시 선택 상태 변경 및 개인 일정으로 전환 가능하게 수정
	function selectAddressBookButton() {
		selectButton(document.querySelector('.btn[data-type="personal"]')); // 개인 일정으로 선택
		const addressBookButton = document.querySelector('.btn[data-bs-toggle="modal"]');
		addressBookButton.classList.add('selected', 'address-book'); // 클릭된 상태로 변경
	}
	
	function selectButton(button) {
	    const classificationDisplay = document.getElementById('classificationDisplay');
	    const eventCategoryInput = document.getElementById('eventCategory');

	    if (button.dataset.type === 'personal') {
	        classificationDisplay.textContent = '개인일정'; // 화면에 표시할 텍스트
	        eventCategoryInput.value = '120'; // 서버에 전달할 값
	    } else if (button.dataset.type === 'addressBook') {
	        classificationDisplay.textContent = '공유일정'; // 화면에 표시할 텍스트
	        eventCategoryInput.value = '110'; // 서버에 전달할 값
	    }
	}
	
	
	// 선택된 직원 목록
	let selAtten = [];
	let empnoArr = [];
	
	// 직원 추가 함수
	function addEmployee(emp) {
    // emp.empno가 selAtten에 포함되어 있는지 확인
	    if (!empnoArr.includes(emp.empno)) {
	        selAtten.push(emp);
	        empnoArr.push(emp.empno);
	        renderSelAtten();
	        
	        console.log("선택된 직원 목록: ", empnoArr);
	        
	        // 주소록 버튼을 클릭된 것처럼 상태 변경
	        selectAddressBookButton();
	    } else {
	        alert(emp.name + "은(는)이미 선택되었습니다."); // 중복 선택 시 경고
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
			removeBtn.textContent = 'X';
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
	
	// 시작날짜보다 종료날짜가 더 이르게 할 수 없도록
	function validateDates() {
        const startDate = document.getElementById('eventStartdate').value;
        const endDate = document.getElementById('eventEnddate').value;

        if (startDate && endDate) {
            if (new Date(startDate) > new Date(endDate)) {
                alert("종료일은 시작일 이후의 날짜여야 합니다.");
                return false; // 폼 제출을 중단
            }
        }
        return true; // 유효성 검사 통과
    }
	
	// 글자수가 넘기면 alert
	function validateTitleLength() {
	    const titleInput = document.querySelector('input[name="eventTitle"]');
	    const maxLength = 30; // 최대 글자 수 설정
	
	    // 한글 처리: 한글은 2바이트이므로 계산 시 2바이트인 경우 반영
	    const byteLength = Array.from(titleInput.value).reduce((acc, char) => {
	        return acc + (char.charCodeAt(0) > 127 ? 2 : 1);
	    }, 0);
	
	    if (byteLength > maxLength) {
	        alert(`제목 글자수를 초과하였습니다.`);
	        return false; // 폼 제출을 중단
	    }
    	return true; // 유효성 검사 통과
	}
	
	
	// 시작시간 설정되면 자동으로 1시간 뒤로 end날짜 설정해주기
	 function updateEndDate() {
	        const startDateTimeInput = document.getElementById('eventStartdate');
	        const endDateTimeInput = document.getElementById('eventEnddate');

	        // 시작 날짜가 입력된 경우
	        if (startDateTimeInput.value) {
	            // 시작 날짜를 Date 객체로 변환
	            const startDateTime = new Date(startDateTimeInput.value);

	            // 종료 날짜를 한 시간 뒤로 설정
	            startDateTime.setHours(startDateTime.getHours() + 10);

	            // 종료 날짜를 YYYY-MM-DDTHH:mm으로 포맷
	            const endDateTime = startDateTime.toISOString().slice(0, 16);

	            // 종료 날짜 입력에 설정
	            endDateTimeInput.value = endDateTime;
	        } else {
	            // 시작 날짜가 비어있으면 종료 날짜도 비워줌
	            endDateTimeInput.value = '';
	        }
	    }
</script>
</body>
</html>