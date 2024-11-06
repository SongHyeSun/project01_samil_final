package com.oracle.samil.Amodel;

import com.oracle.samil.Adto.EmpDept;

import lombok.Data;
import lombok.EqualsAndHashCode;

//급여 테이블
@Data
@EqualsAndHashCode(callSuper=true)
public class Sal extends EmpDept {
	private String	salNum;			// 사원번호
	private int		empno;			// 근로년월
	private int		salBase;		// 기본급
	private int		salFood;		// 식대
	private int		salBonus;		// 상여
	private int		salNight;		// 야간수당
	private int		salTotal;		// 급여총액
	private int		taxSum;			// 공제총액
	private int		salFinal;		// 차감지급액
	private String	salDate;		// 급여일
	private int		tax;			// 소득세
	private String	bank;			// 은행
	private long	account;		// 계좌
	private String	editor;			// 작성자
	private String	editorDate;		// 작성일
	

}
