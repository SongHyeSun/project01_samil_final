<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결재 코맨트</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<script type="text/javascript">
	function submitAction(){
		var app 			= $("input[name=app]").val();
		var documentFormId 	= $("input[name=documentFormId]").val();
		var empno 			= $("input[name=empno]").val();
		var approvalNum 	= $("input[name=approvalNum]").val();
		var approverOrder 	= $("input[name=approverOrder]").val();
		var approvalCnt 	= $("input[name=approvalCnt]").val();
		
		location.href = "appLineUpdate?app=" + app
			 	+ "&documentFormId=" + documentFormId
			 	+ "&empno=" + empno 
			 	+ "&approvalNum=" + approvalNum
			 	+ "&approverOrder=" + approverOrder
				+ "&approvalCnt=" + approvalCnt;
		window.close();
	    window.opener.location.reload();
	}
</script>

<body>
<form action="appLineUpdate" method="get">
<input type="hidden" name="app" value="${approvalDto.app}">
<input type="hidden" name="documentFormId" value="${approvalDto.documentFormId}">
<input type="hidden" name="empno" value="${emp.empno}">
<input type="hidden" name="approverOrder" value="${approvalDto.approverOrder}">
<input type="hidden" name="approvalNum" value="${approvalDto.approvalNum}">
<h2>결재 코맨트</h2>
<input type="text" name="approvalCnt" style="margin-left:12px; width: 550px; height: 300px;">
<button type="button" onclick="window.close();" style="float: right; margin-top: 15px; margin-right: 20px;">닫기</button>
<input 	type="button" onclick="submitAction()" 	style="float: right; margin-top: 15px; margin-right: 5px;"	value="승인"/>
</form>
</body>
</html>