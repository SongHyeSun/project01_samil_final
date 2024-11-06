package com.oracle.samil.Adto;


import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=true)
public class CostCodeCost  extends EmpDept {
	private int 		codeNum; 		//비용항목코드

	private int			costYear; 		//비용문서번호
	private int 		empno;			//사원번호
	private String		costTitle;		//제목
	private int		    costMoney;   	//금액
	private String   	attach;			//첨부파일
	private int			status;			//처리상태
	private String		signdate; 		//신청날짜	
	private String		codeName;		//비용항목명칭
	private	int			costStatus;		//
}
