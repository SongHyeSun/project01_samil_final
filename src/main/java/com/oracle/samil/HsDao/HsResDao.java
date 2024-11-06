package com.oracle.samil.HsDao;

import java.util.List;

import com.oracle.samil.Adto.ResTotal;
import com.oracle.samil.Amodel.FacilApprove;
import com.oracle.samil.Amodel.Facility;
import com.oracle.samil.Amodel.Reservation;

public interface HsResDao {
	//시설예약 대기 조회 List (사용자)
	List<ResTotal> 		listload(ResTotal res);
	
	//시설예약 완료 조회 List (사용자)
	List<ResTotal>		listFacilAcc(ResTotal faAp);
	
	//시설예약 반려 조회 List (사용자)
	List<ResTotal> 		listFacilRej(ResTotal faAp);
	
	//시설예약 예약 작성 insert (사용자)
	int 				insertReserv(ResTotal res);
	//시설예약 updateForm 에서 불러오는 detail(사용자)
	Reservation 			detailRes(int resCode);
	//시설예약 update(사용자)
	int 				updateReserv(ResTotal res);
	// 시설예약 삭제 (사용자-> 예약대기인 곳에서)
	int 				deleteRes(int resCode);
	
//----------------------------관리자------------------------------------
	
	// 관리자 시설예약 요청 list (관리자)
	List<ResTotal> 		listfacil(ResTotal resT);
	// 관리자 시설예약 승인/반려 사유 insert
	int 				insertFacil(ResTotal facAp);
	// 관리자 시설예약 승인/반려 상태 update
	int 				updateFac(ResTotal facAp);

}
