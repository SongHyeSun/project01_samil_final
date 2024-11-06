<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../1.main/user_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
	/* 메인 */
	.entire {
		display: flex;
		flex-direction: column; /* 수직 정렬로 변경 */
		margin: 40px 120px 20px 150px;
		width: 1400px;
	}
	
	a {
		text-decoration: none;	/* 밑줄제거 */
	}
	
	.resClick {
		width: 250px;
		max-width: 250px;
		min-width: 200px;
		border: 1px solid #0000A5;
		height: 40px;
		border-radius: 10px;
		display: flex; /* Flexbox 사용 */
		justify-content: center; /* 가로 가운데 정렬 */
		align-items: center; /* 세로 가운데 정렬 */
		text-align: center; /* 텍스트와 테이블을 가운데 정렬 */
		background-color: rgb(3, 78, 162);
	}
	
	.resClick p {
		font-size: 18px;
		font-weight: bold;
		color: white;
		margin: 18px 0px 14px 0px;
	}
	
	.resclick2 {
		display: block;
		width: 1150px;
		max-width: 1150px;
		min-width: 1150px;
		height: 40px;
		margin-top: 20px; /* 위쪽 간격 추가 */
	}
	
	.resloading {
		width: 100%;
		margin-top: 20px; /* 위쪽 간격 추가 */
	}
	
	.resloading .mytable {
		height: 70px;
		border-bottom: 2px solid rgb(3, 78, 162);
		margin-bottom: 30px;
		width: 100%;
	}
	
	.resloading .mytable th {
		width: 50px;
		font-size: 30px;
		color: rgb(3, 78, 162);
	}
	
	.resloading .mytable td {
		width: 100%;
		font-size: 20px;
		font-weight: bold;
		color: rgb(3, 78, 162);
	}
	
	.resloading .loadtable {
		padding: 0px 50px;
	}
	
	.resloading .loadtable th {
		 width: 1300px;
		 height: 70px;
		 text-align: left;
		 font-size: 19px;
	}
	
	.resloading .loadtable td {
		height: 30px;
	}
	
	.resAccRej {
		display: flex; /* Flexbox 사용 */
		margin-top: 20px; /* 위쪽 간격 추가 */
	}
	
	.resAcc {
		width: 50%;
		padding-top: 50px;
	}
	
	.resAcc th {
		 width: 1300px;
		 height: 70px;
		 text-align: left;
		 font-size: 19px;
	}
	
	.resAcc td {
		height: 30px;
	}
	
	.resRej {
		width: 50%;
		padding: 50px 0px 0px 50px;
	}
	
	.resRej th {
		 width: 1300px;
		 height: 70px;
		 text-align: left;
		 font-size: 19px;
	}
	
	.resRej td {
		height: 30px;
	}
	
	.delete-button {
		cursor: pointer; /* 포인터 커서 변경 */
		transition: transform 0.2s; /* 부드러운 효과 */
	}
</style>
<script type="text/javascript">
	function confirmDel(resCode) {
		// 알림창 띄우기
		var result = confirm("예약을 취소하시겠습니까?");
		if (result) {
			// 사용자가 확인을 클릭한 경우, 삭제 요청을 수행합니다.
			document.getElementById('deleteForm' + resCode).submit();
		}
	}
</script>
<title>res</title>
</head>
<body>
<div class="entire">
	<a href="/hs/resWriteForm">
		<div class="resClick">
			<p>시설 예약 하기</p>
		</div>
	</a>
	<div class="resClick2">
	</div>
	<div class="resloading">
		<table class="mytable">
			<tr><th>●</th><td>내 예약</td></tr>
		</table>
		<table class="loadtable">
			<tr>
				<td><img alt="Accload" src="/hs/dotdot.png" width="18px"> </td>
				<th colspan="6">예약 대기</th>
			</tr>
			<c:forEach var="reservation" items="${facilLoad}">
				<tr>
					<td style="width: 10px"></td>
					<td style="widt: 90px">${reservation.facilType }</td>
					<td style="width: 100px">${reservation.facilName }</td>
					<td style="width: 50px">일시 : </td>
					<td>${reservation.formatResStart } - ${reservation.formatResEnd }</td>
					<td class="pendel">
						<a href="/hs/resUpdate?resCode=${reservation.resCode }">
							<img alt="pen" src="/hs/update.png" style="width: 20px">
						</a>
					</td>
					<td class="pendel">
						<form id="deleteForm${reservation.resCode}" action="/hs/deleteRes" method="post" style="display: none;">
							<input type="hidden" name="resCode" value="${reservation.resCode}">
						</form>
						<img class="delete-button" src="/hs/delete.png" style="width: 20px" onclick="confirmDel(${reservation.resCode})">
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<div class="resAccRej">
		<div class="resAcc">
			<table class="Acctable">
					<tr>
						<td><img alt="Accok" src="/hs/o.png" width="18px"> </td>
						<th colspan="5">예약 완료</th>
					</tr>
					<c:forEach var="resTotal" items="${facilAcc}">
						<tr>
							<td style="max-width: 20px"></td>
							<td colspan="2" style="width: 80px">${resTotal.facilType }</td>
							<td style="width: 90px">${resTotal.facilName }</td>
							<td style="width: 50px">일시 : </td>
							<td width="200px">${resTotal.formatResStart } - ${resTotal.formatResEnd }</td>
							<td><img alt="ok" src="/hs/ok.png" style="width: 20px"></td>
						</tr>
						<tr>
							<td colspan="1"></td>
							<td colspan="6">┗ 참고: ${resTotal.resDetail }<br></td>
						</tr>
						<tr><td colspan="7" style="height: 12px"></td></tr>
					</c:forEach>
				</table>
		</div>
		<div class="resRej">
			<table class="rejtable">
					<tr>
						<td><img alt="Accrej" src="/hs/x.png" width="18px"> </td>
						<th colspan="5">예약 반려</th>
					</tr>
					<c:forEach var="facilApprove" items="${facilRej}">
						<tr>
							<td style="width: 20px"></td>
							<td colspan="2" style="width: 80px">${facilApprove.facilType }</td>
							<td style="width: 90px">${facilApprove.facilName }</td>
							<td style="width: 50px">일시 : </td>
							<td width="200px">${facilApprove.formatResStart } - ${facilApprove.formatResEnd }</td>
							<td><img alt="rej" src="/hs/rej.png" style="width: 20px"></td>
						</tr>
						<tr>
							<td colspan="1"></td>
							<td colspan="6">┗ 사유: ${facilApprove.resDetail }<br></td>
						</tr>
						<tr><td colspan="7" style="height: 12px"></td></tr>
					</c:forEach>
				</table>
		</div>
	</div>
</div>
</body>
</html>