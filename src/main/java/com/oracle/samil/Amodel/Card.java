package com.oracle.samil.Amodel;

import java.util.Date;

import com.oracle.samil.Adto.EmpDept;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=true)
public class Card extends EmpDept {
	private String	cardNum;		// 카드번호
	private String	cardBank;		// 카드사
	private int		cardPermit;		// 분실신청
	private String	cardLostDate;	// 분실신청일자
	private int		cardDelGubun;	// 삭제여부
	private String	cardDelDate;	// 삭제처리일자
	private int		empno;			// 사원번호
	

}


