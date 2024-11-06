<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Enumeration"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<script type="text/javascript">
function checkPasswd() {
    var empno = $('#empno').val();
    var salNum = $('#salNum').val();
    var password = $('#password').val(); 
    console.log("empno:", empno);  
    console.log("salNum:", salNum);
    console.log("password:", password);

    $.ajax({
        type: "POST",
        url: "/mh/processStep1",
        data: { empno: empno, salNum: salNum, password: password },
        success: function(response) {
            console.log("Step 1 성공:", response);
            if (response === "/salJoin") {
                // 비밀번호 성공 시 POST로 salJoin으로 이동
                postToSalJoin(empno, salNum, password);
            } else {
                alert(response);  // 비밀번호가 틀린 경우 메시지
            }
        },
        error: function(error) {
            console.error("오류 발생:", error);
        }
    });
}

function postToSalJoin(empno, salNum, password) {
    // 동적으로 폼 생성
    var form = document.createElement("form");
    form.method = "POST";
    form.action = "/mh/salJoin";  // POST 방식으로 전송할 경로

    // empno, salNum, password 값을 히든 필드로 추가
    var empnoField = document.createElement("input");
    empnoField.type = "hidden";
    empnoField.name = "empno";
    empnoField.value = empno;
    form.appendChild(empnoField);

    var salNumField = document.createElement("input");
    salNumField.type = "hidden";
    salNumField.name = "salNum";
    salNumField.value = salNum;
    form.appendChild(salNumField);
    
    var passwordField = document.createElement("input");
    passwordField.type = "hidden";
    passwordField.name = "password";
    passwordField.value = password;
    form.appendChild(passwordField);

    // 폼을 document에 추가하고 제출
    document.body.appendChild(form);
    form.submit();
}

</script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 확인</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
rel="stylesheet">
<style>
    body {
        background-color: #f8f9fa; /* 배경 색을 밝은 회색으로 */
        font-family: Arial, sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh; /* 화면 전체 높이 차지 */
        margin: 0;
    }

    .form-container {
        background-color: white;
        padding: 40px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 살짝 그림자 */
        text-align: center;
        max-width: 400px;
        width: 100%;
    }

    h2 {
        color: #343a40; /* 다크 그레이 색 */
        margin-bottom: 20px;
        font-size: 1.8rem;
    }

    input[type="password"] {
        width: 100%;
        padding: 10px;
        margin-bottom: 15px;
        font-size: 16px;
        border: 1px solid #ced4da; /* 경계선 색 */
        border-radius: 5px;
        box-sizing: border-box;
    }

    button {
        width: 100%;
        padding: 10px;
        font-size: 16px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    button:hover {
        background-color: #0056b3; /* 버튼 호버 시 어두운 파란색 */
    }

    .form-container input[type="hidden"] {
        display: none;
    }

    /* 반응형 디자인을 위해 화면 크기가 줄어들 때의 스타일 */
    @media (max-width: 600px) {
        .form-container {
            padding: 20px;
        }

        h2 {
            font-size: 1.5rem;
        }
    }
</style>
</head>
<body>
    <div class="form-container">
        <h3>비밀번호 확인</h3>
        <form>
            <input type="password" id="password" name="password" placeholder="비밀번호 입력">
            <input type="hidden" id="empno" name="empno" value="${emp.empno}">
            <input type="hidden" id="salNum" name="salNum" value="${salNum}">
            <button type="button" onclick="checkPasswd()">확인</button>
        </form>
    </div>
</body>
</html>