package com.oracle.samil.HsService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oracle.samil.Adto.ResTotal;
import com.oracle.samil.Amodel.FacilApprove;
import com.oracle.samil.Amodel.Facility;
import com.oracle.samil.Amodel.Reservation;
import com.oracle.samil.HsDao.HsFacilDao;
import com.oracle.samil.HsDao.HsResDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class HsResServiceImpl implements HsResService {
	
	@Autowired
	private final HsResDao hrd;
	private final HsFacilDao hfd;
	
	//시설예약 대기 조회 List (사용자)
	@Override
	public List<ResTotal> listload(ResTotal res) {
		List<ResTotal> listload = null;
		System.out.println("HsResServiceImpl listload Start...");
		listload = hrd.listload(res);
		System.out.println("HsResServiceImpl listload After...");
		return listload;
	}
	
	//시설예약 완료 조회 List (사용자)
	@Override
	public List<ResTotal> listFacilAcc(ResTotal faAp) {
		List<ResTotal> listFacilAcc = null;
		System.out.println("HsResServiceImpl listFacilAcc Start...");
		listFacilAcc = hrd.listFacilAcc(faAp);
		System.out.println("HsResServiceImpl listFacilAcc After...");
		
		return listFacilAcc;
	}
	
	//시설예약 반려 조회 List (사용자)
	@Override
	public List<ResTotal> listFacilRej(ResTotal faAp) {
		List<ResTotal> listFacilRej = null;
		System.out.println("HsResServiceImpl listFacilRej Start...");
		listFacilRej = hrd.listFacilRej(faAp);
		System.out.println("HsResServiceImpl listFacilRej After...");
		
		return listFacilRej;
	}
	
	//사용자 시설예약 작성 insert
	@Override
	public int insertReserv(ResTotal res) {
		System.out.println("HsResServiceImpl insertReserv Start...");
		int result = hrd.insertReserv(res);
		
		System.out.println("HsResServiceImpl insertReserv result-> "+result);
		System.out.println("HsResServiceImpl insertReserv insertReserv After...");
		return result;
	}

	@Override
	public List<ResTotal> facilSortlist() {
		System.out.println("HsResServiceImpl facilSortlist Start...");
		List<ResTotal> facilSort = null;
		facilSort = hfd.facilSortList();
		System.out.println("HsResServiceImpl facilSortlist facilSort.size()-> "+facilSort.size());
		
		System.out.println("HsResServiceImpl facilSortlist After...");
		return facilSort;
	}
	
	// 시설종류 수정 페이지에 불러오는 detail list (사용자)
	@Override
	public Reservation detailRes(int resCode) {
		System.out.println("HsResServiceImpl detailRes Start...");
		Reservation res = hrd.detailRes(resCode);
		
		System.out.println("HsResServiceImpl detailRes After...");
		return res;
	}
	
	// 시설예약 수정 update
	@Override
	public int updateReserv(ResTotal res) {
		System.out.println("HsResServiceImpl updateReserv Start...");
		int updateCount=0;
		updateCount = hrd.updateReserv(res);
		System.out.println("HsResServiceImpl updateReserv updateCount -> "+updateCount);
		System.out.println("HsResServiceImpl updateReserv After...");
		return updateCount;
	}
	
	//시설예약 삭제 (사용자-> 예약대기인 곳에서)
	@Override
	public int deleteRes(int resCode) {
		System.out.println("HsResServiceImpl deleteRes Start...");
		int result = 0;
		result = hrd.deleteRes(resCode);
		System.out.println("HsResServiceImpl deleteRes result-> "+result);
		
		System.out.println("HsResServiceImpl deleteRes After...");
		return result;
	}

//------------------------------------------관리자--------------------------------------
	
	//시설종류 상세정보 (updateForm에) (관리자)
	@Override
	public Facility detailfacil(int facilId) {
		System.out.println("HsResServiceImpl detailfacil Start...");
		Facility facil = hfd.detailfacil(facilId);
		System.out.println("HsResServiceImpl detailfacil End...");
		
		return facil;
	}
	
	// 관리자 시설예약 시설종류 수정완료된 폼 logic (모달창)
	@Override
	public int updateFac(Facility facil) {
		System.out.println("HsResServiceImpl updateFac Start...");
		int updateCount= hfd.updateFac(facil);
		System.out.println("HsResServiceImpl updateFac updateCount -> "+updateCount);
		System.out.println("HsResServiceImpl updateFac After...");
		return updateCount;
	}
	
	// 관리자 시설예약 추가 작성 완료된 폼 logic (모달창에서)
	@Override
	public int insertFacil(Facility facil) {
		System.out.println("HsResServiceImpl insertFacil Start...");
		int result = hfd.insertFacil(facil);
		
		System.out.println("HsResServiceImpl insertFacil result-> "+result);
		System.out.println("HsResServiceImpl insertFacil insertFacil After...");
		return result;
	}

	//관리자 시설예약 시설종류 삭제 logic
	@Override
	public int deleteFacil(int facilId) {
		System.out.println("HsResServiceImpl deleteFacil Start...");
		int result = 0;
		result = hfd.deleteFacil(facilId);
		System.out.println("HsResServiceImpl deleteFacil result-> "+result);
		
		System.out.println("HsResServiceImpl deleteFacil After...");
		return result;
	}
	
	// 관리자 시설예약 요청 list (관리자)
	@Override
	public List<ResTotal> listappr(ResTotal resT) {
		List<ResTotal> reserList = null;
		System.out.println("HsResServiceImpl listappr Start...");
		reserList = hrd.listfacil(resT);
		
		System.out.println("HsResServiceImpl listappr After...");
		return reserList;
	}
	
	// 관리자 시설예약 승인/반려 사유 insert
	@Override
	public int insertResRea(ResTotal facAp) {
		System.out.println("HsResServiceImpl insertResRea Start...");
		System.out.println("HsResServiceImpl insertResRea facAp -> "+facAp);
		int result = hrd.insertFacil(facAp);
		
		System.out.println("HsResServiceImpl insertFacil result-> "+result);
		System.out.println("HsResServiceImpl insertResRea After...");
		return 0;
	}
	
	// 관리자 시설예약 승인/반려 상태 update
	@Override
	public int updateResState(ResTotal facAp) {
		System.out.println("HsResServiceImpl updateResState Start...");
		int updateCount = hrd.updateFac(facAp);
		System.out.println("HsResServiceImpl updateFac updateCount -> "+updateCount);
		System.out.println("HsResServiceImpl updateResState After...");
		return 0;
	}

}
