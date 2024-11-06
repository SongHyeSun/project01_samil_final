package com.oracle.samil.Amodel;


import lombok.Data;

// 채팅방 테이블

@Data
public class Chatroom {
	private int roomId;		// 채팅방 아이디
	private String roomName;	// 채팅방 이름
}