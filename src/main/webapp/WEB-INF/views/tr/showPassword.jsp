<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	
<style type="text/css">
	.gradient-custom {
		background: linear-gradient(to right, rgba(106, 17, 203, 1),
			rgba(37, 117, 252, 1));
	}
	/* button style */
.button {
 background: #fac100;
 border: none;
 width: 210px;
 height: 60px;
 font-size: 20px;
 font-weight: 700;
 color: #171205;
 border-radius: 10px;
 cursor: pointer;
}

/* light on hover with a simple box-shadow */
.button:hover {
  background: #f7d874;
  color: #fac100;
  box-shadow: 0 0 10px #fac100,
              0 0 25px #fac100,
              0 0 50px #fac100,
              0 0 100px #fac100;
  
}
</style>
</head>
<body class="gradient-custom">
	<section class="d-flex vh-100">
		<div
			class="container-fluid row justify-content-center align-content-center">
			<div class="card bg-dark" style="border-radius: 1rem;">
				<div class="card-body p-5 text-center">
				<c:if test="${!empty LoginInfo.password}">
					<h2 class="text-white">비밀번호는</h2> 
					<p>
					<h2 class="text-info">${LoginInfo.password}</h2>
					
					<h2 class="text-white">입니다</h2> 
					</c:if>
					<c:if test="${empty LoginInfo.password}">
						<h2 class="text-warning">땡!</h2> 
						<p>
							<input type="button" class="button" onclick="location.href='/tr/findPassword'"
								value="한번만 더 시도 해보기">
					</c:if>
					<br>
					<br>
						<input type="button" class="btn btn-primary" onclick="location.href='/'" value="로그인 화면">
				</div>
			</div>
		</div>
	</section>
</body>
</html>