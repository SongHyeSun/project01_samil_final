package com.oracle.samil.Amodel;

import com.oracle.samil.Adto.EmpDept;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=true)
public class CardUse extends EmpDept {
	private int  	useNum;		// 사용순서
	private String	cardNum;	// 카드번호
	private int 	cardCost;	// 금액
	private String 	place;		// 가맹점
	private String 	useDate;	// 카드사용일자
	private String 	cardPaper;	// 증빙서류

}