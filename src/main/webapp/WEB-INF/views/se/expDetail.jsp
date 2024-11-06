<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../1.main/user_header.jsp" %>
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
    
    .item-code {
	    background-color: #f2f2f2; /* 항목코드 배경색 */
	    text-align: center;          /* 정렬 */
	    padding: 10px;            /* 패딩 */
	}
	
	.content {
	    background-color: #e0f7fa; /* 내용 배경색 */
	    text-align: center;        /* 정렬 */
	    padding: 10px;            /* 패딩 */
	}
	
	.amount {
	    background-color: #ffe0b2; /* 금액 배경색 */
	    text-align: center;         /* 정렬 */
	    padding: 10px;            /* 패딩 */
	}
	    
</style>
<script>
	function appPopUp(state, approverOrder) {
		var strState 		= "";
		var approvalNum		= $("input[name=approvalNum]").val();
		var empno			= $("input[name=empno]").val();
		var documentFormId	= $("input[name=documentFormId]").val();
		
		
		if(state == 0) {
			strState = "ok";
		} else if(state == 1){
			strState = "no";
		} else if(state == 2){
			strState = "all";
		} else if(state == 3){
			strState = "del";
		} else{
		 	strStart = "next";
		}

    	var url = "appWord?app=" + strState
    				+ "&approvalNum=" + approvalNum
    				+ "&empno=" + empno
    				+ "&documentFormId=" + documentFormId
    				+ "&approverOrder=" + approverOrder;
    	
    	window.open(url, '_blank', 'width=600,height=430,location=no,status=no');
	}
		
	
    function printPage() {
        window.print();
    }
    
    function goBack() {
	    window.history.go(-1);
	}
</script>
<%
	String documentFormId = request.getParameter("documentFormId");
	request.setAttribute("documentFormId", documentFormId);
	String approvalNum = request.getParameter("approvalNum");
	request.setAttribute("approvalNum", approvalNum);
%>
<title>${approvalDto.documentFormTitle}</title>
</head>
<body>
<main id="expForm">
	<div id="content" style="border: 1px solid #BDBDBD; width: 730px; margin-top: 30px; box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.5);">
		<input type="hidden" name="documentFormId"  value="${documentFormId}">
		<input type="hidden" name="empno"           value="${approvalDto.empno}">
		<input type="hidden" id="selectedApproversInput" name="selectedApprovers" value="">
		<input type="hidden" id="selectedReferrersInput" name="selectedReferrers" value="">
	
		<div style="border-bottom: 1px solid #BDBDBD;">	
			<h2>${approvalDto.documentFormTitle} 승인 기안</h2>
			<p>
		</div>
		<p>
		<c:set var="editButton" value="true" />
		<c:forEach var="appLine" items="${appLineList}">
			<c:if test="${(appLine.approverOrder == 110 || appLine.approverOrder == 120 || appLine.approverOrder == 130) && 
						  (appLine.approvalType == 110 || appLine.approvalType == 120 || appLine.approvalType == 130 || appLine.approvalType == 140)}">
				<c:set var="editButton" value="false" />
			</c:if>
		</c:forEach>
	
		<div style="display: flex; border-bottom: 1px solid #BDBDBD;">
		<div>	
			<table class="draft">
				<tr>
					<th style="width: 150px;">문서번호</th>
					<td>${approvalDto.approvalNum}</td>
				</tr>
				<tr>
					<th style="width: 150px;">기안일자</th>
					<td>
					<fmt:formatDate value="${approvalDto.approvalDate}" pattern="yy/MM/dd" />
					</td>
				</tr>
				<tr>
					<th style="width: 150px;">기안자</th>
					<td>${approvalDto.name}</td>
				</tr>
				<tr>
					<th style="width: 150px;">기안자부서</th>
					<td>${approvalDto.deptName}</td>
				</tr>
				<tr>
					<th style="width: 150px;">기안자직급</th>
					<td>
						${approvalDto.grade == 100 ? '사원' :
						  approvalDto.grade == 110 ? '주임' :
						  approvalDto.grade == 120 ? '대리' :
						  approvalDto.grade == 130 ? '과장' :
						  approvalDto.grade == 140 ? '차장' :
						  approvalDto.grade == 150 ? '부장' :
						  approvalDto.grade == 160 ? '사장' : 'Unknown'}
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
			<div>	
				<c:if test="${sessionScope.emp.empno != null}">
					<div class="button-group" style="width: 200px; padding-bottom: 10px;">
						<c:forEach var="appLine" items="${appLineList}">
							<c:if test="${appLine.approverOrder == 110 || appLine.approverOrder == 120 || appLine.approverOrder == 130}">
								<input type="hidden" name="approverOrder" value="${appLine.approverOrder}">
								<input type="hidden" name="approvalNum" value="${approvalNum}">
								<input type="hidden" name="documentFormId" value="${documentFormId}">
								<input type="hidden" name="empno" value="${emp.empno}">
							
								<!-- empno와 approverOrder 두 가지 조건 체크 -->
								<c:if test="${emp.empno != null}">
									<c:choose>
										<c:when test="${appLine.empno == emp.empno && appLine.approverOrder == 110}">
											<button type="button" style="width: 45px; height: 25px; font-size: 13px;" onclick="appPopUp(0, '${appLine.approverOrder}')">승인</button>
											<button type="button" style="width: 45px; height: 25px; font-size: 13px;" onclick="appPopUp(1, '${appLine.approverOrder}')">반려</button>
											<button type="button" style="width: 45px; height: 25px; font-size: 13px;" onclick="appPopUp(2, '${appLine.approverOrder}')">전결</button>
											<button style="width: 45px; height: 25px; font-size: 13px;" onclick="location.href='appLineUpdate?approverOrder=110&app=del&empno=${emp.empno}&documentFormId=${documentFormId}&approvalNum=${approvalNum}'">철회</button>
										</c:when>
										<c:when test="${appLine.empno == emp.empno && appLine.approverOrder == 120}">
											<button type="button" style="width: 45px; height: 25px; font-size: 13px;" onclick="appPopUp(0, '${appLine.approverOrder}')">승인</button>
											<button type="button" style="width: 45px; height: 25px; font-size: 13px;" onclick="appPopUp(1, '${appLine.approverOrder}')">반려</button>
											<button type="button" style="width: 45px; height: 25px; font-size: 13px;" onclick="appPopUp(4, '${appLine.approverOrder}')">이월</button>
										</c:when>
										<c:when test="${appLine.empno == emp.empno && appLine.approverOrder == 130}">
											<button type="button" style="width: 45px; height: 25px; font-size: 13px;" onclick="appPopUp(0, '${appLine.approverOrder}')">승인</button>
											<button type="button" style="width: 45px; height: 25px; font-size: 13px;" onclick="appPopUp(1, '${appLine.approverOrder}')">반려</button>
										</c:when>
									</c:choose>
								</c:if>
							</c:if>
						</c:forEach>
					</div>
				</c:if>
			</div>
		</div>
	
	<p>	
	 </div>     
	 	<p> 
		<table>
			<tr>
				<td style="text-align: center; width: 60px;">결재</td>
				<td style="text-align: center;">
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
						<c:if test="${!status.last}">  </c:if>
						</c:if>
					</c:forEach>
				</td>
			</tr>
			<tr>
				<td style="text-align: center; width: 60px;">참조</td>
				<td style="text-align: center; width: 90%;">
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
						<c:if test="${!status.last}">  </c:if>
						</c:if>
					</c:forEach>
				</td>
			</tr>
		<tr>
			<td style="text-align: center; width: 60px;">제목</td>
			<td style="text-align: center;">${approvalDto.approvalTitle}</td>
		</tr>
		</table>
		<p>
		<p>
		<h6 style="text-align: center; font-weight: bold;"> - 아래와 같이 기안하오니 검토 후 결재 바랍니다 - </h6>
		<p>
		<div style="border-bottom: 1px solid #BDBDBD;">	
		<h3>${approvalDto.documentFormTitle} 요청 정보</h3>
	
			<table style="border: 1px solid #BDBDBD; padding: 10px; margin-bottom: 20px;">
				<tr>
					<th class="item-code" style="width : 300px;">항목코드</th>
					<th class="content" style="width : 1500px;">내용</th>
					<th class="amount" style="width : 300px;">금액</th>
				</tr>
				<c:forEach var="appCost" items="${appCostList}" varStatus="status">
					<tr>
						<td style="width : 300px; text-align: center;">
							<c:choose>
								<c:when test="${appCost.costDetailsCode == 100}">비품</c:when>
								<c:when test="${appCost.costDetailsCode == 110}">유류비</c:when>
								<c:when test="${appCost.costDetailsCode == 120}">공과금</c:when>
								<c:when test="${appCost.costDetailsCode == 130}">특수비용</c:when>
							</c:choose>
						</td>
						<td style="height:100px; width : 1500px; text-align: center;">${appCost.costDetailsCnt}</td>
						<td style="width : 300px; text-align: center;">${appCost.costAmount} 원</td>
					</tr>
				</c:forEach>
			</table>
		
			<div style="margin-bottom: 20px;">
				<label for="fileAttachment">파일첨부</label><br>
				<a href="/se/appDownLoad?imageAttachment=${approvalDto.imageAttachment}" style="text-decoration: none;">${approvalDto.imageAttachment}</a>
			</div>
		</div>
	      
		<div style="border-top: 1px solid #BDBDBD;">
		<p>	
		<h4>결재 코멘트</h4>
		<div style="border: 1px solid #BDBDBD; padding: 10px; margin-bottom: 20px; width: 700px; height: 100px;">
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
						</c:choose> |
				<c:if test="${!status.last}" />
				${appLine.approvalCnt}<br/>
				</c:if>
			</c:forEach>
		</div>
		<p>
		<div class="button-group" style="text-align: center;">
			<button type="button" onclick="goBack()">목록</button>
				<c:if test="${editButton && approvalDto.empno == emp.empno}">
				<input type="button" value="회수" id="rebutton"
				   	   onclick="location.href='appUpdateForm?approvalNum=${approvalDto.approvalNum}&documentFormId=${approvalDto.documentFormId}'">
				</c:if>
			<button type="button" class="print" onclick="printPage()">인쇄</button>
			<p>
		</div>
	</div>
	</div>
	<footer style="padding-bottom: 40px;"></footer>
</main>
</body>
</html>