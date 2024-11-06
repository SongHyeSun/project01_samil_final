<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 12px;
            border: 2px solid #ddd;
            word-wrap: break-word; /* Allow word wrap */
            min-width: 0px; /* Minimum width */
        }

        th {
            background-color: #034EA2; /* Header background */
            color: white;
            text-align: center;
        }

        td {
            text-align: left;
        }

        textarea {
            width: 100%;
            height: 250px; /* Height for textarea */
            resize: vertical; /* Allow vertical resize */
        }

        .button-container {
            margin-top: 20px;
            text-align: center; /* Center align buttons */
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

        .file-upload {
            display: inline-block;
        }
    </style>

</head>

<body>
<main>
    <h2>게시물 수정</h2>

    <form action="updatePostsFaq" method="post" onsubmit="showUpdateAlert();">
        <input type="hidden" name="postId" value="${posts.postId}">
        <input type="hidden" name="empno" value="${posts.empno}">

        <table>
            <tr>
                <th>작성자</th>
                <td>
                    ${posts.name}
                    <input type="hidden" name="empno" value="${posts.empno}"/>
                </td>
            </tr>
            <tr>
                <th>제목</th>
                <td><input type="text" name="postsTitle" value="${posts.postsTitle}" required="required" style="width: 100%;"></td>
            </tr>
            <tr>
                <th>내용</th>
                <td><textarea name="postsCnt" required="required">${posts.postsCnt}</textarea></td>
            </tr>
            <tr>
                <th>파일첨부</th>
                <td>
                    ${posts.fileName}
                    <input type="file" name="fileName" class="file-upload">
                </td>
            </tr>
            <tr>
                <th>조회수</th>
                <td>${posts.postsViews}</td>
            </tr>
        </table>

		<div class="button-container" style="margin-left: 500px;">
            <button type="submit" class="btn btn-outline-primary">수정</button>
            <button class="btn btn-outline-secondary" onclick="history.back();">취소</button>
        </div>
    </form>
</main>
</body>

</html>
