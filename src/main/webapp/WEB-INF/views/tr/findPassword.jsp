<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">

<style>
.gradient-custom {
	background: linear-gradient(to right, rgba(106, 17, 203, 1),
		rgba(37, 117, 252, 1));
}
</style>
</head>
<body class="gradient-custom">
	<section class="d-flex vh-100">
		<div class="container-fluid row justify-content-center align-content-center">
			<div class="card bg-dark" style="border-radius: 1rem;">
				<div class="card-body p-5 text-center">
				<h2 class="text-white">비밀번호 찾기</h2>
				<br>
		<div class="mb-2">		
		<form action="findPasswordCheck">
		<div class="mb-3">
			<label class="form-label text-white">사번</label> 
			<input type="number" class="form-control" name="empno" required="required">
		</div>
		
		<div class="mb-3">	
			<label class="form-label text-white">비밀번호 질문</label>
			<select name="passQuiz" class="form-control">
				<option value=1>좋아하는 색깔은?</option>
				<option value=2>좋아하는 음식은?</option>
				<option value=3>좋아하는 취미는?</option>
				<option value=4>좋아하는 동물은?</option>
				<option value=5>을밀대의 현 주소는?</option>
			</select>
		</div>
		<div class="mb-3">
				<label class="form-label text-white">비밀번호 답</label>
				<input type="text" class="form-control" name="passAnswer">
		</div>	
			<br>	
				<input type="submit" class="btn btn-primary" value="확인">
		</form>
		</div>
		</div>
	</div>
	</div>
	</section>
</body>
</html>