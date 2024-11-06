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

	select {
		width: 70px;
		padding-left: 5px;
		height: 34px;
	}

    input[type="text"] {
        padding: 5px;
        width: 200px;
        height: 34px;
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
input[type="text"] {
	padding: 5px;
	width: 200px;
}

	.searchbox{
		margin-bottom: -17px;
	}
</style>
<title>자유</title>
</head>
<body>
	<main>
		<h2>자유게시판</h2>
		<div style="display: flex; justify-content: space-between; align-items: center;">
		<button onclick="location.href='writeFree';">글작성</button>
		<form action="listSearch5" class="searchbox">
			<!-- 검색 기준 선택 드롭다운 -->
			<select style="" name="search">
				<option value="title">제목</option>
				<option value="content">내용</option>
				<option value="author">작성자</option>
			</select>

			<!-- 검색어 입력 필드 -->
			<input type="text" name="keyword" placeholder="입력하세요">

			<!-- 검색 버튼 -->
			<button type="submit">검색</button>
			<p>
		</form>
		</div>
<c:set var="num" value="${page.total - page.start + 1}" />

		<table class="tg" border="1">
		    <tr>
		        <th style="font-size: 18px; width: 110px;">no</th>
		        <th style="font-size: 18px;">제목</th>
		        <th style="font-size: 18px; width: 110px;">작성자</th>
		        <th style="font-size: 18px; width: 110px;">조회수</th>
		        <th style="font-size: 18px; width: 150px;">작성일</th>
		    </tr>
		    <c:forEach var="posts" items="${listPosts2}" varStatus="status">
		        <tr>
		            <td>
		                <c:choose>
		                    <c:when test="${posts.reLevel == 0}">
		                        ${num} <!-- reLevel이 0일 때 현재 번호 -->
		                        <c:set var="num" value="${num - 1}" /> <!-- 다음 번호를 위해 감소 -->
		                    </c:when>
		                    <c:otherwise>
		                      <img src="/jh/free.png"  style="width: 20px; height: auto;">
		                    </c:otherwise>
		                </c:choose>
		            </td>
		            <td style="text-align: left;">
		                <c:forEach begin="1" end="${posts.reLevel}">→</c:forEach>
		                <c:choose>
		                    <c:when test="${posts.reLevel eq 0}">
		                        <a href="/jh/detailPostsfree/${posts.postId}"><strong>[자유]&nbsp</strong>${posts.postsTitle}</a>
		                    </c:when>
		                    <c:when test="${posts.reLevel != 0}">
		                        <a href="/jh/replydetailPosts/${posts.postId}">${posts.postsTitle}</a>
		                    </c:when>
		                </c:choose>
		            </td>
		            <td>${posts.name}</td>
		            <td>${posts.postsViews}</td>
		            <td>${posts.creationDate}</td>
		        </tr>
		    </c:forEach>
		</table>

		<div class="pagination">
			<c:if test="${page.startPage > page.pageBlock}">
				<a href="postFree?currentPage=${page.startPage - page.pageBlock}">이전</a>
			</c:if>
			<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
				<a href="postFree?currentPage=${i}">${i}</a>
			</c:forEach>
			<c:if test="${page.endPage < page.totalPage}">
				<a href="postFree?currentPage=${page.startPage + page.pageBlock}">다음</a>
			</c:if>
		</div>
	</main>
</body>
</html>