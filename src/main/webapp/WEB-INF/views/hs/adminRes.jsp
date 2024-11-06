<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../1.main/admin_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
<style type="text/css">
    body {
	    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
	    margin: 0;
	    padding: 0;
	    justify-content: center;
	    align-items: center;
	    height: 100vh;
	}
	
	main {
	    background-color: #fff;
	    margin: 50px 150px;
	    border-radius: 8px;
	    padding-bottom: 50px;
	}
	
	a {
		text-decoration: none;	/* 밑줄제거 */
	}
	
	.content {
		display: none; /* 기본적으로 숨김 */
		padding: 10px !important;
		border: 1px solid #ccc;
		margin-top: 10px !important;
		position: absolute; /* 절대 위치 */
		background: white; /* 배경색 */
		z-index: 1; /* 위로 올리기 */
	}
	
	.faciltitle {
		width: 100%;
		text-align: left;
		position: relative; /* 자식의 절대 위치를 기준으로 설정 */
	}
	
	.toggle-button {
		cursor: pointer;
		color: #8C8C8C; /* 버튼 색상 */
		font-size: 12px;
		margin-left: 15px;
		display: inline-block; /* 인라인 블록으로 변경 */
		width: 80px; /* 고정된 너비 */
		text-align: center; /* 텍스트 중앙 정렬 */
		
	}
	
	.toggle-button:hover {
		color: #565656; /* 버튼 색상 */
		
	}
	
	.faciltitle th {
		padding-bottom: 10px;
		border-bottom: 2px solid;
	}
	
	.faciltitle .emoti {
		font-size: 18px ;
		color: #6E6E6E;
	}
	
	.faciltitle .ft {
		font-size: 20px ;
	}
	
	.faciltitle .facilsortlist {
		width: 400px;
		margin: 0 auto; /* 테이블 가운데 정렬 */
	}
	
	.faciltitle ul {
		padding: 30px !important;
	}
	
	.faciltitle .facilsortlist th {
		font-size: 15px;
		text-align: center; /* 가운데 정렬 */
	}
	
	.faciltitle .facilsortlist td {
		font-size: 13px;
		text-align: center;
		height: 30px;
	}
	
	.faciltitle .facilsortlist .pendel {
		text-align: right; /* 오른쪽 정렬 */
	}
	
	
	/* 버튼 스타일 */
	.add-button {
		background-color: #6c757d; /* 회색 배경 */
		color: white; /* 글자 색상 흰색 */
		border: none; /* 테두리 없음 */
		padding: 3px 8px; /* 여백 */
		font-size: 14px; /* 글자 크기 */
		border-radius: 5px; /* 둥근 모서리 */
		cursor: pointer; /* 커서 모양 변경 */
		transition: all 0.3s ease; /* 부드러운 변환 */
		box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 기본 그림자 */
	}

        /* 호버 효과 */
	.add-button:hover {
		background-color: #5a6268; /* 어두운 회색 배경 */
		box-shadow: inset 0 4px 8px rgba(0, 0, 0, 0.2); /* 눌리는 느낌의 그림자 */
	}
	
	.delete-button {
		cursor: pointer; /* 포인터 커서 변경 */
		transition: transform 0.2s; /* 부드러운 효과 */
	}

	.facilAppro {
		width: 100%;
		text-align: left;
		margin-top: 80px;
	}
	
	.facilAppro .emoti {
		font-size: 18px ;
		color: #6E6E6E;
	}
	
	.facilAppro th {
		padding-bottom: 10px;
	}
	
	.facilAppro .ft {
		font-size: 20px ;
		margin-right: 10px;
	}
	
	.apprbutton input[type="submit"].approve {
		background-color: #5587ed; /* 연파랑 배경색 */
		border: 1px solid #5587ed; /* 진파랑 테두리색 */
		border-radius: 8px;
		color: #ffffff; /* 글자 색 (선택 사항) */
		padding: 5px 10px; /* 버튼의 패딩 조정 */
		margin: 5px; /* 버튼 사이 간격 조정 */
		cursor: pointer; /* 버튼 클릭 시 커서 변경 */
		line-height: 0.9; /* 버튼 텍스트의 줄 높이 조정 */
		font-size: 12px; /* 버튼 텍스트 크기 조정 (옵션) */
		float: right;
	}

	.apprbutton input[type="submit"].reject {
		background-color: #ff0000; /* 빨강 배경색 */
		border: 1px solid #ff0000; /* 빨강 테두리색 */
		border-radius: 8px;
		color: #ffffff; /* 글자 색 (선택 사항) */
		padding: 5px 10px; /* 버튼의 패딩 조정 */
		margin: 5px; /* 버튼 사이 간격 조정 */
		cursor: pointer; /* 버튼 클릭 시 커서 변경 */
		line-height: 0.9; /* 버튼 텍스트의 줄 높이 조정 */
		font-size: 12px; /* 버튼 텍스트 크기 조정 (옵션) */
		float: right;
	}
	
	.reserAppr {
		width: 100%;
	}
	
	.reserAppr th,
	.reserAppr td {
		text-align: center; /* 가운데 정렬 */
	}

	.reserAppr th {
		padding: 5px 0;
		background-color: #6E6E6E;
    	color: white;
	}
	.reserAppr th:last-child  {
        border-top-right-radius: 8px; /* 오른쪽 상단 둥글게 */
	}
	.reserAppr th:first-child  {
        border-top-left-radius: 8px; /* 오른쪽 상단 둥글게 */
	}

	.reserAppr td {
		padding: 10px 0;
	}

	.reserAppr tr:hover, reserAppr tr:hover {
		background-color: #e0e0e0; /* 호버 시 배경색 */
	}
	
	.btn .btn-primary {
		width: 50px;
	}

</style>
<title>admin_res</title>

<script>
 		
	function toggleContent() {
		const content = document.getElementById("toggleContent");
		const button = document.querySelector(".toggle-button");
		if (content.style.display === "none" || content.style.display === "") {
			content.style.display = "block";
			button.innerHTML = "▲ 숨기기"; // 버튼 텍스트 변경
		} else {
			content.style.display = "none";
			button.innerHTML = "▼ 상세보기"; // 버튼 텍스트 변경
		}
	}
       
	function confirmDel(facilId) {
		// 알림창 띄우기
		var result = confirm("시설을 삭제하시겠습니까?");
		if (result) {
			// 사용자가 확인을 클릭한 경우, 삭제 요청을 수행합니다.
			document.getElementById('deleteAdFacil' + facilId).submit();
		}
	}
       
	function openPopup(url) {
	    const popup = window.open(url, 'popupWindow', 'width=400,height=250');
	    
	    // 팝업이 열렸는지 확인
	    if (!popup) {
	        alert("팝업이 차단되었습니다. 설정에서 허용해 주세요.");
	    }
	}
	
	function openPopup1(url) {
	    const popup = window.open(url, 'popupWindow', 'width=600,height=500');
	    
	    // 팝업이 열렸는지 확인
	    if (!popup) {
	        alert("팝업이 차단되었습니다. 설정에서 허용해 주세요.");
	    }
	}
	
	function openPopup(url) {
        window.open(url, 'popupWindow', 'width=600,height=400,scrollbars=yes');
    }
	
	function setModalData(resCode, empno, facilId) {
		document.querySelector('#exampleModal input[name="resCode"]').value = resCode;
		document.querySelector('#exampleModal input[name="empno"]').value = empno;
		document.querySelector('#exampleModal input[name="facilId"]').value = facilId;

		// 반려 모달의 input 요소 업데이트
		document.querySelector('#exampleModal1 input[name="resCode"]').value = resCode;
		document.querySelector('#exampleModal1 input[name="empno"]').value = empno;
		document.querySelector('#exampleModal1 input[name="facilId"]').value = facilId;
	}
	
	function populateModal(facilId, facilType, facilName) {
		document.querySelector('#exampleModal3 input[name="facilId"]').value = facilId;
		document.querySelector('#exampleModal3 input[name="facilType"]').value = facilType;	// 이 부분은 input의 name 속성이 facilType일 경우
		document.querySelector('#exampleModal3 input[name="facilName"]').value = facilName;	// 이 부분은 input의 name 속성이 facilName일 경우
	}
	

</script>
</head>
<body>
<main>
	<div class="facilsort">
		<table class="faciltitle">
			<tr>
				<th>
					<span class="emoti">●</span> <span class="ft">시설 종류</span>
					
					<!-- 상세보기 버튼 -->
					<button class="btn btn-light dropdown-toggle btn-sm" type="button" data-bs-toggle="dropdown" aria-expanded="false"
						style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;">상세보기</button>
					<ul class="dropdown-menu">
						<table class="facilsortlist">
							<tr>
								<th class="texttype">시설종류</th>
								<th class="texttype">시설명</th>
								<th></th>
								<th></th>
							</tr>
							<c:forEach var="facility" items="${facilSort }">
								<tr>
									<td class="texttype">${facility.facilType }</td>
									<td class="texttype">${facility.facilName }</td>
									<td class="pendel">
										<button style="background-image: url('/hs/update.png'); width: 15px; height: 15px;border: none; background-size: cover;"
											data-bs-toggle="modal" data-bs-target="#exampleModal3" 
        									onclick="populateModal(${facility.facilId}, '${facility.facilType}', '${facility.facilName}')"></button>
										
									</td>
									<td class="pendel">
										<form id="deleteAdFacil${facility.facilId}" action="deleteAdFacil" method="post" style="display: none;">
											<input type="hidden" name="facilId" value="${facility.facilId}">
										</form>
										<img class="delete-button" src="/hs/delete.png" style="width: 15px" onclick="confirmDel(${facility.facilId})">
									</td>
								</tr>
							</c:forEach>
						</table>
  					</ul>
  					
  					<!-- 시설 추가 버튼 -->
					<button type="button" class="btn btn-outline-secondary"
        			style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;"
        			data-bs-toggle="modal" data-bs-target="#exampleModal2">
					+ 추가</button>
					<div class="content" id="toggleContent">
						<table class="facilsortlist">
							<tr>
								<th class="texttype">시설종류</th>
								<th class="texttype">시설명</th>
								<th></th>
								<th></th>
							</tr>
							<c:forEach var="facility" items="${facilSort }">
								<tr>
									<td class="texttype">${facility.facilType }</td>
									<td class="texttype">${facility.facilName }</td>
									<td class="pendel">
										<a href="/hs/admin_resUpdate?facilId=${facility.facilId }"
											onclick="openPopup('admin_resUpdate?facilId=${facility.facilId}'); event.preventDefault();">
											<img alt="pen" src="/hs/update.png" style="width: 15px">
										</a>
									</td>
									<td class="pendel">
										<form id="deleteAdFacil${facility.facilId}" action="deleteAdFacil" method="post" style="display: none;">
											<input type="hidden" name="facilId" value="${facility.facilId}">
										</form>
										<img class="delete-button" src="/hs/delete.png" style="width: 15px" onclick="confirmDel(${facility.facilId})">
									</td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</th>
			</tr>
		</table>
	</div>
	
	<div class="reserApprove">
		<table class="facilAppro">
			<tr><th><span class="emoti">●</span><span class="ft"> 시설 승인 요청</span></th></tr>
		</table>
		<table class="reserAppr">
			<tr>
				<th>시설명</th>
				<th>일시</th>
				<th>내용</th>
				<th>신청자</th>
				<th>연락처</th>
				<th>요청사안</th>
				<th></th>
			</tr>
			<c:forEach var="reservation" items="${reserList }">
				<tr>
					<td>${reservation.facilType} ${reservation.facilName }</td>
					<td>${reservation.formatResStart} - ${reservation.formatResEnd }</td>
					<td>${reservation.resContent}</td>
					<td>${reservation.name} ${empgrade[reservation.grade]}</td>
					<td>${reservation.formattedResTel}</td>
					<td>${reservation.resRequest}</td>
					<td class="apprbutton">
						<button type="button" class="btn btn-outline-info btn-sm" data-bs-toggle="modal" data-bs-target="#exampleModal" 
							onclick="setModalData('${reservation.resCode}', '${emp.empno}', '${reservation.facilId}')"
							style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;">승인</button>
						<button type="button" class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" data-bs-target="#exampleModal1"
							onclick="setModalData('${reservation.resCode}', '${emp.empno}', '${reservation.facilId}')"
							style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;">반려</button>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	
	<!-- 예약 승인 modal form -->
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<form  action="reserApproAd" method="post">
					<input type="hidden" name="resCode" value="${reservation.resCode }">
					<input type="hidden" name="empno" value="${emp.empno }">
					<input type="hidden" name="facilId" value="${reservation.facilId }">
					<input type="hidden" name="resState" value="110">			
					<div class="modal-header">						
						<h1 class="modal-title fs-5" id="exampleModalLabel">승인하시겠습니까?</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<div class="mb-3">
							<label for="message-text" class="col-form-label">승인 참고사항</label>
							<textarea class="form-control" id="message-text" name="resDetail"></textarea>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">닫기</button>
						<button  type="submit" class="btn btn-outline-primary">승인</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<!-- 예약 반려 modal form -->
	<div class="modal fade" id="exampleModal1" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<form action="reserRejecAd" method="post">
					<input type="hidden" name="resCode" value="${resTotal.resCode }">
					<input type="hidden" name="empno" value="${emp.empno }">
					<input type="hidden" name="facilId" value="${resTotal.facilId }">
					<input type="hidden" name="resState" value="120">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="exampleModalLabel">반려하시겠습니까?</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<div class="mb-3">
							<label for="message-text" class="col-form-label">반려 사유</label>
							<textarea class="form-control" id="message-text" name="resDetail"></textarea>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">닫기</button>
						<button type="submit" class="btn btn-outline-danger">반려</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<!-- 시설 추가 modal form -->
	<div class="modal fade" id="exampleModal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<form action="writeFacil" method="post">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="exampleModalLabel">시설 종류 추가</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<div class="mb-3">
							<table>
								<tr>
									<th>시설종류</th>
									<td>
										<input type="text" name="facilType" required="required">
									</td>
								</tr>
								<tr>
									<th>시설명</th>
									<td>
										<input type="text" name="facilName" required="required"">
									</td>
								</tr>
							</table>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-outline-secondary btn-sm" data-bs-dismiss="modal">닫기</button>
						<button type="submit" class="btn btn btn-outline-primary btn-sm">추가</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<!-- 시설 수정 modal form -->
	<div class="modal fade" id="exampleModal3" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<form action="updateFac" method="post">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="exampleModalLabel">시설 종류 수정</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
					<input type="hidden" name="facilId" value="">
						<div class="mb-3">
							<table>
								<tr>
									<th>시설종류</th>
									<td>
										<input type="text" name="facilType" required="required" value="">
									</td>
								</tr>
								<tr>
									<th>시설명</th>
									<td>
										<input type="text" name="facilName" required="required" value="">
									</td>
								</tr>
							</table>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-outline-secondary btn-sm" data-bs-dismiss="modal">닫기</button>
						<button type="submit" class="btn btn btn-outline-success btn-sm">수정</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</main>

</body>
</html>