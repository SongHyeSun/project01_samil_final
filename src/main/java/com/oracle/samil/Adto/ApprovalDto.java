package com.oracle.samil.Adto;


import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;


import lombok.Data;
import lombok.EqualsAndHashCode;


@Data
@EqualsAndHashCode(callSuper=true)
public class ApprovalDto extends EmpDept {
	
	private int 		documentFormId;			// 문서서식ID
	private int 		approvalNum;			// 결재문서번호
	private String 		approvalTitle;			// 문서제목
	private int 		approvalCondition;		// 결재상태
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date		approvalDate;			// 기안일자
	private String 		imageAttachment;		// 첨부파일
	
	private int 		furloughDetailsCode;	// 항목코드
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date  	 	furloughStartDate;		// 시작일
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date   		furloughEndDate;		// 종료일
	private int 		furloughServiceData;	// 사용일수
	private String 		furloughCnt;			// 사유
	
	public int 			costDetailsCode;		// 항목코드
	public String 		costDetailsCnt;			// 내용
	public int 			costAmount;				// 금액
	
	private int 		approverOrder;			// 결재자순서
	private int 		empno;					// 결재자사번
	private String		appName;				// 결재자이름
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date 		approvalCompleteDate;	// 결재일
	private String 		approvalCnt;			// 결재코멘트
	private int 		approvalType;			// 결재유형
	
	private String		documentFormTitle;
	
	private String 		selectedApprovers;	// 결재라인 사번
	private String      selectedReferrers; // 참조라인 사번
	
	// 참고용
	private String		app;

	
}
