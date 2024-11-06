package com.oracle.samil.Acontroller;

import java.util.List;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.oracle.samil.Amodel.Chatroom;
import com.oracle.samil.Amodel.Emp;
import com.oracle.samil.Amodel.Message;
import com.oracle.samil.JmService.chatService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping(value="/jm")
@RequiredArgsConstructor
public class JmChatController extends BaseController{
		
	private final chatService cs;
	//private final SimpMessageHeaderAccessor messagingTemplate;
	
	
	// 채팅방 페이지 연결
	@RequestMapping(value = "chat")
	public String listChatRoom(Chatroom chatroom, Model model) {
		System.out.println("jm chat play~");
		
		//로그인 후 empno
		Emp emp = getUser();	// BaseController에서 가져옴
		int empno = emp.getEmpno();	// empno 가져오기
		String name = emp.getName();
		model.addAttribute("username", name); // 모델에 추가
		System.out.println("ename: "+empno);
		
		// ViewResolver에 의해 jm/chatList.jsp로 이동
		return "jm/chat";

	}	
	
	// 채팅방 이름 AJAX 요청을 처리하는 메서드
	@ResponseBody
	@RequestMapping(value = "/getRoomInfo")  
	public String getRoomName(Chatroom chatroom, Model model) {
	    System.out.println("ajax 요청 처리 컨트롤러");
	    System.out.println("roomId->"+chatroom.getRoomId());  	
	    String roomName = cs.getRoomName(chatroom.getRoomId());
	    	
	    System.out.println("roomName->"+roomName);
		return  roomName;
	}
	
	// 웹소켓 STOMP
	@MessageMapping("/chat.sendMessage")
    @SendTo("/topic/public")
    public Message sendMessage(@Payload Message chatMessage) {
        return chatMessage;
    }

    @MessageMapping("/chat.addUser")
    @SendTo("/topic/public")
    public Message addUser(@Payload Message chatMessage, 
                               SimpMessageHeaderAccessor headerAccessor) {
        // Add username in web socket session
        headerAccessor.getSessionAttributes().put("username", chatMessage.getSender());
        return chatMessage;
    }		
}
