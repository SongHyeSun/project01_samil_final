package com.oracle.samil.Amodel;

import lombok.Data;

// 메세지 테이블
@Data
public class Message {
	private MessageType type;
	private String		content;
	private String		sender;
	
	public enum MessageType {
		CHAT, JOIN, LEAVE
	}
}
