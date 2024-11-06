<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../1.main/admin_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
	/* 메인 */
	.entire {
		display: flex;
		margin: 40px 120px 20px 150px;
	}
	
	/* 링크스타일 */
	a {
		color: black;	/* 글자 색상 설정 */
		text-decoration: none;	/* 밑줄제거 */
	}
	
	a:hover {
		font-weight: bold;
	}
	
	#calendar {
		min-width: 1000px;
	}
	
	/* 2구역 */
	.container2 {
		margin: 0px 0px 0px 10px;
		font-align: center;
		flex: 1; /* 남은 공간을 모두 차지 */
	}
	
	/* 제목스타일 */
	.container2 .planTitle {
		width: 90%;
		border: 1px solid;
		border-radius: 17px;
		padding: 15px;
		background-color: rgb(110, 110, 110);
		color: white;
		display: flex;	/* 플렉스 박스를 사용하여 정렬 */
		align-items: center; /* 세로 가운데 정렬 */
		justify-content: space-between; /* 양쪽 끝으로 정렬 */
		font-weight: bold;
		font-size: 20px;
		margin-bottom: 20px;
		margin-top: 20px;
		
	}
	
	.planTitle ul {
		display: flex; /* 플렉스 박스 사용 */
		justify-content: flex-end; /* 오른쪽 정렬 */
		list-style: none; /* 기본 목록 스타일 제거 */
		padding: 0; /* 패딩 제거 */
		margin: 0; /* 마진 제거 */
	}
	
	.grid-container {
        display: grid; /* 그리드 활성화 */
        grid-template-columns: 3fr 1fr; /* 캘린더: 회사일정 비율 설정 (3:1) */
        gap: 20px; /* 간격 */
        margin-top: 20px; /* planTitle과의 간격 */
    }
	
	/* 일정추가 버튼 스타일 */
	.buttonAd {
        display: inline-block;
        padding: 5px 5px; 	/* 버튼 내부 여백 */
        background-color: rgb(110, 110, 110); 	/* 버튼 배경색 */
        color: white; 		/* 텍스트 색상 */
        text-align: center; 	/* 텍스트 중앙 정렬 */
        text-decoration: none; 	/* 링크의 기본 밑줄 제거 */
        border-radius: 5px; 	/* 둥근 모서리 */
        margin-left: 10px; 		/* 텍스트와 버튼 사이의 간격 */
        transition: background-color 0.3s; 	/* 배경색 변화에 애니메이션 추가 */
        font-weight: normal;
        font-size: 15px;
        margin-right: 20px;
    }
    
    .buttonAd:hover {
        background-color: white; /* hover 시 배경색 변화 */
        color: rgb(110, 110, 110);
        font-weight: bold;
    }
	
	

	
	
	/* 카테고리별 일정 TBL의 스타일 */
	.eventList100,
	.eventList110,
	.eventList120,
	.eventList130 {
		border: none; /* 테두리 없애기 */
		width: 230px; /* 너비를 100%로 설정 (필요에 따라 다른 값으로 변경 가능) */
		table-layout: fixed; /* 테이블 레이아웃을 고정으로 설정하여 균일한 너비 보장 */
		margin-bottom: 20px;
		max-height: 100px; /* 고정 높이 설정 (필요에 따라 조정 가능) */
    	overflow-y: auto; /* 세로 스크롤 가능 */
	}

	.eventList100 th {
		border: none; /* 테두리 없애기 */
	    width: 100%; /* 모든 셀의 너비를 100%로 설정 (필요에 따라 다른 값으로 변경 가능) */
	    padding: 8px; /* 셀 패딩 */
	    text-align: left; /* 텍스트 정렬 */
	    color: #62C15B;
		border-bottom: 1px solid;
	}

	.eventList100 td {
	   	border: none;
	    width: 100%; /* 모든 셀의 너비를 100%로 설정 (필요에 따라 다른 값으로 변경 가능) */
	    padding: 5px; /* 셀 패딩 */
	    text-align: left; /* 텍스트 정렬 */
	}
	
	
	/* 회사일정 tbl font색 */
	.eventList100 table {
		min-width: 200px;
		border: none;
	}
	
	.one100 {
		color: #1DDB16;
	}
	
	.eventList100 td {
		color: #62C15B; /* 회사 일정 색 */
		font-size: 13px;
	}
	
	/* 일정내용 */
	.eventdetail {
		width: 100%;
		border-collapse: collapse;
		text-align: center;
	}
	
	/* 캘린더 날짜 색상 */
	.fc-day-sun a {
		color: #F15F5F;
	}
	.fc-day-sat a {
		color: #4374D9;
	}
	
	.ui-autocomplete {
		padding: 10px !important;
		margin-left : 0px !important;
		max-height: 180px; /* 최대 높이 설정 */
    	overflow-y: auto; /* 스크롤이 필요할 경우 스크롤 표시 */
		
	}
	
	.ko_event {
    	pointer-events: none; /* 클릭 방지 */
	}
	
	.fc-event {
            cursor: pointer; /* 이벤트에 마우스를 올릴 때 포인터로 변경 */
    }
    
    /* 스크롤바 숨기기 */
	.fc-dayGrid-day-events::-webkit-scrollbar {
	    width: 0; /* 수직 스크롤바 숨기기 */
	    height: 0; /* 수평 스크롤바 숨기기 */
	}
	
	/* 내용이 넘칠 경우, 마우스 오버 시 스크롤바 표시 */
	.fc-dayGrid-day-events:hover::-webkit-scrollbar {
	    width: 8px; /* 수직 스크롤바 표시 */
	    height: 8px; /* 수평 스크롤바 표시 */
	}
	.fc-daygrid-event-harness {
		overflow: auto;
	}
	
	.fc-daygrid-day-events {
    	overflow: auto; /* 넘치는 부분 숨기기 */
	}
	

</style>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
<link href='https://unpkg.com/@fullcalendar/core@6.1.15/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar@6.1.15/index.global.min.js'></script>

<script type="text/javascript">
	document.addEventListener('DOMContentLoaded', function() {
	    var calendarEl = document.getElementById('calendar');
	    var calendar = new FullCalendar.Calendar(calendarEl, {
	    	initialView: 'dayGridMonth',
	    	locale: 'ko',
	    	selectable: true,
	    	droppable: false,
	    	editable: false,
	    	displayEventTime: false, // 시간 표시 제거
	    	googleCalendarApiKey : "AIzaSyCpqE_3VYLRWTFE66yjA1R6O_eN57yG_W0",
	        eventSources :[
	            {
	            	events: [
	            
	                	<c:forEach items="${calComList}" var="attendee">
	    	            	 {
	    	            		 id: '${attendee.eventId}',
	    	            		 title: '${attendee.eventTitle}',
	    	            		 start: '${attendee.eventStartdate}',
	    	            		 end: '${attendee.eventEnddate}',
	    	            		 color: '#CEF279'
	    	            	 }<c:if test="${!status.last}">,</c:if>
	                	 </c:forEach>
	            	]
	            },
	            {						
	                googleCalendarId : 'ko.south_korea.official#holiday@group.v.calendar.google.com'
	                , color: 'transparent'   // an option!
	                , textColor: 'red' // an option!
	                , className: 'ko_event'
	            }
	        ],
	        
			eventClick: function(info) {
            	
            	if (info.event.source && info.event.source.googleCalendarId) {
            		info.jsEvent.preventDefault();
            	} else {
            		// 다른 이벤트인 경우 calDetail 페이지로 이동
            		//eventId 등을 파라미터로 전달할 수 있다.
            		const eventId = info.event.id; // 또는 다른 고유 식별자 사용
					window.location.href = '/hs/adminCalDetail?eventId=' + eventId; // 원하는 URL로 이동
            	}
            }

	    });
	
	    
	    try {
	        calendar.render();
	        console.log(calendar.getEvents());
	        
	        // 일정이 렌더링된 후에 각 행의 높이를 설정
	        setTimeout(function() {
	            document.querySelectorAll('.fc-daygrid-day-events').forEach(function(day) {
	                day.style.height = '70px'; // 원하는 높이로 설정
	                day.style.width = '140px';
	            });
	        }, 0); // 최소한의 지연 후 실행
	       
	    } catch (error) {
	        console.error('Error rendering calendar:', error);
	    }
	  });
</script>
<title>admin_cal</title>
</head>
<body>
<div class="entire">
	<div class="container2">
		<div class="planTitle">
			${calendarData.year}년 ${calendarData.month}월 ${calendarData.day }일
			<a href="/hs/adminCalWriteForm" class="buttonAd">
				+ 일정추가
			</a>
		</div>
		<div class="grid-container">
			<div id='calendar'></div>
			<div class="eventCom">
				<table class="eventList100">
					<tr>
						<th class="one100" style="font-size: 25px; width: 10px;">●</th>
						<th>회사일정</th>
					</tr>
					<c:forEach var="event" items="${listComEvent}">
						<tr>
							<td class="one100">●</td>
							<td><a href="/hs/adminCalDetail?eventId=${event.eventId}">${event.formatStartTime }시 ${event.eventTitle }</a></td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
</div>
</body>
</html>