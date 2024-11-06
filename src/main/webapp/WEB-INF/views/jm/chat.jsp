<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
  	<meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
      <title>채팅</title>
      <link rel="stylesheet" href="/css/chat.css" />
  </head>
  <body>
    <noscript>
      <h2>Sorry! Your browser doesn't support Javascript</h2>
    </noscript>
     
     <!-- 이름 입력창 -->
     <div id="username-page">
        <div class="username-page-container">
            <h1 class="title">${emp.name }님</h1>
            <h1 class="title">채팅방에 오신 것을 환영합니다!</h1>
            <form id="usernameForm" name="usernameForm">
                <div class="form-group">
                    <input type="text" id="name" placeholder="사용자이름" value="${dept.deptName } ${emp.name }" class="form-control" readonly="readonly" hidden="hidden"/>
                </div>
                <div class="form-group">
                    <button type="submit" class="accent username-submit">입장</button>
                </div>
            </form>
        </div>
    </div>
	
	<!-- 채팅 페이지 -->
    <div id="chat-page" class="hidden">
        <div class="chat-container">
            <div class="chat-header">
                <h2>채팅방</h2>
            </div>
            <div class="connecting">
                Connecting...
            </div>
            <ul id="messageArea">

            </ul>
            <form id="messageForm" name="messageForm">
                <div class="form-group">
                    <div class="input-group clearfix">
                        <input type="text" id="message" placeholder="메세지를 입력하세요..." autocomplete="off" class="form-control"/>
                        <button type="submit" class="primary">보내기</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.4/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <script src="/js/chat.js"></script>
    
    <script type="text/javascript">
    	
    </script>
  </body>
</html>