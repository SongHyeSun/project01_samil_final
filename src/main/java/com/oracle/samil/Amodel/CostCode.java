package com.oracle.samil.Amodel;

import com.oracle.samil.Adto.EmpDept;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode( callSuper=true)
public class CostCode extends EmpDept{
	private int 	codeNum; 	// 비용항목코드
	private String 	codeName;	// 비용항목명칭
	private int 	codeDel;
}
