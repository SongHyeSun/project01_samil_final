package com.oracle.samil.JmService;

import java.util.List;

import com.oracle.samil.Amodel.Chatroom;
import com.oracle.samil.Amodel.Emp;

public interface chatService {
	List<Chatroom> listChatRoom(Chatroom chatroom);
	List<Emp> 	   listChatMember(Emp emp);
	String         getRoomName(int roomId);
//	Chatroom       createRoom(String name);
//	Chatroom       findById(String roomId);
	int            insertRoom(Chatroom chatroom);
}
