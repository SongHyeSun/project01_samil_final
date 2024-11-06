package com.oracle.samil.Amodel;

import com.oracle.samil.Adto.EmpDept;
import lombok.Data;
import lombok.EqualsAndHashCode;

//시설종류TBL

@EqualsAndHashCode(callSuper=true)
@Data
public class Facility extends EmpDept {
	private int 	facilId;	//시설종류코드 (시설예약 TBL 조인)
	private String 	facilType;	//시설종류 (차량 등)
	private String 	facilName;	//시설명
}
