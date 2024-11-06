package com.oracle.samil.Adto;

import java.time.Duration;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=true)
public class LeaveDto extends EmpDept {
	private	String		name;					// 사원명
	private	String		deptName;				// 부서명
	private	int			admin;					// 관리자 권한
	private String		workDate;				// 근무일
	private String		clockIn;				// 출근 시간
	private String		clockOut;				// 퇴근 시간
	private String		overTime;				// 초과 근무 시간
	private Duration	totWorkTime;			// 일일 총 근무시간
	private int			attStatus;				// 근무 상태
	private int			grade;					// 직급
	private int			job;					// 직책
	private int			documentFormId;			// 문서서식 ID
	public	int			approvalNum;			// 결재문서 번호
	private int			approvalCondition;		// 결재 상태
	public	String		approvalTitle;			// 문서 제목
	private	int			furloughServiceData;	// 연차 사용일수
	private String		furloughStartDate;		// 연차 시작일
	private String		furloughEndDate;		// 연차 종료일
	private String		period;					// 조회 기간 단위

	// 페이징 작업 필드
	private	int		start;			// 시작 페이지
	private int		end;			// 마지막 페이지

	// 결재 상태를 문자열로 반환하는 메서드
    public String getApprovalStatus() {
        switch (this.approvalCondition) {
            case 100:
                return "결재요청";
            case 110:
                return "결재진행";
            case 120:
                return "결재완료";
            case 130:
                return "반려";
            default:
                return "알 수 없는 상태";
        }
    }
}