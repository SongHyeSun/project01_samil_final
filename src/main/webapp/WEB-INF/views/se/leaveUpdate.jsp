<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../1.main/user_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>

    #content {
		margin-left: 650px;
		padding: 20px;
		margin-top: 50px;
	}
	
	@media print {
	 	@page {
            size: A4; /* 페이지 크기 설정 (A4) */
            margin: 0; /* 여백 제거 */
        }
        
	    body * {
	        display: none; /* 모든 요소 숨김 */
	        transform: scale(0.9);
	        height: auto;
	    }
	    #printableArea, #printableArea * {
	        display: block; /* 인쇄할 영역 보이기 */
	    }
	}
	
	.draft {
		width: 350px;
        border-collapse: collapse;
        margin-bottom: 10px;
        overflow: hidden;
	}
	
	table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 10px;
        overflow: hidden;
    }
    th {
   		width: 200px;
        padding: 5px;
        border: 1px solid #ddd;
        text-align: left;  
        color: black;          
        background-color: #FFF; 
        color: black;
        font-size: 16px;  
    }
    
    td {
    	width: 60%;
        padding: 5px;
        border: 1px solid #ddd;
        text-align: left;  
        color: black; 
    }
    
    button {
    	border: none;
    	color: red;
    }
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">


let selectedApprovers = [];
let selectedReferrers = [];
let modalType = 'approver'; // 기본값: 결재자

// 모달 열기
function openApproverModal() {
	
	$('#myForm').off('submit');
    
    $.ajax({
        url: '<%=request.getContextPath()%>/se/empDeptApp',
        method: 'GET',
        dataType: 'json',
        contentType: 'application/json',
        success: function(data) {
           populateEmpList(data);
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.error('직원 데이터 가져오기 오류:', textStatus, errorThrown);
        }
    });
}

// 모달 닫기 함수
function closeModal() {
    // 모달 닫기
    $('#addressModal').modal('hide');
	
    // 유효성 검사 다시 활성화
    $('#myForm').on('submit', function(event) {
        // 유효성 검사 로직
        if (!validateForm()) {
            event.preventDefault(); // 폼 제출 방지
        }
    });
}

// 입력 필드 유효성 검사 함수
function validateForm() {
    // 예: 필수 입력 필드 검사
    const isValid = $('#usagePeriod').val() && $('#furloughStartDate').val() && $('#furloughEndDate').val();
    if (!isValid) {
        alert('모든 필드를 입력해주세요.');
    }
    return isValid;
}

// 직원 목록 채우기
function populateEmpList(empList) {
    const empListContainer = $('.accordion');
    empListContainer.empty(); // 이전 결과 초기화

    if (empList.length === 0) {
        empListContainer.append('<div>직원이 없습니다.</div>');
        return;
    }

    const deptList = empList.reduce((acc, employee) => {
        const deptName = employee.deptName;
        if (deptName) {
            if (!acc[deptName]) {
                acc[deptName] = [];
            }
            acc[deptName].push(employee);
        } else {
            console.error('부서명이 없습니다:', employee);
        }
        return acc;
    }, {});

    Object.keys(deptList).forEach(deptName => {
        let departmentItem = `
            <div class="accordion-item">
                <h2 class="accordion-header">
                    <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapse` + deptName + `" aria-expanded="false" aria-controls="collapse` + deptName + `">
                        ` + deptName + `
                    </button>
                </h2>
                <div id="collapse` + deptName + `" class="accordion-collapse collapse" data-bs-parent="#accordionFlushExample">
                    <div class="accordion-body">
        `;

        const sortedEmployees = deptList[deptName].sort((a, b) => b.grade - a.grade);
        
        sortedEmployees.forEach(employee => {
            let gradeLabel = getGradeLabel(employee.grade);
            let jobLabel = getJobLabel(employee.job);
            if (gradeLabel || jobLabel) {
                departmentItem += `
                	<div style="cursor: pointer;">
                    <button type="button" class="btn btn-link" onclick="addToList('` + employee.name + `', '` + employee.empno + `', '` + gradeLabel + `', '` + jobLabel + `')" style="text-decoration: none;">
                        <strong>` + employee.empno + `</strong> ` + employee.name + ` ` + gradeLabel + ` ` + jobLabel + `
                    </button>
                </div>
                `;
            }
        });

        departmentItem += `
                    </div>
                </div>
            </div>
        `;

        empListContainer.append(departmentItem);
    });
}

// 직급과 직무 라벨 변환
function getGradeLabel(grade) {
    switch (grade) {
        case 100: return '사원';
        case 110: return '주임';
        case 120: return '대리';
        case 130: return '과장';
        case 140: return '차장';
        case 150: return '부장';
        case 160: return '사장';
        default: return '';
    }
}

function getJobLabel(job) {
    switch (job) {
        case 110: return '팀장';
        case 120: return '대표';
        default: return '';
    }
}

let approverIdCounter = 110; // 결재자 ID 시작값
let referrerIdCounter = 900;  // 참조자 ID 시작값

// 직원 추가 함수
function addToList(name, empno, gradeLabel, jobLabel) {
    const newEntry = { name, empno, grade: gradeLabel, job: jobLabel };

    if (modalType === 'approver') {
        if (!selectedApprovers.some(item => item.empno === newEntry.empno)) {
            if (selectedApprovers.length < 3) {
                selectedApprovers.push(newEntry);
                updateSelectedList('#selectedApprovers', selectedApprovers);
                updateHiddenApproversInput();
            } else {
                console.warn('결재자는 최대 3명까지 선택할 수 있습니다.');
            }
        } else {
            console.warn(name + '는 이미 선택되었습니다.');
        }

    } else {
        if (!selectedReferrers.some(item => item.empno === empno) && !selectedApprovers.some(item => item.empno === empno)) {
            selectedReferrers.push(newEntry);
            updateSelectedList('#selectedReferrers', selectedReferrers);
            updateHiddenReferrersInput();
        } else {
            console.warn(name + '는 이미 선택되었습니다.');
        }
    }
}

function updateSelectedApproval() {
    const approverNames = selectedApprovers.map(approver => 
        approver.name + ' ' + approver.grade
    ).join(' ');
    $('#selectedApproval').text(approverNames); // 결재자 이름 업데이트
    $('#approvalList').text(approverNames);
}

// 선택 목록 업데이트
function updateSelectedList(selector, list) {
    const container = $(selector);
    container.empty();

    const title = selector === '#selectedApprovers' ? '결재자 목록' : '참조자 목록';
    container.append('<h5>' + title + '</h5>');
    
    list.forEach(item => {
        container.append(`
            <div>
                ` + item.empno + ` ` + item.name + ` ` + item.grade + ` ` + item.job + `
                <button onclick="removeFromList('` + item.empno + `', '` + (selector === '#selectedApprovers' ? 'approver' : 'referrer') + `')">X</button>
            </div>
        `);
    });
}

// 목록에서 제거
function removeFromList(empno, type) {
    if (type === 'approver') {
        selectedApprovers = selectedApprovers.filter(item => item.empno !== empno);
        updateSelectedList('#selectedApprovers', selectedApprovers);
        updateHiddenApproversInput();
    } else {
        selectedReferrers = selectedReferrers.filter(item => item.empno !== empno);
        updateSelectedList('#selectedReferrers', selectedReferrers);
        updateHiddenReferrersInput();
    }
}

// 결재자 목록 업데이트 함수
function updateHiddenApproversInput() {
	const approversData = selectedApprovers.map(approver => approver.empno);
    $('#selectedApproversInput').val(approversData.join(',')); // 배열을 문자열로 변환하여 설정
}

// 참조자 목록 업데이트 함수
function updateHiddenReferrersInput() {
    const referrersData = selectedReferrers.map(referrer => referrer.empno);
    $('#selectedReferrersInput').val(referrersData.join(',')); // 배열을 문자열로 변환하여 설정
}

// 모달 유형 설정
function setModalType(type) {
    modalType = type;
    openApproverModal(); // 모달 열기

    // 모달 이벤트 리스너 등록
    $('#addressModal').off('hidden.bs.modal').on('hidden.bs.modal', function () {
        console.log('모달이 완전히 닫혔습니다.');
        // 스크롤 활성화 코드
        $('body').removeClass('modal-open'); // modal-open 클래스 제거
        $('body').css('overflow', 'auto'); // 스크롤 활성화
        $('.modal-backdrop').remove(); // 배경 제거
        console.log('모달 배경이 제거되었습니다.');
    });
}

function addApprovers() {
    const approverNames = selectedApprovers.map(approver => 
        approver.name + ' ' + approver.grade
    ).join(' ');
    $('#selectedApproval').text(approverNames); // 결재자 업데이트
    $('#approvalList').text(approverNames);
}

function addReferrers() {
    const referrerNames = selectedReferrers.map(referrer => 
        referrer.name + ' ' + referrer.grade
    ).join(', ');
    $('#selectedReference').text(referrerNames); // 참조자 업데이트
}

//모달 닫기 함수
function closeModal() {
    $('#addressModal').modal('hide');
}

// 추가 버튼 클릭 시
function addSelectedMembers() {
    addApprovers();
    addReferrers();

    // approversData와 referrersData를 생성
    const approversData = selectedApprovers.map((approver, index) => ({
        approverOrder: 110 + index * 10,
        empno: approver.empno
    }));

    const referrersData = selectedReferrers.map((referrer, index) => ({
        approverOrder: 900 + index,
        empno: referrer.empno
    }));

 	// 기존에 선언된 변수가 있다면 재사용
    const updatedApproversData = selectedApprovers.map((approver) => ({
        empno: approver.empno
    }));

    $('#addressModal').modal('hide'); 
    console.log('모달이 닫혔습니다.');
}

// 모달이 완전히 닫힐 때 호출되는 이벤트 리스너
$('#addressModal').on('hidden.bs.modal', function () {
    console.log('모달이 완전히 닫혔습니다.');
    // 스크롤 활성화 코드
    $('body').removeClass('modal-open'); // modal-open 클래스 제거
    $('body').css('overflow', 'auto'); // 스크롤 활성화
    $('.modal-backdrop').remove(); // 배경 제거
    console.log('모달 배경이 제거되었습니다.');
});

// 이 부분을 추가하여 모달을 열기 전에 항상 이벤트 리스너를 등록
$('#addressModal').on('show.bs.modal', function () {
    // 모달이 열리면 스크롤 비활성화
    $('body').addClass('modal-open');
    $('body').css('overflow', 'hidden');
    console.log('모달이 열렸습니다. 스크롤 비활성화.');
});

let currentRow = 1; // 현재 보이는 행의 인덱스

function addRow() {
    const maxRows = 5; // 최대 보이는 행 수
    if (currentRow < maxRows) {
        const nextRow = document.getElementById(`row${currentRow + 1}`);
        nextRow.style.display = ''; // 행을 보이도록 설정
        currentRow++; // 현재 행 인덱스 증가
    }
}


function addFileNames(divId, files) {
    const fileNamesDiv = document.getElementById(divId);
    fileNamesDiv.innerHTML = ""; // 기존 파일 이름 지우기

    for (const file of files) {
        const fileNameElement = document.createElement('div');
        fileNameElement.textContent = file.name;
        fileNamesDiv.appendChild(fileNameElement);
    }
}

function goBack() {
    window.history.go(-2);
}

function resetForm() {
    document.getElementById("myForm").reset();

    // 사용 기간 및 사용일 초기화
    const usagePeriodElement = document.getElementById('usagePeriod');
    if (usagePeriodElement) {
        usagePeriodElement.innerText = "";
    }

    const usageDaysElement = document.getElementById('usageDays');
    if (usageDaysElement) {
        usageDaysElement.innerText = "";
    }

    // 파일 이름 초기화
    document.getElementById('fileNames').innerHTML = "";
    document.getElementById('imageAttachment').innerHTML = "";

    const tableBody = document.getElementById('tableBody');

    // 테이블 본체가 존재할 경우 기존 행 모두 삭제
    if (tableBody) {
        while (tableBody.firstChild) {
            tableBody.removeChild(tableBody.firstChild);
        }
    }

    // 결재자 및 참조자 목록 초기화
    selectedApprovers = [];
    selectedReferrers = [];
    updateSelectedList('#selectedApprovers', selectedApprovers);
    updateSelectedList('#selectedReferrers', selectedReferrers);

    // 결재자 및 참조자 ID 필드 초기화
    $('#selectedApproval').val('');
    $('#selectedReference').val('');
    
    // 모달에서 선택된 결재자 및 참조자 초기화
    $('#addressModal').find('.selected-approvers, .selected-referrers').empty();
}

function updateDay() {
    const startDateInput = document.getElementById('furloughStartDate');
    const endDateInput = document.getElementById('furloughEndDate');
    
    const startDateString = startDateInput.value;
    const endDateString = endDateInput.value;

    // hidden input에 startDate 및 endDate 설정
    document.querySelector('input[name="furloughStartDate"]').value = startDateString;
    document.querySelector('input[name="furloughEndDate"]').value = endDateString;

    if (startDateString && endDateString) {
        const startDate = new Date(startDateString);
        const endDate = new Date(endDateString);
        
        if (startDate > endDate) {
            alert('시작일은 종료일보다 이전이어야 합니다.');
            // 날짜 입력 초기화
            startDateInput.value = '';
            endDateInput.value = '';
            document.getElementById('usagePeriod').value = 0; // 초기화
            return;
        }

        const furloughServiceData = endDate - startDate;

        // 사용 일수가 0보다 작지 않도록 설정
        const daysUsed = Math.max(0, Math.floor(furloughServiceData / (1000 * 3600 * 24)) + 1);
        
        // 결과값을 number input 필드에 설정
        document.getElementById('usagePeriod').value = daysUsed;
    } else {
        document.getElementById('usagePeriod').value = 0; // 초기화
    }
}
function addFileNames(files) {
    const fileList = document.getElementById('imageAttachment');
    fileList.innerHTML = ''; // 기존 파일 목록 초기화
    for (const file of files) {
        const fileItem = document.createElement('div');
        fileItem.textContent = file.name;
        fileList.appendChild(fileItem);
    }
}
//삭제
function deleteApproval(documentFormId, approvalNum) {
    if (confirm("정말 삭제하시겠습니까?")) {
        const formData = new FormData();
        formData.append('documentFormId', documentFormId);
        formData.append('approvalNum', approvalNum);

        fetch('/se/deleteApp', { // 수정된 URL
            method: 'POST',
            body: formData
        })
        .then(response => {
            if (response.ok) {
                alert("삭제가 완료되었습니다.");
                window.location.href = "/se/appAll";
            } else {
                alert("삭제에 실패했습니다.");
            }
        })
        .catch(error => {
            console.error("Error:", error);
            alert("서버 오류가 발생했습니다.");
        });
    }
}
</script>
<title>${approvalDto.documentFormTitle} 수정</title>
</head>
<body>
<main id="printableArea">
    <div id="content" style="border: 1px solid #BDBDBD; width: 730px; margin-top: 30px; box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.5);">
    <form id="updateApp" method="post" action="insertApp" enctype="multipart/form-data" style="padding: 20px;">
        <input type="hidden" name="approvalNum"     value="${approvalDto.approvalNum}">
        <input type="hidden" name="documentFormId"  value="${approvalDto.documentFormId}">
        <input type="hidden" name="empno"           value="${emp.empno}">
	    <input type="hidden" id="selectedApproversInput" name="selectedApprovers" value="">
		<input type="hidden" id="selectedReferrersInput" name="selectedReferrers" value="">
	    
	    <div style="border-bottom: 1px solid #BDBDBD;">	
			<h2>${approvalDto.documentFormTitle} 수정 기안</h2>
			<p>
		</div>
		<p>
			
	    <div style="display: flex; border-bottom: 1px solid #BDBDBD;">
	    	<div style="padding-top: 10px;"> 
	    		<table class="appEmp">
					<tr>
		                <td style="width: 150px;">문서번호:</td>
		                <td><span id="approvalNum">${approvalDto.approvalNum}</span></td> <!-- Integer approvalNum -->
		            </tr>
					<tr>    
		                <td style="width: 150px;">기안일자</td>
		                <td id="approvalDate"><%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %></td>
		            </tr>
					<tr>	
						<td style="width: 150px;">기안자</td>
						<td><span id="name">${approvalDto.name}</span><br></td>
					</tr>
					<tr>	
						<td style="width: 150px;">기안자부서</td>
						<td><span id="deptName">${approvalDto.deptName}</span><br></td>
					</tr>
					<tr>	
						<td style="width: 150px;">기안자직급</td>
						<td>
							<c:choose>
		                        <c:when test="${approvalDto.grade == 100}">사원</c:when>
		                        <c:when test="${approvalDto.grade == 110}">주임</c:when>
		                        <c:when test="${approvalDto.grade == 120}">대리</c:when>
		                        <c:when test="${approvalDto.grade == 130}">과장</c:when>
		                        <c:when test="${approvalDto.grade == 140}">차장</c:when>
		                        <c:when test="${approvalDto.grade == 150}">부장</c:when>
		                        <c:when test="${approvalDto.grade == 160}">사장</c:when>
		                    </c:choose>
						</td>
					</tr>
				</table>
			</div>
			 
	    	<div style="margin-left: 50px;">
			<table style="border-collapse: collapse;">
		        <tr>
		        <td style="text-align: center; vertical-align: middle; padding-top: 10px; padding-left: 0px; padding-right: 0px; width: 20px; height: 170px; 
		                   writing-mode: vertical-rl; letter-spacing: 25px; border: 1px solid #BDBDBD;" rowspan="3">결재</td>
		            <c:forEach var="appLine" items="${appLineList}" varStatus="status">
		                <c:if test="${appLine.approverOrder <= 130}">
		                    <td style="text-align: center; vertical-align: middle; border: 1px solid #BDBDBD;">
		                        ${appLine.name}<br/>
		                        <c:choose>
		                            <c:when test="${appLine.grade == 100}">사원</c:when>
		                            <c:when test="${appLine.grade == 110}">주임</c:when>
		                            <c:when test="${appLine.grade == 120}">대리</c:when>
		                            <c:when test="${appLine.grade == 130}">과장</c:when>
		                            <c:when test="${appLine.grade == 140}">차장</c:when>
		                            <c:when test="${appLine.grade == 150}">부장</c:when>
		                            <c:when test="${appLine.grade == 160}">사장</c:when>
		                            <c:otherwise>( ${appLine.grade} )</c:otherwise>
		                        </c:choose>
		                    </td>
		                </c:if>
		            </c:forEach>
		        </tr>
		
		        <tr>
		            <c:forEach var="appLine" items="${appLineList}" varStatus="status">
		                <c:if test="${appLine.approverOrder <= 130}">
		                    <td style="text-align: center; vertical-align: middle; border: 1px solid #BDBDBD;">
		                        <c:choose>
		                            <c:when test="${appLine.approvalType == 120 || appLine.approvalType == 140}">
	                                <img src="/se/Yes.png" alt="Final Yes" style="width: 80px; height: 80px;"/> 
		                            </c:when>
		                            <c:when test="${appLine.approvalType == 130}">
	                                <img src="/se/None.png" alt="None" style="width: 80px; height: 80px;"/> 
		                            </c:when>
		                            <c:when test="${appLine.approvalType == 110}">
	                                <img src="/se/FinalYes.png" alt="Yes" style="width: 80px; height: 80px;"/> 
		                            </c:when>
		                            <c:when test="${appLine.approvalType == 100}">
	                                <img src="/se/Re.png" alt="Re" style="width: 80px; height: 80px;"/> 
		                            </c:when>
		                            <c:otherwise></c:otherwise>
		                        </c:choose>
		                    </td>
		                </c:if>
		            </c:forEach>
		        </tr>
		        <tr>
		            <c:forEach var="appLine" items="${appLineList}" varStatus="status">
		                <c:if test="${appLine.approverOrder <= 130}">
		                    <td style="text-align: center; vertical-align: middle; font-size: 14px; border: 1px solid #BDBDBD;">
		                        <c:if test="${appLine.approvalType != 100}">
		                            <fmt:formatDate value="${appLine.approvalCompleteDate}" pattern="yyyy-MM-dd" /><br />
		                        </c:if>
		                    </td>
		                </c:if>
		            </c:forEach>
		        </tr>
		    </table>
	    </div>
	    
	    </div>
        <div style="border-bottom: 1px solid #BDBDBD;">	
        <p>
        <table>
            <tr>
                <td style="text-align: center; width: 60px; font-weight: bold;">결재</td>
                <td style="text-align: center; width: 100px;">
                    <c:forEach var="appLine" items="${appLineList}" varStatus="status">
                        <c:if test="${appLine.approverOrder <= 130}">
                            ${appLine.name} 
                            <c:choose>
                                <c:when test="${appLine.grade == 100}">사원</c:when>
                                <c:when test="${appLine.grade == 110}">주임</c:when>
                                <c:when test="${appLine.grade == 120}">대리</c:when>
                                <c:when test="${appLine.grade == 130}">과장</c:when>
                                <c:when test="${appLine.grade == 140}">차장</c:when>
                                <c:when test="${appLine.grade == 150}">부장</c:when>
                                <c:when test="${appLine.grade == 160}">사장</c:when>
                                <c:otherwise>( ${appLine.grade} )</c:otherwise>
                            </c:choose>
                            <c:if test="${!status.last}"> </c:if>
                        </c:if>
                    </c:forEach>
				</td>
                <td style="text-align: center; width: 80px;">
			        <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#addressModal" onclick="setModalType('approver')">결재</button>
			   	</td>
			</tr>    
            <tr>
            	<td style="text-align: center; width: 60px; font-weight: bold;">참조</td>
            	<td style="text-align: center; width: 100px;">
                    <c:forEach var="appLine" items="${appLineList}" varStatus="status">
                        <c:if test="${appLine.approverOrder >= 900}">
                            ${appLine.name} 
                            <c:choose>
                                <c:when test="${appLine.grade == 100}">사원</c:when>
                                <c:when test="${appLine.grade == 110}">주임</c:when>
                                <c:when test="${appLine.grade == 120}">대리</c:when>
                                <c:when test="${appLine.grade == 130}">과장</c:when>
                                <c:when test="${appLine.grade == 140}">차장</c:when>
                                <c:when test="${appLine.grade == 150}">부장</c:when>
                                <c:when test="${appLine.grade == 160}">사장</c:when>
                                <c:otherwise>( ${appLine.grade} )</c:otherwise>
                            </c:choose>
                            <c:if test="${!status.last}"> </c:if>
                        </c:if>
                    </c:forEach>
				</td>
				<td style="text-align: center; width: 80px;">
                    <button type="button" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#addressModal" onclick="setModalType('referrer')">참조</button>
			    </td>
            </tr>
            <tr>
                <td style="text-align: center; width: 60px; font-weight: bold;">제목</td>
                <td>
                	<input type="text" name="approvalTitle" value="${approvalDto.approvalTitle}" style="text-align: center; width: 100%;" required>
            	</td>
            </tr>
        </table>
        </div>
		
		<p>
        <p>
        <h6 style="text-align: center; font-weight: bold;"> - 아래와 같이 기안하오니 검토 후 결재 바랍니다 - </h6>
        <p>
        
        <h3>${approvalDto.documentFormTitle} 사용 정보</h3>
	        <div>
	             <label for="usagePeriod" style="width: 120px; text-align: center; font-weight: bold;">시작일</label>
				 <input style="margin-left:100px; width: 200px; text-align: center; height: 30px;" type="date" id="furloughStartDate" name="furloughStartDate" onchange="updateDay()" value="<fmt:formatDate value="${approvalDto.furloughStartDate}" pattern="yyyy-MM-dd" />" required><br><br>
			</div>
	        <div>
			    <label for="furloughStartDate" style="width: 120px; text-align: center; font-weight: bold;">종료일</label>
			    <input style="margin-left:100px; width: 200px; text-align: center; height: 30px;" type="date" id="furloughEndDate" name="furloughEndDate" onchange="updateDay()" value="<fmt:formatDate value="${approvalDto.furloughEndDate}" pattern="yyyy-MM-dd" />" required><br><br>
			</div>
	        <div>
			    <label for="furloughEndDate" style="width: 120px; text-align: center; font-weight: bold;">사용일</label>
			    <input style="margin-left:100px; width: 200px; text-align: center; height: 30px;" type="number" id="usagePeriod" name="furloughServiceData" placeholder="사용 일수를 입력하세요" value="${approvalDto.furloughServiceData}" required /><br><br>
			</div>
		
        <div>
	        <p>
	        <h4>사유</h4>
			<textarea id="furloughCnt" style="border: 1px solid #BDBDBD; padding: 10px; margin-bottom: 20px; width: 650px; height: 200px; resize: none;" name="furloughCnt" placeholder="사유를 입력하세요">${approvalDto.furloughCnt}</textarea>
			<h3>첨부 파일</h3>
		   	<div style="margin-bottom: 20px;">
				<input type="file"  name="imageAttachment" class="file-upload" >
			</div>
		</div>

        <div class="btn-group" style="text-align: center; margin-left: 210px;">
		    <button type="submit" class="btn btn-outline-primary">작성</button>
		    <button type="button" class="btn btn-outline-secondary" onclick="resetForm()">초기화</button>
		    <button type="button" class="btn btn-outline-danger" onclick="deleteApproval(${approvalDto.documentFormId}, ${approvalDto.approvalNum})">삭제</button>
		    <button type="button" class="btn btn-outline-dark" onclick="goBack()">목록</button>
		</div>
        
      <!-- 모달 -->
	<div class="modal fade" id="addressModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static">
	    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h1 class="modal-title fs-5" id="exampleModalLabel">결재라인 추가</h1>
	                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	            </div>
	            <div class="modal-body">
	                <div class="container-fluid">
	                    <div class="row">
	                        <div class="col-sm-7">
	                            <div class="accordion accordion-flush" id="accordionFlushExample">
	                                <!-- 직원 아코디언 항목이 동적으로 추가될 부분 -->
	                            </div>
	                        </div>
	
	                        <div class="col-md-4 ms-auto">
	                            <div class="text-center">
	                                <span class="font-weight-bold text-primary"></span>
	                                <div class="selected-approvers text-start" id="selectedApprovers">
	                                    <!-- 선택된 결재자 목록 -->
	                                </div>
	                            </div>
	                            <hr>
	                            <div class="text-center">
	                                <span class="font-weight-bold text-primary"></span>
	                                <div class="selected-referrers text-start" id="selectedReferrers">
	                                    <!-- 선택된 참조자 목록 -->
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	
	            <div class="modal-footer">
					<button type="button" class="btn btn-outline-secondary btn-sm" data-bs-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-outline-warning btn-sm" onclick="addSelectedMembers();">적용</button>
	            </div>
	        </div>
	    </div>
	    </div>
	</form>
	</div>	
  <footer style="padding-bottom: 40px;"></footer>
</main>
</body>
</html>
