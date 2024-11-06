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
            background-color: #f0f0f0; /* 연한 회색 배경 */
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
            max-width: 800px; /* 최대 폭 설정 */
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
		    word-wrap: break-word; /* 단어 줄 바꿈 허용 */
		    min-width: 100px; /* 최소 너비 설정 */
		}

        th {
            background-color: #034EA2; /* 헤더 배경 */
            color: white;
            text-align: center;
        }

        td {
            text-align: left;
        }


        .button-container {
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
            background-color: #023e8a;
        }

        .file-upload {
            display: inline-block;
        }
        
    </style>
    <script>
        function showDeleteAlert() {
            alert("게시물이 삭제되었습니다.");
        }
        
    </script>
</head>

<body>
    <main>
        <h2>게시물 확인</h2>

        <table>
        
            <tr><th>작성자</th><td>${posts.name}&nbsp;👤</td></tr>
            <tr><th>제목</th><td>${posts.postsTitle}</td></tr>
            <tr><th>내용</th><td>${posts.postsCnt}</td></tr>
            <tr>
                <th>파일첨부</th>
                <td>
                    <c:if test="${posts.fileName != null}">
                        <a href="/upload/jh/${posts.fileName}" download="${posts.fileName}">${posts.fileName}</a>📄
                    </c:if>
                    <c:if test="${posts.fileName == null}">
                        파일 없음
                    </c:if>
                </td>
            </tr>
            <tr><th>조회수</th><td>${posts.postsViews}</td></tr>
        </table>

<div class="button-container">
        <c:if test="${emp.admin == 150 || emp.admin == 170}">
            <button class="btn btn-outline-primary" style="margin-right: 15px;" onclick="location.href='/jh/updatePosts?postId=${posts.postId}'">수정</button>
            <button class="btn btn-outline-danger" style="margin-right: 15px;" onclick="if(confirm('정말로 삭제하시겠습니까?')) { location.href='/jh/deletePosts?postsId=${posts.postId}'; showDeleteAlert(); }">삭제</button>
        </c:if>
        <button class="btn btn-outline-secondary" style="margin-right: 15px;" onclick="history.back();">목록</button>
    </div>
    </main>
</body>

</html>
