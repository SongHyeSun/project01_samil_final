<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../1.main/user_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <style type="text/css">
        main {
            background-color: #fff;
            margin: 50px 150px;
            border-radius: 8px;
            padding-bottom: 50px;
        }

        h2 {
            color: #034EA2;
            border-bottom: 2px solid #034EA2;
            padding-bottom: 5px;
            margin-bottom: 20px;
            font-weight: bold;
            display: inline-block;
        }

        .link-container {
            display: flex;
            flex-direction: column;
        }

        .template {
            display: inline-block;
            background-color: #034EA2;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            margin: 5px 0;
            transition: background-color 0.3s;
        }

        .template:hover {
            background-color: #0277BD;
        }

        i {
            margin-right: 8px; /* 아이콘과 텍스트 사이의 여백 */
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <main>
        <h2>기안 작성 서식</h2>

        <div class="link-container">
            <p><a class="template" href="draftingForm?documentFormId=100"><i class="fas fa-calendar-alt"></i> 연차 기안 서식</a></p>
            <p><a class="template" href="draftingForm?documentFormId=110"><i class="fas fa-calendar-times"></i> 병가 기안 서식</a></p>
            <p><a class="template" href="draftingForm?documentFormId=120"><i class="fas fa-gift"></i> 경조사 기안 서식</a></p>
            <p><a class="template" href="draftingForm?documentFormId=130"><i class="fas fa-building"></i> 법인 결제 기안 서식</a></p>
            <p><a class="template" href="draftingForm?documentFormId=140"><i class="fas fa-shopping-cart"></i> 비품 결제 기안 서식</a></p>
            <p><a class="template" href="draftingForm?documentFormId=150"><i class="fas fa-gas-pump"></i> 유류비 결제 기안 서식</a></p>
            <p><a class="template" href="draftingForm?documentFormId=160"><i class="fas fa-user-alt"></i> 휴직 요청 기안 서식</a></p>
            <p><a class="template" href="draftingForm?documentFormId=170"><i class="fas fa-sign-out-alt"></i> 퇴직 요청 기안 서식</a></p>
        </div>
    </main>
</body>
</html>