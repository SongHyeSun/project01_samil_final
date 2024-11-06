<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../1.main/user_header.jsp"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <style type="text/css">
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0; /* Light gray background */
            margin: 0;
            padding: 20px;
            text-align: center;
        }

        main {
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            margin: 130px auto;
            max-width: 800px; /* Maximum width */
        }
        

        h2 {
            margin-top: 10px; /* Adjusted margin */
            color: #333;
        }

        table {
            margin: 20px auto;
            border-collapse: collapse;
            width: 80%; /* Adjusted width */
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 12px; /* Padding inside cells */
            border: 2px solid #ddd; /* Cell borders */
            word-wrap: break-word; /* Allow word wrap */
            min-width: 100px; /* Minimum width */
        }

        th {
            background-color: #034EA2; /* Header background */
            color: white;
            text-align: center; /* Center header text */
        }

        td {
            text-align: left;
        }

        .button-container {
            text-align: center;
            margin-top: 20px;
        }

        .button-container input[type="button"] {
            margin: 0 10px;
            padding: 8px 16px;
            font-size: 1em;
            background-color: #034EA2;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .button-container input[type="button"]:hover {
            background-color: #023e8a; /* Change background color on hover */
        }
    </style>
    <script>
        function showDeleteAlert() {
            alert("게시물이 삭제되었습니다.");
        }

        function confirmDelete(postId) {
            if (confirm('정말로 삭제하시겠습니까?')) {
                location.href = '/jh/deletePostsFree?postsId=' + postId;
                showDeleteAlert();
            }
        }
    </script>
</head>

<body>
    <main>
        <h2>답글 확인</h2>

        <table>
            <tr>
                <th>작성자</th>
                <td>${posts.name}&nbsp;👤</td>
            </tr>
            <tr>
                <th>제목</th>
                <td>${posts.postsTitle}</td>
            </tr>
            <tr>
                <th>내용</th>
                <td>${posts.postsCnt}</td>
            </tr>

            <tr>
                <th>조회수</th>
                <td>${posts.postsViews}</td>
            </tr>
        </table>

        <div class="button-container">
            <c:if test="${emp.admin == 150 || emp.admin == 170 || emp.empno == posts.empno}">
                <button class="btn btn-outline-primary" style="margin-right: 15px;" onclick="location.href='/jh/updatePostsFree?postId=${posts.postId}'">수정</button>
                <button class="btn btn-outline-danger" style="margin-right: 15px;" onclick="confirmDelete('${posts.postId}')">삭제</button>
            </c:if>
            <button class="btn btn-outline-warning" style="margin-right: 15px;" onclick="location.href='/jh/replyfree?postId=${posts.postId}'">답글작성</button>
            <button class="btn btn-outline-secondary" style="margin-right: 15px;" onclick="history.back();">목록</button>
        </div>
    </main>
</body>

</html>
