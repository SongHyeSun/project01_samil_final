package com.oracle.samil.Amodel;

import lombok.Data;

// 채팅참여 테이블

@Data
public class JoinChat {
	private int roomId;		// 채팅방 아이디
	private int empno;		// 사원 번호 (채팅 참여자)
}