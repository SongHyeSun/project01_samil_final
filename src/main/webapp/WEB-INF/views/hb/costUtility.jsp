<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../1.main/user_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공과금 그래프</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.4/dist/chart.umd.min.js"></script>
    <style>
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
	    padding-bottom: 50px;
	}
	
	h2 {
	    color: #034EA2;
	    border-bottom: 2px solid #034EA2; /* 언더라인 색상 */
	    padding-bottom: 5px; /* 텍스트와 언더라인 사이의 여백 */
	    margin-bottom: 20px; /* 아래쪽 여백 */
	    font-weight: bold; /* 글자 두께 */
	    display: inline-block; /* 텍스트 너비만큼만 표시 */
	    margin-bottom: 50px;
	}
        table {
            width: 100%; /* 테이블 너비 */
            margin-top: 20px; /* 상단 마진 추가 */
            border-collapse: collapse; /* 테두리 합치기 */
        }
        th, td {
            border: 1px solid #3333CC; /* 테두리 색상 */
            padding: 10px; /* 패딩 추가 */
            text-align: center; /* 중앙 정렬 */
        }
        th {
            background-color: #3333CC; /* 헤더 배경 색상 */
            color: white; /* 헤더 글자 색상 */
        }
    </style>
</head>
<body>
    <main>
        <h2>공과금 사용 내역</h2>
        <canvas id="utilityChart"></canvas>
    </main>

    <script>
        const ctx = document.getElementById('utilityChart').getContext('2d');
        const labels = [];
        const colors = {
            '수도세': 'rgba(255, 99, 132, 0.6)',
            '전기세': 'rgba(54, 162, 235, 0.6)',
            '관리비': 'rgba(255, 206, 86, 0.6)'
        };
        
        const datasetsMap = {};

        <c:if test="${not empty utilityData}">
        <c:forEach var="utility" items="${utilityData}">
            var detailName = '${utilityMap[utility.utilityDetail]}'; // 세부 항목 이름
            var cost = ${utility.utilityCost}; // 비용
            var label = '${utility.utilityYyyymm}'; // 월
            console.log("Adding label:", label);

            // labels에 추가 (중복 체크)
            if (!labels.includes(label)) {
                console.log("Adding label:", label);
                labels.push(label);
                
                for (let key in datasetsMap) {
                    datasetsMap[key].data.push(0); // 새로 추가된 labels의 길이에 맞춰 0 추가
                }
            }

            // datasetsMap에 데이터 추가
            if (!datasetsMap[detailName]) {
                datasetsMap[detailName] = {
                    label: detailName,
                    data: new Array(labels.length).fill(0), // labels 길이만큼 0으로 초기화
                    backgroundColor: colors[detailName] || 'rgba(0, 0, 0, 0.6)',
                    borderColor: (colors[detailName] || 'rgba(0, 0, 0, 1)').replace('0.6', '1'),
                    borderWidth: 1
                };
            }
            
            // 데이터 할당
            var index = labels.indexOf(label); // index를 var로 선언
            if (index !== -1) {
                datasetsMap[detailName].data[index] += cost; // 해당 index에 비용 누적
                console.log(`Adding cost ${cost} to ${detailName} at index ${index}, new value: ${datasetsMap[detailName].data[index]}`);

            }
        </c:forEach>
    	</c:if>
        // datasets 배열로 변환
        const datasets = Object.values(datasetsMap);
        console.log(datasets); // 이 부분 추가
        const myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: datasets
            },
            options: {
                scales: {
                    x: {
                        barPercentage: 0.5,
                        categoryPercentage: 0.8
                    },
                    y: {
                        beginAtZero: true
                    }
                },
                layout: {
                    padding: {
                        left: 10,
                        right: 10,
                        top: 10,
                        bottom: 10
                    }
                }
            }
        });
    </script>
</body>
</html>
