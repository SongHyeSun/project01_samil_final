<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅</title>

<link rel="stylesheet" href="../css/chatroom.css">
</head>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript">
	
	function getRoomInfo(pRoomId) {
	    console.log(pRoomId);
	    
	    // Ajax로 채팅방 번호를 보내고 채팅방 이름을 받음
	    $.ajax (
	    		{
			        url: "<%=request.getContextPath()%>/jm/getRoomInfo",
			        data: { roomId: pRoomId },
			        dataType: 'text',
			        success: function(roomName) {
			            //alert("success ajax data roomName -> " + roomName);
			            $('#chatName').html(roomName);
	       		 	}	
	    		}
			);
	}
	
	function openChat(pRoomId) {
		$.ajax (
	    		{
			        url: "<%=request.getContextPath()%>/jm/chat",
			        data: { roomId: pRoomId },
			        dataType: 'json',
			        success: function(roomName) {
			            //alert("success ajax data roomName -> " + roomName);
			            $('#chat_view').html(roomName);
	       		 	}	
	    		}
			);
	}
	
	// 모달 팝업창 열기, 닫기 함수
	function popOpen() {
		var modalPop = $('.modal-wrap');
	    var modalBg = $('.modal-bg'); 

	    $(modalPop).show();
	    $(modalBg).show();
	}
	
	function popClose() {
		var modalPop = $('.modal-wrap');
		var modalBg = $('.modal-bg');

	 	$(modalPop).hide();
		$(modalBg).hide();
	}
	
	$(document).ready(function() {
	    init();
	});
	
	// 채팅방 검색 함수
	function init() {
	    // keyup Event
	    $('input[name="keyword"]').on('keyup', function() {
	        var val = $(this).val();
	        if (isNullStr(val)) {
	            $('#tblRoom > tbody > tr').show();  // 검색어가 없을 경우 모든 행 보여주기
	        } else {
	            $('#tblRoom > tbody > tr').hide();  // 모든 행 숨기기

	            // 대소문자 구분 없이 필터링
	            $('#tblRoom > tbody > tr').filter(function() {
	                return $(this).text().toLowerCase().indexOf(val.toLowerCase()) > -1;
	            }).show();  // 조건에 맞는 행 보여주기
	        }
	    });
	}

	// String 값이 비어 있는 값인지 확인
	function isNullStr(str) {
	    return $.trim(str).length === 0;
	}

</script>
<body>
<header>
    <nav>
        <img class="chaticon" src="../upload/chaticon.png" width="40" height="40" > 
        <p>채팅</p>    
    </nav>
</header>
<div class="container">
    <div class="chatroom">
        <div class="makeroom">
            <button class="btn-open" type="button" onClick="popOpen()">새로 만들기</button>
            <!-- 버튼 색깔 #9DCFFF -->        
        </div>
        
        <div class="searchroom">     	
				<input type="text" class="search_input" name="keyword"  placeholder="채팅방 검색" size="45px">
	            <!-- <button type="submit" class="btn_roomsearch"></button> -->  
        </div>
        
        <div class="roomlist">
            <table id="tblRoom">
                <tbody>
            		<c:forEach var="chatroom" items="${listChatRoom}">
                		<tr>
                    		<td id="roomname" onclick="getRoomInfo(${chatroom.roomId}); openChat(${chatroom.roomId});">
                        		<img src="../upload/profile.png" width="60" height="60" />
                        		<c:out value="${chatroom.roomName} "/>
                    		</td>                    
                		</tr>                
            		</c:forEach>
        		</tbody>
            </table>
        </div>
    </div>
    <div class="right-panel">
        <div class="chat_info">
            <img src="../upload/profile.png" width="50" height="50" />      
            <span id="chatName"></span>     
        </div>

        <div id="chat_view">
            채팅창 화면
        </div>
        
        <div class="message_input">
        	<textarea class="chat_input" placeholder="메세지를 입력하세요."></textarea>
            <!-- <input class="chat_input" type="text" placeholder="메세지를 입력하세요."> -->
        </div>
    </div>
</div> 

<div class="modal-bg" onClick="popClose()">
  <div class="modal-wrap" onClick="event.stopPropagation()">
  	<div class="modal-header">
	  	<h4>채팅방 생성</h4>
	    <img class="modal-close" src="../upload/close.png" onClick="popClose()">	    
  	</div>
    
    <div class="modal-main">
      <form action="/jm/create">
        <input type="text"   name="roomName" class="input_roomname"  id="input_roomname"  placeholder="생성할 채팅방 이름">
		<input type="submit" class="btn_makeroom"   value="생성">
      </form>    
    </div>  
  </div>
</div>

<!-- 컨텍스트 메뉴 -->
<ul class="contextmenu">
  <li><a href="#">열기</a></li>
  <li><a href="#">삭제</a></li>
</ul>

</body>
</html>