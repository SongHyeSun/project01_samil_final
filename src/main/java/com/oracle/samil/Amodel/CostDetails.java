package com.oracle.samil.Amodel;

import lombok.Data;

@Data
public class CostDetails {
	public int 		documentFormId;		// 문서서식ID
	public int 		approvalNum;		// 결재문서번호
	public int 		costDetailsCode;	// 항목코드
	public String 	costDetailsCnt;		// 내용
	public int 		costAmount;			// 금액
}
