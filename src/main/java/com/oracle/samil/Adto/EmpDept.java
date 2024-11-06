package com.oracle.samil.Adto;

import lombok.Data;

@Data
public class EmpDept {
	
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
	private long 	account;		// 입금계좌
	private String 	bank ;			// 은행
	private boolean delCheck;		// 삭제여부
	private int 	recentEditor;	// 최근작성자
	private String 	recentEditDate;	// 최근수정일

	private String 	deptName;		// 부서명
	private int		higherdeptno; 	// 상위부서
	private int		manager;		// 부서장사원번호
	private String	depttel;		// 부서대표번호
	private int		deptdepth;		// 부서reflev

	// 조회용
	private String	search;
	private String	keyword;
	private String	pageNum;
	private int		overtimeSal;	// 추가 수당
    private int		totalOvertime;	// 총 추가 근로
	private String	email1;
	private String	email2;
	private int approverOrder;
	// Page 정보
	private int		start;
	private int		end;
	private String	currentPage;
	
}
