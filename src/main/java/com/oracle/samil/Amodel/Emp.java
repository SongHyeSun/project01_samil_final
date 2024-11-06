package com.oracle.samil.Amodel;


import lombok.Data;

@Data
public class Emp {
	private int 	empno;			// 사원번호
	private String 	email;			// 이메일주소
	private String 	name;			// 이름
	private String 	phone;			// 전화번호
	private int 	deptno;			// 부서번호
	private int 	grade;			// 직급
	private int 	job;			// 직책
	private String 	address;		// 집주소
	private int 	status;			// 근로상태
	private int 	admin;			// 관리자권한
	private String 	image;			// 이미지명
	private String 	hiredate;		// 입사일
	private int 	totalVacation;	// 총연차수
	private int 	restVacation;	// 남은연차수
	private String 	account;		// 입금계좌
	private String 	bank ;			// 은행
	private boolean delCheck;		// 삭제여부
	private int 	recentEditor;	// 최근작성자
	private String 	recentEditDate;	// 최근수정일
	
	// email1 분리필요시만 사용
	private String 	email1;			// 이메일주소
	private String 	email2;			// 이메일주소

}
