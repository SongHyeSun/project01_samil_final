'use strict';

var usernamePage = document.querySelector('#username-page');
var chatPage = document.querySelector('#chat-page');
var usernameForm = document.querySelector('#usernameForm');
var messageForm = document.querySelector('#messageForm');
var chatRoomForm = document.querySelector("#roomForm");
var nameInput = document.querySelector("#name");
var chatRoomHeader = document.querySelector(".chat-header h2");
var chatRoomListBtn = document.querySelector(".chatRoomList-btn");
var messageInput = document.querySelector('#message');
var messageArea = document.querySelector('#messageArea');
var connectingElement = document.querySelector('.connecting');

var stompClient = null;
var username = null;

var colors = [
    '#2196F3', '#32c787', '#00BCD4', '#ff5652',
    '#ffc107', '#ff85af', '#FF9800', '#39bbb0'
];

const badWordList = ['꺼져', '등신', '존나']

function enter(event){

    var td = event.target;
    chatRoomId = td.parentElement.firstElementChild.innerText;
    chatRoomName = td.parentElement.children[1].innerText;

    chatRoomHeader.innerText = chatRoomName;

    connect();
}

function connect(event) {
    
    username = document.querySelector('#name').value.trim();

    if(username) {
        //usernamePage.classList.add('hidden');
        chatPage.classList.remove('hidden');

        var socket = new SockJS('/ws');
        stompClient = Stomp.over(socket);

        stompClient.connect({}, onConnected, onError);
    }
    event.preventDefault();
}

function onConnected() {    
    stompClient.subscribe('/topic/public', onMessageReceived);

    stompClient.send("/app/chat.addUser",
        {},
        JSON.stringify({sender: username, type: 'JOIN'})
    )

    connectingElement.classList.add('hidden');
}


function onError(error) {
    connectingElement.textContent = '웹 소켓 서버에 연결 할 수 없습니다. 새로고침 후 다시 시도해주세요!';
    connectingElement.style.color = 'red';
}

// 메세지를 보냈을 때
function sendMessage(event) {
	event.preventDefault();
	
    var messageContent = messageInput.value.trim();
    if(messageContent && stompClient) {	
			
		messageContent = filterMessage(messageContent);
		
        var chatMessage = {
            sender: username,
            content: messageContent,
            type: 'CHAT'
        };
        stompClient.send("/app/chat.sendMessage", {}, JSON.stringify(chatMessage));
        console.log('Sent message:', chatMessage);  // 메시지 전송 확인
        messageInput.value = "";
    }
    
}

// 비속어 필터링
function filterMessage(message) {
    let filteredMessage = message;
    badWordList.forEach(profanity => {
        const regex = new RegExp(profanity, 'gi'); // gi는 정규 표현식의 옵션
        // g는 문자열 내에서 모든 일치를 찾아냄
        // i는 대소문자를 구분하지 않고 찾아냄
        filteredMessage = filteredMessage.replace(regex, '***'); // 비속어를 '***'로 대체
    });
    return filteredMessage;
}

// 메세지를 받았을 때
function onMessageReceived(payload) {
	 console.log('onMessageReceived called');
    var message = JSON.parse(payload.body);
    var messageElement = document.createElement('li');
    
    console.log('Received message:', message);

    if (message.type === 'JOIN') {
        messageElement.classList.add('event-message');
        message.content = message.sender + '님이 입장했습니다.';
        
    } else if (message.type === 'LEAVE') {
        messageElement.classList.add('event-message');
        message.content = message.sender + '님이 퇴장했습니다.';
        
    } else if (message.type === 'CHAT') {		
        messageElement.classList.add('chat-message');

        // 아바타 추가
        var avatarElement = document.createElement('i');
        var avatarText = document.createTextNode(message.sender[0]);
        avatarElement.appendChild(avatarText);
        avatarElement.style['background-color'] = getAvatarColor(message.sender);
        messageElement.appendChild(avatarElement);

        // 사용자 이름 추가
        var usernameElement = document.createElement('span');
        var usernameText = document.createTextNode(message.sender);
        usernameElement.appendChild(usernameText);
        messageElement.appendChild(usernameElement);
    }

    // 메시지 텍스트 추가
    var textElement = document.createElement('p');
    var messageText = document.createTextNode(message.content);
    textElement.appendChild(messageText);
    messageElement.appendChild(textElement);
    
     console.log('Appending message to messageArea:', messageElement);

    // messageArea에 메시지 추가
    messageArea.appendChild(messageElement);
    messageArea.scrollTop = messageArea.scrollHeight; // 스크롤을 최신 메시지로 이동
}


function getAvatarColor(messageSender) {
    var hash = 0;
    for (var i = 0; i < messageSender.length; i++) {
        hash = 31 * hash + messageSender.charCodeAt(i);
    }
    var index = Math.abs(hash % colors.length);
    return colors[index];
}

usernameForm.addEventListener('submit', connect, true)
messageForm.addEventListener('submit', sendMessage, true)