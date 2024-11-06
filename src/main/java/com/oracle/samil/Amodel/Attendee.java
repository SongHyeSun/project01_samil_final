package com.oracle.samil.Amodel;

import com.oracle.samil.Adto.EmpDept;

import lombok.Data;
import lombok.EqualsAndHashCode;

//참석자 TBL

@EqualsAndHashCode(callSuper=true)
@Data
public class Attendee extends EmpDept {
	
	//참석자 TBL
	private int eventId;		//일정코드(일정 TBL 조인)
	private int attendId;		//참석자 사원번호(사원TBL 조인)
	private int attendRes;		//참석자 요청응답
	private int attendRsvp;		//참석자 수정권한
    
}
