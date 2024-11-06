package com.oracle.samil.Amodel;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Mail {
	private int		empno;			// 사원번호
	private int		mailNo;			// 메일번호
	private String	sendAddress;	// 보낸 email
	private String	mailTitle;		// 제목
	private String	mailCnt;		// 내용
	private String 	sendDate;		// 전송일
	private int		mailRead;		// 읽을여부
	private int		mailType;		// 메일함종류
	private int		important;		// 중요메일
}
