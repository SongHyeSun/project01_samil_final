<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../1.main/user_header.jsp" %>
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
	    padding-bottom: 50px;
	}
</style>
<link rel="stylesheet" href="/css/hsCal.css">

<!-- 풀캘린더 -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
<link href='https://unpkg.com/@fullcalendar/core@6.1.15/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar@6.1.15/index.global.min.js'></script>

<!-- jquery (자동완성기능) -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	function confirmAction(formId, message) {
		if (confirm(message)) {
			document.getElementById(formId).submit();
			return true;
		} else {
			return false;
		}
	}
	
	document.addEventListener('DOMContentLoaded', function() {
	    var calendarEl = document.getElementById('calendar');
	    var calendar = new FullCalendar.Calendar(calendarEl, {
	        initialView: 'dayGridMonth',
	        locale: 'ko',
	        selectable: true,
	        droppable: false,
	        editable: false,
	        displayEventTime: false, // 시간 표시 제거
	        googleCalendarApiKey: "AIzaSyCpqE_3VYLRWTFE66yjA1R6O_eN57yG_W0",
	        eventSources: [
	            {
	                events: [
	                    <c:forEach items="${calComList}" var="attendee">
	                    {
	                        id: '${attendee.eventId}',
	                        title: '${attendee.eventTitle}',
	                        start: '${attendee.eventStartdate}',
	                        end: '${attendee.eventEnddate}',
	                        color: '#CEF279',
	                        backgroundColor: 'rgba(206, 242, 121, 0.5)',
	                        textColor: '#000000'
	                    }<c:if test="${!status.last}">,</c:if>
	                    </c:forEach>
	                    <c:forEach items="${calShaList}" var="attendee">
	                    {
	                        id: '${attendee.eventId}',
	                        title: '${attendee.eventTitle}',
	                        start: '${attendee.eventStartdate}',
	                        end: '${attendee.eventEnddate}',
	                        color: '#5AFFFF',
	                        textColor: '#000000'
	                    }<c:if test="${!status.last}">,</c:if>
	                    </c:forEach>
	                    <c:forEach items="${calPriList}" var="attendee">
	                    {
	                        id: '${attendee.eventId}',
	                        title: '${attendee.eventTitle}',
	                        start: '${attendee.eventStartdate}',
	                        end: '${attendee.eventEnddate}',
	                        color: '#FFB85A',
	                        textColor: '#000000'
	                    }<c:if test="${!status.last}">,</c:if>
	                    </c:forEach>
	                    <c:forEach items="${calVacList}" var="attendee">
	                    {
	                        id: '${attendee.eventId}',
	                        title: '${attendee.eventTitle}',
	                        start: '${attendee.eventStartdate}',
	                        end: '${attendee.eventEnddate}',
	                        color: '#FFFF5A',
	                        type: 'vacation',
	                        classNames: ['fc-event-vacation'],
	                        textColor: '#000000'
	                    }<c:if test="${!status.last}">,</c:if>
	                    </c:forEach>
	                ]
	            },
	            {
	                googleCalendarId: 'ko.south_korea.official#holiday@group.v.calendar.google.com',
	                color: 'transparent',
	                textColor: 'red',
	                className: 'ko_event'
	            }
	        ],
	
	        eventClick: function(info) {
	            if (info.event.source && info.event.source.googleCalendarId) {
	                info.jsEvent.preventDefault();
	            } else if (info.event.extendedProps.type === 'vacation') {
	                info.jsEvent.preventDefault();
	            } else {
					const eventId = info.event.id;
	                	window.location.href = '/hs/calDetail?eventId=' + eventId; // 원하는 URL로 이동
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
	
	
	function getGradeLabel(grade) {
        switch (grade) {
            case 100: return '사원';
            case 110: return '주임';
            case 120: return '대리';
            case 130: return '과장';
            case 140: return '차장';
            case 150: return '부장';
            case 160: return '사장';
            default: return '';
        }
    }

    function getJobLabel(job) {
        switch (job) {
            case 110: return '팀장';
            case 120: return '대표';
            default: return '';
        }
    }
	

	// 검색 구현
	$(document).ready(function() {
		
		$('#keyword').autocomplete ({
			source: function(request, response) {
				var keyword = request.term;	//사용자가 입력한 검색어
				var deptno = $('#deptno').val();	//선택된 부서
				//source: 입력 시 보일 목록
				console.log("keyword>>>" + keyword);
				$.ajax({
					url: "<%=request.getContextPath()%>/hs/autocomplete",
					type: "POST",
					dataType: "JSON",
					data: {	keyword: keyword,
							deptno: deptno},
					success: function(data) {
						response(
							$.map(data.resultList, function(item) {
								var gradeLabel = getGradeLabel(item.grade); // 등급 레이블
								
								return {
									label: item.empno + " " + item.name + " " + gradeLabel,
									value: item.empno
								};
							})
						)
					},
					error: function() {
						alert("오류가 발생했습니다.");
					}
				});
			},
			focus: function(event, ui) {	//방향키로 자동완성 항목 선택 가능하게
				return false;	//기본동작 방지
			},
			minLength: 0,	//최소 글자 수
			autoFocus: true, 	//첫 번쨰 항목에 자동으로 초점 맞추기
			delay: 100,	//autocomplete 지연 시간 (ms)
			select: function(evt, ui) {

			 	// label에서 사번, 이름, 등급 추출
			    var parts = ui.item.label.split(" ");
			    
			    // 사번, 이름, 등급 변수 설정 (설정해주지 않으면 검색창에 undefined 나옴)
			    var empno = parts[0]; // 사번
			    var name = parts[1]; // 이름
			    var grade = parts[2]; // 등급
			    
			    
				//사용자가 선택할 때 사번을 숨겨진 필드에 저장한다
				$("#empno").val(empno);	//사번을 숨겨진 필드에 저장
				$("#keyword").val(empno + " " + name + " " + grade);	//사번을 숨겨진 필드에 저장
				
				$('.search1').css('padding', '10px !important'); // 원하는 padding 값으로 변경
				return false;	//기본 동작을 방지
			}
		}).focus(function() {
			$(this).autocomplete("search",$(this).val());
		});
		
		$('#searchForm').submit(function(event) {
			//empno만 전송하고 다른 값들은 무시하도록 설정
			$('#deptno').val('');
			$('#keyword').val('');
			
			// empno 값만 있는지 확인
	        if ($('#empno').val() === '') {
	            alert('사원을 선택해주세요.'); // empno가 비어있을 경우 경고
	            event.preventDefault(); // 폼 전송 중단
	        }
		});
	});
</script>
<title>캘린더</title>
</head>
<body>
<main>
	<div class="container1">
			<div class="writemyplan">
				<a href="/hs/calWriteForm"><img src="/hs/1out.png" alt="일정쓰기"></a>
				<a href="/hs/cal"><img src="/hs/0out.png" alt="내일정"></a>
			</div>
	    		
	    		<table>
					<tr>
						<td class="deleteList">
							<div>
								<a href="/hs/calDelete">
									<img alt="trash" src="/hs/trashfile.png" width="30px"> 삭제된 일정 목록
								</a>
							</div>
						</td>
					</tr>
				</table>
				
					<!-- 사원검색 -->
					<div class="search1">
						<form id="searchForm" action="calSearch" method="post">
							<span><img alt="search" src="/hs/dot.png" style="width: 20px; margin-right: 5px">사원검색
								<select id="deptno">
									<option value="" selected="selected">전체</option>
									<c:forEach var="dept" items="${deptList }">
										<option value="${dept.deptno }">${dept.deptName }</option>
									</c:forEach>
								</select>
								<input type="text" id="keyword" placeholder="사원 이름을 입력하세요" autocomplete="off">
								<input type="hidden" id="empno" name="empno" value="">
								<input type="submit" value="검색">
							</span>
						</form>
					</div>
					
		</div>
		<div class="planTitle">
				${calendarData.year}년 ${calendarData.month}월 ${calendarData.day }일
		</div>
			
		<div class="container2">
			<!-- 메인페이지 -->
				<div id='calendar'></div>

				
				<!-- 카테고리 별 일정 TBL -->
				<div class="eventdetail">
				<div class="eventListT">
					<div class="eventCom">
						<table class="eventList100">
							<tr>
								<th class="one100" style="font-size: 25px; width: 10px;">●</th>
								<th>회사일정</th>
							</tr>
							<c:forEach var="event" items="${listComEvent}">
								<tr>
									<td class="one100">●</td>
									<td><a href="/hs/calDetail?eventId=${event.eventId}">${event.formatStartTime }시 ${event.eventTitle }</a></td>
								</tr>
							</c:forEach>
						</table>
					</div>
					<div class="eventOth">
						<c:forEach var="event" items="${listCategory }">
							<c:choose>
								<c:when test="${event.eventCategory == 130 }">
									<table class="eventList${event.eventCategory }">
										<tr>
											<th class="one${event.eventCategory }" style="font-size: 25px; width: 10px;">●</th>
											<th>${cateMap[event.eventCategory] }</th>
										</tr>
										<c:forEach var="event" items="${listEventMap[event.eventCategory]}">
											<tr>
												<td class="one${event.eventCategory }">●</td>
												<td>${event.eventTitle }</td>
											</tr>
										</c:forEach>
									</table>
								</c:when>
								
								
								<c:when test="${event.eventCategory == 110 }">
									<table class="eventList${event.eventCategory }">
										<tr>
											<th class="one${event.eventCategory }" style="font-size: 25px; width: 10px;">●</th>
											<th>${cateMap[event.eventCategory] }</th>
										</tr>
										<c:forEach var="event" items="${listEventMap[event.eventCategory]}">
											<tr>
												<td class="one${event.eventCategory }">●</td>
												<td><a href="/hs/calDetail?eventId=${event.eventId}">${event.formatStartTime }시 ${event.eventTitle }</a></td>
											</tr>
										</c:forEach>
									</table>
								</c:when>
								
								
								<c:when test="${event.eventCategory == 120 }">
									<table class="eventList${event.eventCategory }">
										<tr>
											<th class="one${event.eventCategory }" style="font-size: 25px; width: 10px;">●</th>
											<th>${cateMap[event.eventCategory] }</th>
										</tr>
										<c:forEach var="event" items="${listEventMap[event.eventCategory]}">
											<tr>
												<td class="one${event.eventCategory }">●</td>
												<td><a href="/hs/calDetail?eventId=${event.eventId}">${event.formatStartTime }시 ${event.eventTitle }</a></td>
											</tr>
										</c:forEach>
									</table>
								</c:when>
							</c:choose>
						</c:forEach>
					</div>
				</div>
			</div>
		
			<div class="side_right">
				<div class="calrequest">
					<p>공유일정 요청</p><br><br>
					
					<table>
						<c:forEach var="attendee" items="${listRequestAtten }">
							<tr>
								<td class="circle">●</td>
								<th>요청자</th>
								<td>${attendee.name }</td>
							</tr>
							<tr>
								<td class="circle"></td>
								<th>제목</th>
								<td>${attendee.eventTitle }</td>
							</tr>
							<tr>
								<td class="circle"></td>
								<th>일시</th>
								<td>${attendee.formatStartdate } - 
									${attendee. formatEnddate}</td>
							</tr>
							<tr>
								<td class="circle"></td>
								<th></th>
								<td class="reqbutton">
									<form action="updateAttAcc" method="post" style="display:inline;" id="accept-form-${attendee.attendId}">
										<input type="hidden" name="eventId" value="${attendee.eventId}">
										<input type="hidden" name="attendId" value="${attendee.attendId}">
										<input type="hidden" name="attendRes" value="110">
										<input type="submit" class="accept" value="수락" onclick="return confirmAction('accept-form-${attendee.attendId}', '수락하시겠습니까?')"></button>
									</form>
									<form action="updateAttRej" method="post" style="display:inline;" id="reject-form-${attendee.attendId}">
										<input type="hidden" name="eventId" value="${attendee.eventId}">
										<input type="hidden" name="attendId" value="${attendee.attendId}">
										<input type="hidden" name="attendRes" value="120">
										<input type="submit" class="reject" value="거부" onclick="return confirmAction('reject-form-${attendee.attendId}', '거부하시겠습니까?')">
									</form>
								</td>
							</tr>
						</c:forEach>
					</table>
				</div><br><br><br><br>
				
				<div class="calresponse">
					<p>내 공유요청</p><br><br>
					
					<table>
						<c:forEach var="attendee" items="${listResponseAtten}">
					        <tr>
					            <th>${attendee.name}</th>
					            <td>
					                <c:choose>
					                    <c:when test="${attendee.attendRes == 110}">
					                        <span style="color: blue;">
					                            <c:out value="${atteReMap[attendee.attendRes]}" />
					                        </span>
					                    </c:when>
					                    <c:when test="${attendee.attendRes == 120}">
					                        <span style="color: red;">
					                            <c:out value="${atteReMap[attendee.attendRes]}" />
					                        </span>
					                    </c:when>
					                    <c:otherwise>
					                        <span style="color: gray;">
					                            <c:out value="${atteReMap[attendee.attendRes]}" />
					                        </span>
					                    </c:otherwise>
					                </c:choose>
					            </td>
					        </tr>
					    </c:forEach>
					</table>
				</div>
			</div>
		</div>

	</main>
</body>
</html>