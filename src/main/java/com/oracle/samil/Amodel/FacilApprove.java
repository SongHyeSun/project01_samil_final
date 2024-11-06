package com.oracle.samil.Amodel;

import com.oracle.samil.Adto.EmpDept;
import lombok.Data;
import lombok.EqualsAndHashCode;

//시설예약결재 TBL
@EqualsAndHashCode(callSuper=true)
@Data
public class FacilApprove extends EmpDept {

	private int 	resCode;	//시설예약코드
	private int 	resAdId;	//관리자사번 (사번 TBL과 JOIN)
	private String 	resDetail;	//승인 반려 사유

}
