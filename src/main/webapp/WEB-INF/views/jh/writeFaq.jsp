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
		                .full-width {
		    width: 100%; /* 부모 요소의 너비를 100%로 설정 */
		    height: 40px; /* 적절한 높이 설정 */
		    padding: 8px; /* 패딩 추가 */
		    border: 2px solid /* 테두리 스타일 */
		    box-sizing: border-box; /* 패딩과 테두리를 포함한 전체 너비 계산 */
		}
    </style>
    <script>
        function showAlert() {
            alert("게시물이 작성되었습니다.");
        }
    </script>
</head>

<body>
<main>
    <h2>글 작성</h2>

    <form action="writeFaqq" method="post" enctype="multipart/form-data" onsubmit="showAlert()">
        <table>
            <tr>
                <th>작성자</th>
                <td>
                    ${emp.name}
                    <input type="hidden" name="empno" value="${emp.empno}"/>
                </td>
            </tr>
            <tr>
                <th>제목</th>
                <td><input type="text" name="postsTitle" class="full-width" required></td>
            </tr>
            <tr>
                <th>내용</th>
                <td><textarea name="postsCnt" rows="5" required></textarea></td>
            </tr>
            <tr>
                <th>파일첨부</th>
                <td><input type="file" name="fileName" class="file-upload"></td>
            </tr>
        </table>
		<div class="button-container" style="margin-left: 500px;">
            <button type="submit" class="btn btn-outline-primary" style="margin-right: 15px;">작성하기</button>
            <button class="btn btn-outline-secondary" onclick="history.back();" style="margin-right: 15px;">취소</button>
        </div>
    </form>
</main>
</body>

</html>
