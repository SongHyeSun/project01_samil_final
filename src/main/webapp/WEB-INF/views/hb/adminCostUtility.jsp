<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../1.main/admin_header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 공과금</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

	h2 {
	    color: #6E6E6E;
        padding: 20px 0;
        margin-bottom: 20px;
        text-align: center; /* 제목 중앙 정렬 */
	    font-weight: bold; /* 글자 두께 */
    }

        table {
            width: 600px;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #D9D9D9;
        }

        th, td {
            border: 1px solid #666;
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: #A0A0A0;
            color: white;
        }

        .btn-gray,
        .btn-primary {
            background-color: #A0A0A0; /* 회색 배경 */
            color: white; /* 흰색 글자 */
            border: none; /* 테두리 제거 */
        }

        .btn-gray:hover,
        .btn-primary:hover {
            background-color: #808080; /* hover 시 더 어두운 회색 */
        }
    </style>
</head>
<body>
<main>
    <h2 class="page-title">관리자 공과금 페이지</h2>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger text-center">${errorMessage}</div>
    </c:if>

    <div class="text-center mb-4">
        <button class="btn btn-gray" data-toggle="modal" data-target="#addUtilityModal">공과금 추가</button>
    </div>

    <c:if test="${not empty utilityData}">
        <table>
            <thead>
                <tr>
                    <th>해당년월</th>
                    <th>항목</th>
                    <th>비용</th>
                    <th>입력사원</th>
                    <th>첨부파일</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="utility" items="${utilityData}">
                    <tr>
                        <td>${utility.utilityYyyymm}</td>
                        <td>${utilityMap[utility.utilityDetail]}</td>
                        <td>${utility.utilityCost}</td>
                        <td>${utility.name}</td>
                        <td>
    						<a href="/hb/downloadUtilityAttach?fileName=${fn:escapeXml(utility.utilityAttach)}" class="btn btn-primary">다운로드</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

    <!-- 모달 -->
    <div class="modal fade" id="addUtilityModal" tabindex="-1" role="dialog" aria-labelledby="addUtilityModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addUtilityModalLabel">공과금 추가</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="utilityForm" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="utilityYyyymm">해당 년월:</label>
                            <input type="month" id="utilityYyyymm" name="utilityYyyymm" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <select id="utilityDetailName" name="utilityDetailName" class="form-control" required>
                                <option value="">선택하세요</option>
                                <option value="수도세">수도</option>
                                <option value="전기세">전기</option>
                                <option value="관리비">관리</option>
                            </select>
                            <label for="utilityDetail">세부코드:</label>
                            <input type="number" id="utilityDetail" name="utilityDetail" readonly="readonly">
                            <div class="text-center mb-4">
                            <button type="button" id="checkDuplicate" class="btn btn-warning">중복 확인</button>
                        	</div>
                        </div>
                        <div class="form-group">
                            <label for="empno">사원번호:</label>
                            <input type="number" id="empno" name="empno" value="${emp.empno}" class="form-control">
                        </div>
                        <div class="form-group">
                            <label for="empno">사원명:</label>
                            <input type="text" id="name" name="name" value="${emp.name}" class="form-control">
                        </div>
                        <div class="form-group">
                            <label for="utilityCost">비용:</label>
                            <input type="number" id="utilityCost" name="utilityCost" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="utilityAttach">증빙 서류:</label>
                            <input type="file" id="utilityAttach" name="utilityAttach" class="form-control" required>
                        </div>

                        
                        <button type="submit" class="btn btn-primary" disabled id="submitBtn">추가하기</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</main>

<script>
$(document).ready(function() {
    $('#utilityDetailName').change(function() {
        let utilityDetail = $(this).val();
        let detailCode = '';

        // utilityDetail에 따라 코드 설정
        switch (utilityDetail) {
            case '수도세':
                detailCode = '100';
                break;
            case '전기세':
                detailCode = '110';
                break;
            case '관리비':
                detailCode = '120';
                break;
            default:
                detailCode = '';
        }

        $('#utilityDetail').val(detailCode); // 세부코드 필드에 설정
    });

    $('#checkDuplicate').click(function() {
        let utilityYyyymm = $('#utilityYyyymm').val();
        let utilityDetail = $('#utilityDetail').val();

        if (!utilityYyyymm || !utilityDetail) {
            alert("해당 년월과 세부코드를 입력하세요.");
            return;
        }

        $.ajax({
            url: '/hb/checkDuplicate', // 중복 확인을 위한 엔드포인트
            type: 'POST',
            data: {
                utilityYyyymm: utilityYyyymm,
                utilityDetail: utilityDetail
            },
            success: function(response) {
                if (response.exists) {
                    alert("중복입니다. 다른 값을 입력하세요.");
                    $('#utilityCost').val(''); // 비용 필드 초기화
                    $('#submitBtn').prop('disabled', true); // 추가하기 버튼 비활성화
                } else {
                    alert("중복이 없습니다.");
                    $('#submitBtn').prop('disabled', false); // 추가하기 버튼 활성화
                }
            },
            error: function(xhr, status, error) {
                alert("An error occurred: " + error);
            }
        });
    });

    $('#utilityForm').on('submit', function(e) {
        e.preventDefault(); // 기본 제출 방지

        // FormData 객체 생성
        var formData = new FormData(this);

        // AJAX 요청
        $.ajax({
            url: 'adminCostUtility', // 서버 엔드포인트
            type: 'POST',
            data: formData,
            contentType: false,
            processData: false,
            success: function(response) {
                $('#addUtilityModal').modal('hide');
                location.reload(); // 페이지 새로고침
            },
            error: function(xhr, status, error) {
                alert("An error occurred: " + error); // 오류 처리
            }
        });
        $.ajax({
            url: '/hb/downloadUtilityAttach?fileName=' + encodeURIComponent(utility.utilityAttach),
            method: 'GET',
            success: function(data) {
                // 다운로드 처리
            },
            error: function(xhr) {
                // 에러 메시지 출력
                alert("Error: " + xhr.responseText);
            }
        });
    });
});
</script>
</body>
</html>
