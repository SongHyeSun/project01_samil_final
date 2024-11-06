package com.oracle.samil.HsService;

import java.util.List;

import com.oracle.samil.Adto.ResTotal;
import com.oracle.samil.Amodel.FacilApprove;
import com.oracle.samil.Amodel.Facility;
import com.oracle.samil.Amodel.Reservation;

public interface HsResService {
	//시설예약 대기 조회 List (사용자)
	List<ResTotal> 		listload(ResTotal res);
	
	//시설예약 완료 조회 List (사용자)
	List<ResTotal> 		listFacilAcc(ResTotal faAp);
	
	//시설예약 반려 조회 List (사용자)
	List<ResTotal> 		listFacilRej(ResTotal faAp);
	// 시설종류 불러오는 List
	List<ResTotal> 		facilSortlist();
	// 사용자 시설 예약 작성 insert
	int 				insertReserv(ResTotal res);
	// 시설종류 수정 페이지에 불러오는 detail list (사용자)
	Reservation 		detailRes(int resCode);
	// 시설예약 수정 update
	int 				updateReserv(ResTotal res);
	//시설예약 삭제 (사용자-> 예약대기인 곳에서)
	int 				deleteRes(int resCode);
	
//--------------------관리자-------------------------------------------------
	
	//시설종류 상세정보 (updateForm에) (관리자)
	Facility 			detailfacil(int facilId);
	// 관리자 시설예약 시설종류 수정완료된 폼 logic (모달창)
	int 				updateFac(Facility facil);
	// 관리자 시설예약 추가 작성 완료된 폼 logic (모달창에서)
	int 				insertFacil(Facility facil);
	//관리자 시설예약 시설종류 삭제 logic
	int 				deleteFacil(int facilId);
	// 관리자 시설에약 요청 list (관리자)
	List<ResTotal> 		listappr(ResTotal resT);
	// 관리자 시설예약 승인/반려 사유 insert
	int 				insertResRea(ResTotal facAp);
	// 관리자 시설예약 승인/반려 상태 update
	int 				updateResState(ResTotal facAp);

}
