package com.oracle.samil.Amodel;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class Approval {
	public int 		documentFormId;		// 문서서식ID
	public int 		approvalNum;		// 결재문서번호
	public int 		empno;				// 작성자
	public String 	approvalTitle;		// 문서제목
	public int 		approvalCondition;	// 결재상태
	@DateTimeFormat(pattern = "yyyy/MM/dd")
	public Date 	approvalDate;		// 기안일자
	public String 	imageAttachment;	// 첨부파일
}
