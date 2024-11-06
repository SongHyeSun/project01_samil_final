package com.oracle.samil.JmService;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.oracle.samil.Amodel.Chatroom;
import com.oracle.samil.Amodel.Emp;
import com.oracle.samil.JmDao.chatDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class chatServiceImpl implements chatService {

	private final chatDao cd;
	private Map<String, Chatroom> chatRooms;
	
	// 채팅방 목록 가져오기
	@Override
	public List<Chatroom> listChatRoom(Chatroom chatroom) {
		List<Chatroom> chatRoomList = null;
		System.out.println("chatServiceImpl listChatMember Start...");
		chatRoomList = cd.listChatRoom(chatroom);
		System.out.println("chatServiceImpl chatMemberList.size() -> " + chatRoomList.size());
		return chatRoomList;
	}
	
	// Ajax 채팅방 이름 가져오기
	@Override
	public String getRoomName(int roomId) {
		System.out.println("chatServiceImpl getRoomName Start..");
		return cd.getRoomName(roomId);
	}
	
	@Override
	public List<Emp> listChatMember(Emp emp) {
		List<Emp> chatMemberList = null;
		System.out.println("chatServiceImpl listChatMember Start...");
		chatMemberList = cd.listChatMember(emp);
		System.out.println("chatServiceImpl chatMemberList.size() -> " + chatMemberList.size());
		return chatMemberList;

	}

	@Override
	public int insertRoom(Chatroom chatroom) {
		System.out.println("chatServiceImpl insertRoom Start...");
		int insertResult = cd.insertRoom(chatroom);
		
		return insertResult;
	}


//	@Override
//	public Chatroom createRoom(String name) {
//		Chatroom chatRoom = Chatroom.create(name);
//        chatRooms.put(chatRoom.getRoomId(), chatRoom);
//        return chatRoom;
//	}
//
//	@Override
//	public Chatroom findById(String roomId) {
//		return chatRooms.get(roomId);
//	}

	

}
