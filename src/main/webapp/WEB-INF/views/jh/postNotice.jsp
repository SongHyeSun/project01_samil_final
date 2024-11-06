<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../1.main/user_header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
    body {
	    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
	    margin: 0;
	    padding: 0;
	    justify-content: center;
	    align-items: center;
	    height: 100vh;
	}
	
	main {
	    background-color: #fff;
	    margin: 50px 150px;
	    border-radius: 8px;
	}
	
	h2 {
	    color: #034EA2;
	    border-bottom: 2px solid #034EA2; /* 언더라인 색상 */
	    padding-bottom: 5px; /* 텍스트와 언더라인 사이의 여백 */
	    margin-bottom: 20px; /* 아래쪽 여백 */
	    font-weight: bold; /* 글자 두께 */
	    display: inline-block; /* 텍스트 너비만큼만 표시 */
	}

		
	table {
	    margin: 20px auto;
	    width: 100%;
	    border-collapse: collapse;
	    border-radius: 8px;
	    overflow: hidden;
	    text-align: center;
	}
	
	.tg {
	    border: none;
	    border-color: #4d4d4d;
	}
	
	.tg td {
	    border-color: #007acc;
	    color: #333333;
	    overflow: hidden;
	    padding: 10px 5px;
	    word-break: normal;
	}
	
	.tg th {
	    background-color: #034EA2;
	    border-color: #005999;
	    color: #ffffff;
	    font-size: 14px;
	    font-weight: normal;
	    overflow: hidden;
	    padding: 10px 5px;
	    word-break: normal;
	}

	.tg tr:hover, table tr:hover {
		background-color: #e0e0e0; /* 호버 시 배경색 */
	}

	select {
		width: 70px;
		padding-left: 5px;
		height: 34px;
	}

    input[type="text"] {
        padding: 5px;
        width: 200px;
        height: 34px;
        margin: 0 5px;
    }

	button {
	    padding: 5px 10px;
	    border: none;
	    border-radius: 5px;
	    background-color: #034EA2;
	    color: #ffffff;
	    cursor: pointer;
	    transition: background-color 0.3s;
	}
	    
	button:hover {
		background-color: #023a8a; /* 호버 시 색상 */
	}

    a {
    	text-decoration: none;
		color: #000;
    }
	.pagination {
	    display: flex;
	    justify-content: center;
	    margin: 20px 0;
	}
    .pagination a {
		text-decoration: none;
		color: #007BFF;
        padding: 0 10px; /* 링크 좌우 여백 추가 */
        font-size: 18px;
    }

	a:hover {
        text-decoration: underline; /* 호버 시 밑줄 추가 */
    }

	.searchbox{
		display: flex;
		align-items: center;
	}
</style>
<title>공지사항</title>
</head>
<body>
<main>
	    <h2>공지게시판</h2>
	    <div style="display: flex; justify-content: space-between; align-items: center;">
			<div style="flex-grow: 1;"> <!-- 빈 공간을 차지하도록 설정 -->
				<c:if test="${emp.admin == 150 || emp.admin == 170}">
					<button onclick="location.href='writeNotice';">글작성</button>
				</c:if>
			</div>
			<form action="listSearch3" class="searchbox">
				<select name="search">
					<option value="title">제목</option>
					<option value="content">내용</option>
				</select>
				<input type="text" name="keyword" placeholder="입력하세요">
				<button type="submit">검색</button><p>
			</form>
		</div>
	
	    <c:set var="num" value="${page.total - page.start + 1}"></c:set>
	    <table class="tg" border="1">
	        <tr>
	            <th style="font-size: 18px; width: 110px;">no</th>
	            <th style="font-size: 18px;">제목</th>
	            <th style="font-size: 18px; width: 150px;">작성일</th>
	        </tr>
	        
	        <!-- 게시물 출력 -->
	        <c:if test="${empty listPosts}">
	            <tr>
	                <td colspan="3">게시물이 없습니다.</td>
	            </tr>
	        </c:if>
	
<c:forEach var="posts" items="${listPosts}" varStatus="status">

    <c:if test="${posts.isPinned == 1}">
        <tr style="background-color: ;">
            <td>
                <img src="/jh/notice.png"  style="width: 20px; height: auto;"> <!-- 이미지 삽입 -->
            </td>
            <td style="text-align: left;">
                <a href="detailPosts/${posts.postId}"><strong>[공지]&nbsp</strong>${posts.postsTitle}</a>
            </td>
            <td>${posts.creationDate}</td>
        </tr>
        <c:set var="num" value="${num - 1}"></c:set>
    </c:if>
</c:forEach>
	
	<c:forEach var="posts" items="${listPosts}" varStatus="status">
	    <c:if test="${posts.isPinned == 0 or posts.isPinned == null}">
	        <tr>
	            <td>${num}</td>
	            <td style="text-align: left;">
	                <a href="/jh/detailPosts/${posts.postId}"><strong>[공지]&nbsp</strong>${posts.postsTitle}</a>
	            </td>
	            <td>${posts.creationDate}</td>
	        </tr>
	        <c:set var="num" value="${num - 1}"></c:set>
	    </c:if>
	</c:forEach>
	        
	    </table>
	
	    <div class="pagination">
	        <c:if test="${page.startPage > page.pageBlock}">
	            <a href="postNotice?currentPage=${page.startPage - page.pageBlock}">이전</a>
	        </c:if>
	        <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
	            <a href="postNotice?currentPage=${i}">${i}</a>
	        </c:forEach>
	        <c:if test="${page.endPage < page.totalPage}">
	            <a href="postNotice?currentPage=${page.startPage + page.pageBlock}">다음</a>
	        </c:if>
	    </div>
	</main>
</body>
</html>
