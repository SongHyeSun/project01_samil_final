package com.oracle.samil.JmDao;

import java.util.List;

import com.oracle.samil.Amodel.Chatroom;
import com.oracle.samil.Amodel.Emp;

public interface chatDao {
	
	List<Chatroom> listChatRoom(Chatroom chatroom);
	List<Emp> 	   listChatMember(Emp emp);
	String         getRoomName(int roomId);
	int            insertRoom(Chatroom chatroom);

}
