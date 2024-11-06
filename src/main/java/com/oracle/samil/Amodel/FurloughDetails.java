package com.oracle.samil.Amodel;


import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class FurloughDetails {
	public int 		documentFormId;			// 문서서식ID
	public int 		approvalNum;			// 결재문서번호
	public int 		furloughDetailsCode;	// 항목코드
	@DateTimeFormat(pattern = "yyyy/MM/dd")
	public Date 	furloughStartDate;		// 시작일
	@DateTimeFormat(pattern = "yyyy/MM/dd")
	public Date		furloughEndDate;		// 종료일
	public int 		furloughServiceData;	// 사용일수
	public String 	furloughCnt;			// 사유
}
