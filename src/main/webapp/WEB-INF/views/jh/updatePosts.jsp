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

        .author-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .pinned-checkbox {
            margin-right: 5px;
        }
    </style>

</head>

<body>
<main>
    <h2>게시물 수정</h2>

    <form action="updatePosts1" method="post" onsubmit="showUpdateAlert();">
        <input type="hidden" name="postId" value="${posts.postId}">
        <input type="hidden" name="empno" value="${posts.empno}"> <!-- empno를 히든 필드로 추가 -->

        <table>
            <tr>
                <th>작성자</th>
                <td>
                    <div class="author-container">
                        ${emp.name}
                        <input type="hidden" name="empno" value="${emp.empno}"/>
                        <div>
                            <input type="checkbox" id="isPinned" name="isPinned" value="1" ${posts.isPinned == 1 ? 'checked' : ''} class="pinned-checkbox">
                            <label for="isPinned">상단 고정</label>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <th>제목</th>
                <td><input type="text" name="postsTitle" value="${posts.postsTitle}" required="required"></td>
            </tr>
            <tr>
                <th>내용</th>
                <td><textarea name="postsCnt" required="required">${posts.postsCnt}</textarea></td>
            </tr>
            <tr>
                <th>파일첨부</th>
                <td>
                    ${posts.fileName}
                    <input type="hidden" name="fileName" value="${fileName}">
                    <input type="file" name="fileName" class="file-upload">
                </td>
            </tr>
            <tr>
                <th>조회수</th>
                <td>${posts.postsViews}</td>
            </tr>
        </table>

        <div class="button-container" style="margin-left: 500px;">
            <button type="submit" class="btn btn-outline-primary" style="margin-right: 15px;">수정</button>
            <button class="btn btn-outline-secondary" onclick="history.back();" style="margin-right: 15px;">취소</button>
            </div>
    </form>
</main>
</body>

</html>
