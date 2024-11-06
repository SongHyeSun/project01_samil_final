package com.oracle.samil.Amodel;


import com.oracle.samil.Adto.EmpDept;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=true)
public class Attendance extends EmpDept {
	private int 	empno;			// 사원번호
	private String	workDate;		// 근무날짜
	private String	clockIn;		// 출근시간
	private String	clockOut;		// 퇴근시간
	private String	overTime;		// 초과근무시간
	private Integer	attStatus;		// 출근상태
	private int		editCheck;		// 수정여부
	private int		editWho;		// 수정자 사번
	private String	editWhen;		// 수정날짜

	// 조회 관련 필드
	private int		grade;			// 직급
	private int		job;			// 직책
	private	String	deptName;		// 부서명
	private	int		admin;			// 관리자 권한
	private	int		totWorkTime;	// 일일 총 근로시간
	private	String	editWhoName;	// 수정자 이름

	// 검색 관련 필드
	private String	month;			// 조회 기간 단위
	private String	startDate;		// 조회 시작일
	private String	endDate;		// 조회 종료일

	// 페이징 작업 필드
	private	int		start;			// 시작 페이지
	private int		end;			// 마지막 페이지

	// 출근 상태를 문자열로 반환하는 메서드
	public String getAttStatusString() {
	    switch (this.attStatus) {
	        case 100: return "출근";
	        case 110: return "지각";
	        case 120: return "조퇴";
	        case 130: return "지각&조퇴";
	        case 140: return "결근";
	        default: return "알 수 없는 상태";
	    }
	}
}