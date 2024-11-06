package com.oracle.samil.Amodel;

import lombok.Data;

@Data
public class LoginInfo {
	private int empno;			// 사원번호
	private int passQuiz;		// 비밀번호 문제
	private String password;	// 비밀번호
	private String passAnswer;	// 비밀번호 답안
}
