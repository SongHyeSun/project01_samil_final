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
            max-width: 800px; /* Max width */
        }

        h2 {
            margin-top: 0;
            color: #333;
            padding-bottom: 10px;
        }

        table {
            margin: 20px auto;
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            padding: 12px;
            border: 2px solid #ddd;
            word-wrap: break-word; /* Allow word wrap */
        }

        th {
            background-color: #034EA2; /* Header background */
            color: white;
            text-align: center;
        }

        td {
            text-align: left;
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
        }

        textarea {
            height: 200px;
            resize: vertical; /* Allow vertical resize */
        }

        .button-container {
            margin-top: 20px;
        }

        .button-container input[type="submit"],
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

        .button-container input[type="submit"]:hover,
        .button-container input[type="button"]:hover {
            background-color: #023e8a;
        }
    </style>
    <script>
        function showAlert() {
            alert("답글이 작성되었습니다.");
        }
    </script>
    <title>답글 작성</title>
</head>

<body>
<main>
    <h2>답글 작성</h2>

    <!-- 답글 작성 폼 -->
    <form action="replyfree1" method="get" onsubmit="showAlert()">
        <table>
            <tr>
                <th>작성자</th>
                <td>${emp.name}</td> <!-- 작성자 필드는 readonly -->
            </tr>
            <tr>
                <th>제목</th>
                <td>
                    <input type="text" name="title" value="${posts.postsTitle}" placeholder="제목을 입력하세요" required>
                </td> <!-- 제목은 이제 입력 가능 -->
            </tr>
            <tr>
                <th>내용</th>
                <td>
                    <textarea name="content" placeholder="내용을 입력하세요" required></textarea>
                </td> <!-- 내용 입력 필드 -->
            </tr>
        </table>
        <input type="hidden" name="postId" value="${postId}">
        <input type="hidden" name="empno" value="${emp.empno}">

        <!-- 버튼 영역 -->
<div class="button-container"style="margin-left: 500px;">
            <button type="submit" class="btn btn-outline-warning" style="margin-right: 15px;">답글저장</button>
            <button onclick="history.back();" class="btn btn-outline-secondary" style="margin-right: 15px;">목록</button>
        </div>
    </form>
</main>
</body>

</html>
