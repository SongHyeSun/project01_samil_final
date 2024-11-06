package com.oracle.samil.Amodel;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class ApprovalLine {
	public int 		documentFormId;			// 문서서식ID
	public int 		approvalNum;			// 결재문서번호
	public int 		approverOrder;			// 결재자순서
	public int 		empno;					// 결재자사번
	@DateTimeFormat(pattern = "yyyy/MM/dd")
	public Date 	approvalCompleteDate;	// 결재일
	public String 	approvalCnt;			// 결재코멘트
	public int 		approvalType;			// 결재유형
}
