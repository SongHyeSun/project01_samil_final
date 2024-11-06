package com.oracle.samil.HsDao;

import java.util.List;

import com.oracle.samil.Adto.ResTotal;
import com.oracle.samil.Amodel.Facility;

public interface HsFacilDao {
	// 시설종류 불러오는 List
	List<ResTotal>	facilSortList();
	//시설종류 상세정보 (updateForm에) (관리자)
	Facility 		detailfacil(int facilId);
	// 관리자 시설예약 시설종류 수정완료된 폼 logic (모달창) (관리자)
	int 			updateFac(Facility facil);
	// 관리자 시설예약 추가 작성 완료된 폼 logic (모달창에서)
	int 			insertFacil(Facility facil);
	//관리자 시설예약 시설종류 삭제 logic
	int 			deleteFacil(int facilId);
	
}
